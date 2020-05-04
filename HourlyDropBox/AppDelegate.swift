//
//  AppDelegate.swift
//  HourlyDropBox
//
//  Created by Andres Bocanumenth on 1/05/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit
import SwiftyDropbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var appCoordinator: AppCoordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DropboxManager.shared.setup()
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: self.window!)
        appCoordinator?.start()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {    
        DropboxManager.shared.handleRedirectURL(url: url, appCoordinator: appCoordinator)
        return true
    }
}

