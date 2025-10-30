//
//  ViewController.swift
//  SwiftLearn
//
//  Created by ZJS on 2023/8/9.
//
//这个文件是用来学习常用ios面试算法
import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let items = ["算法学习", "Swift语法学习"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift学习"
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            // 跳转到算法学习页面
            let arithmeticVC = ArithmeticLearnOC()
            navigationController?.pushViewController(arithmeticVC, animated: true)
        } else {
            
            let swiftGrammarVC = SwiftGrammarVC()
            navigationController?.pushViewController(swiftGrammarVC, animated: true)
        }
    }
}

