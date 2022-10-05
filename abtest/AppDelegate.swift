//
//  AppDelegate.swift
//  abtest
//
//  Created by PNX on 2022/10/05.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    /// 메인 윈도우
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    /// 메인 네비 컨트롤러
    var ncMain: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
        self.setApplication(application)
        return true
    }
    
    func setApplication(_ application: UIApplication) {
        /// APNS 등록
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization( options: authOptions, completionHandler: { granted, error in
            if granted == true, error == nil {
                DLog("APNS Regist Complete")
            } else {
                DLog("APNS Regist Fail")
            }
        } )
        application.registerForRemoteNotifications()
        
        /// Firebase 세팅
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseConfiguration.shared.setLoggerLevel(.max)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        return false
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        // 세로방향 고정
        return UIInterfaceOrientationMask.portrait
    }
    
    /// 메인 프로세스 실행
    func startMainProcess() {
        guard let window = self.window else {
            return
        }
        let transition = CATransition()
        transition.type = .reveal
        transition.subtype = .fromRight
        transition.duration = 0.2
        window.layer.add(transition, forKey: kCATransition)
        self.ncMain = UINavigationController.init(rootViewController:  BtnViewViewController())
        self.ncMain?.isNavigationBarHidden = true
        window.rootViewController = self.ncMain
        window.makeKeyAndVisible()
    }
    
}

