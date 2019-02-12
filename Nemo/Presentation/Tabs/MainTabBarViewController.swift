//
//  MainTabBarViewController.swift
//  Nemo
//
//  Created by Luis Burgos on 11/13/18.
//  Copyright © 2018 Yellowme. All rights reserved.
//

import UIKit

class MainTabsConfigurator {
    //NOTE: Maybe change to a function which uses a flag parameter to build the
    // tab nemo keys array
    static var tabs: [TabBarNemoKey] {
        return [
            .account,
            .location,
            .history
        ]
    }
}

class MainTabBarViewController: UITabBarController {
    
    var screens: [TabBarNemoKey]!
    
    //MARK: - Initialization
    
    init(screens: [TabBarNemoKey]) {
        self.screens = screens
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = Nemo.tabs(for: screens)
        title = screens.first?.title
        delegate = self
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        title = screens[tabBarController.selectedIndex].title
    }
}

