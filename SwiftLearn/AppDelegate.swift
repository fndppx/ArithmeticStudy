//
//  AppDelegate.swift
//  SwiftLearn
//
//  Created by ZJS on 2023/8/9.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 创建窗口
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 创建根视图控制器
        let viewController = ViewController()
        
        // 创建导航控制器并设置根视图控制器
        let navigationController = UINavigationController(rootViewController: viewController)
        
        // 设置窗口的根视图控制器
        window?.rootViewController = navigationController
        
        // 显示窗口
        window?.makeKeyAndVisible()
        
        return true
    }
}



