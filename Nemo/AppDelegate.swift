//
//  AppDelegate.swift
//  Nemo
//
//  Created by Luis Burgos on 9/3/18.
//  Copyright © 2018 Yellowme. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        buildNautilus()
        return true
    }
}

extension AppDelegate {
    internal func buildNautilus() {
        Nemo.add(
            Screen(named: .dispatch),
            Screen(named: .login),
            Screen(named: .main),
            Screen(named: .error),
            Screen(named: .mainTabBar),
            Screen(named: .account),
            Screen(named: .location),
            Screen(named: .history)
        )
    }
}

extension NemoKeys {
    static let dispatch: NemoKeys = NemoKeys("Dispatcher")
    static let login: NemoKeys = NemoKeys("Login")
    static let main: NemoKeys = NemoKeys("Main")
    static let error: NemoKeys = NemoKeys("Error")
    static let mainTabBar: NemoKeys = NemoKeys("MainTabBar")
    static let account: TabBarNemoKey = TabBarNemoKey(
        key: "Account",
        title: "Account",
        icon: "tabbar-account"
    )
    static let location: TabBarNemoKey = TabBarNemoKey(
        key: "Location",
        title: "Location",
        icon: "tabbar-location"
    )
    static let history: TabBarNemoKey = TabBarNemoKey(
        key: "History",
        title: "History",
        icon: "tabbar-history"
    )
}


