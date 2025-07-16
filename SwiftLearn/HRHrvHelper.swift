//
//  HRHrvHelper.swift
//  ZJHeartRate
//
//  Created by ZJS on 2023/7/18.
//

import Foundation
import Accelerate

@objcMembers class HRHrvHelper:NSObject {
    private var bpm: Int!
    private var bpmTimeList: [TimeInterval]!
    private var age = 35

    private var rrInterval = [Double]()
    var aVNN = 0.0
    var sDNN = 0.0
    var rMSSD = 0.0
    var pPN50 = 0.0
    var stress = 0.0
    var recovery = 0.0
    var energy = 0.0

    init(bpm: Int, bpmTimeList: [TimeInterval],age: Int) {
        super.init()
        self.bpm = bpm
        self.bpmTimeList = bpmTimeList
        self.age = age
        if !bpmTimeList.isEmpty {
            
            initRR()
            initAVNN()
            initSDNN()
            initRMSSD()
            initPPN50()
            initStress()
            initEnergy()
            initRecovery()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initRR() {
        var rrIntervalMsList = [Double]()
        rrInterval.removeAll()
        var oldTime: TimeInterval = 0
        for time in bpmTimeList {
            if oldTime != 0 {
                let currInterval = time - oldTime
                rrIntervalMsList.append(currInterval)
            }
            oldTime = time
        }
        let tmpList1 = filterOutliers(rrIntervals: rrIntervalMsList)
        let tmpList2 = linearInterpolation(rrIntervals: tmpList1)
        rrInterval.append(contentsOf: tmpList2.map { $0 / 1000.0 })
        print("----rrlist=\(rrInterval)")
    }

    private func filterOutliers(rrIntervals: [Double]) -> [Double] {
        let lowerBound = 300.0
        let upperBound = 2000.0
        return rrIntervals.filter { $0 >= lowerBound && $0 <= upperBound }
    }

    private func linearInterpolation(rrIntervals: [Double]) -> [Double] {
        let interpolationDensity = 6
        var interpolatedList = [Double]()
        for i in 0..<rrIntervals.count - 1 {
            let current = rrIntervals[i]
            let next = rrIntervals[i + 1]
            if abs(next - current) > current * 0.06 {
                let step = (next - current) / Double(interpolationDensity)
                for j in 0..<interpolationDensity {
                    interpolatedList.append(current + step * Double(j))
                }
            } else {
                interpolatedList.append(current)
            }
        }
        interpolatedList.append(rrIntervals.last ?? 0)
        return interpolatedList
    }

    private func initAVNN() {
        aVNN = rrInterval.reduce(0, +) / Double(rrInterval.count)
    }

    private func initSDNN() {
        let mean = aVNN
        let sumOfSquaredMeanDiff = rrInterval.map { pow($0 - mean, 2.0) }.reduce(0, +)
        sDNN = sqrt(sumOfSquaredMeanDiff / Double(rrInterval.count))
    }

    private func initRMSSD() {
        var sum = 0.0
        for i in 1..<rrInterval.count {
            let diff = rrInterval[i] - rrInterval[i - 1]
            sum += diff * diff
        }
        rMSSD = sqrt(sum / Double(rrInterval.count - 1))
    }

    private func initPPN50() {
        var count = 0
        for i in 1..<rrInterval.count {
            let diff = rrInterval[i] - rrInterval[i - 1]
            if diff > 0.05 {
                count += 1
            }
        }
        pPN50 = Double(count) / Double(rrInterval.count - 1) * 100
    }

    func getRrInterval() -> [Double] {
        return rrInterval
    }
    
//    private func initStress() {
//        let stressCa = StressCalculator.init(rrInterval: rrInterval)
//        stressCa.initStress()
//        stress = stressCa.stress
//    }


    func initStress() {
        var size = rrInterval.count
        var tmp = 0
        while (pow(2.0, Double(tmp)) < Double(size)) {
            tmp += 1
        }
        let targetSize = Int(pow(2.0, Double(tmp)))
        var list = [Double]()
        for i in 0..<targetSize {
            list.append(rrInterval.indices.contains(i) ? rrInterval[i] * 1000.0 : 0.0)
        }
        let samplingRate = 4.0
        let lfRangeStart = 0.04
        let lfRangeEnd = 0.15
        let hfRangeStart = 0.15
        let hfRangeEnd = 0.4
        let n = list.count
        
        // FFT
        let log2n = vDSP_Length(log2(Double(n)))
        let fftSetup = vDSP_create_fftsetup(log2n, FFTRadix(kFFTRadix2))!
        var realp = [Float](list.map{ Float($0) })
        var imagp = [Float](repeating: 0.0, count: n)
        var output = DSPSplitComplex(realp: &realp, imagp: &imagp)
        vDSP_fft_zip(fftSetup, &output, 1, log2n, FFTDirection(kFFTDirection_Forward))
        
        var lfPower = 0.0
        var hfPower = 0.0
        for i in 0..<n / 2 {
            let freq = Double(i) * samplingRate / Double(n)
            let power = pow(Double(output.realp[i]), 2.0) + pow(Double(output.imagp[i]), 2.0)
            if (freq >= lfRangeStart && freq <= lfRangeEnd) {
                lfPower += power
            } else if (freq >= hfRangeStart && freq <= hfRangeEnd) {
                hfPower += power
            }
        }
        
        stress = hfPower == 0.0 ? 0.0 : lfPower / hfPower
        
        // remember to destroy the setup object
        vDSP_destroy_fftsetup(fftSetup)
    }


    private func initEnergy() {
        let mhr = 220 - age
        let level = Double(bpm) * 100.0 / Double(mhr)
        let offset = min(stress * 100 / 5.0, 100.0) / 10.0
        energy = level - offset
    }

    private func initRecovery() {
        let maxBpm = 220 - age
        let minBpm = 40
        let standardBpm = max(1.0 - (Double(bpm) - Double(minBpm)) / (Double(maxBpm) - Double(minBpm)), 0.0)
        let maxRMSSD = 60.0
        let minRMSSD = 10.0
        let standardRMSSD = min((rMSSD - minRMSSD) / (maxRMSSD - minRMSSD), 1.0)
        let maxStress = 5.0
        let minStress = 0.0
        let standardStress = max(1.0 - ((stress - minStress) / (maxStress - minStress)), 0.0)
        recovery = (standardBpm + standardRMSSD + standardStress) * 100 / 3.0
    }
}

class StressCalculator {
    
    private let samplingRate: Double = 4.0
    private let lfRangeStart: Double = 0.04
    private let lfRangeEnd: Double = 0.15
    private let hfRangeStart: Double = 0.15
    private let hfRangeEnd: Double = 0.4
    
    var rrInterval: [Double]
    var stress: Double = 0.0
    
    init(rrInterval: [Double]) {
        self.rrInterval = rrInterval
    }
    
    func initStress() {
        var size = rrInterval.count
        var temp = 0
        while (pow(2.0, Double(temp)) < Double(size)) {
            temp += 1
        }
        
        let targetSize = Int(pow(2.0, Double(temp)))
        var list = Array(repeating: 0.0, count: targetSize)
        
        for i in 0..<targetSize {
            if i < size {
                list[i] = rrInterval[i] * 1000.0
            }
        }
        
        var outputData = performFFT(input: list)
        
        var lfPower = 0.0
        var hfPower = 0.0
        
        for i in 0..<targetSize / 2 {
            let freq = Double(i) * self.samplingRate / Double(targetSize)
            let power = pow(outputData.realp[i], 2.0) + pow(outputData.imagp[i], 2.0)
            
            if freq >= self.lfRangeStart && freq <= self.lfRangeEnd {
                lfPower += power
            } else if freq >= self.hfRangeStart && freq <= self.hfRangeEnd {
                hfPower += power
            }
        }
        
        if hfPower == 0.0 {
            stress = 0.0
        } else {
            stress = lfPower / hfPower
        }
    }
    
    func performFFT(input: [Double]) -> DSPDoubleSplitComplex {
        let length = vDSP_Length(log2(Double(input.count)))
        let fftSetup = vDSP_create_fftsetupD(length, FFTRadix(kFFTRadix2))
        
        var realp = [Double](repeating: 0.0, count: 1 << length)
        var imagp = [Double](repeating: 0.0, count: 1 << length)
        var output = DSPDoubleSplitComplex(realp: &realp, imagp: &imagp)
        
        input.withUnsafeBytes {
            vDSP_ctozD($0.baseAddress!.assumingMemoryBound(to: DSPDoubleComplex.self), 2, &output, 1, vDSP_Length(1 << length))
        }
        
        vDSP_fft_zripD(fftSetup!, &output, 1, length, FFTDirection(kFFTDirection_Forward))
        vDSP_destroy_fftsetupD(fftSetup)
        
        return output
    }
}

