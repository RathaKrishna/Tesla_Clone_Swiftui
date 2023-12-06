//
//  AppDelegate.swift
//  TeslaApp
//
//  Created by Michael Rozenblat on 21/03/2023.
//

import Foundation
import UIKit
import Pendo

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let appKey = "APP_KEY"
        
        PendoManager.shared().setDebugMode(true)
        PendoManager.shared().setup(appKey, with: nil)
        PendoManager.shared().startSession("v61",accountId:"a5", visitorData: ["visitor5":"visitor5"], accountData: ["account5":"account5"])
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme?.range(of: "pendo") != nil {
            PendoManager.shared().initWith(url)
            return true
        }
        return true
    }
}
