//
//  Nemo.swift
//  Nemo
//
//  Created by Luis Burgos on 9/2/18.
//  Copyright © 2018 Yellowme. All rights reserved.
//

import UIKit

public class NemoKeys: CustomStringConvertible {
    private let key: String
    
    public init(_ key: String) {
        self.key = key
    }
    
    public var description: String {
        return key
    }
}

public final class TabBarNemoKey: NemoKeys {
    let icon: String
    let title: String
    
    public init(key: String, title: String, icon: String) {
        self.title = title
        self.icon = icon
        super.init(key)
    }
}

/// Representes a ViewController inside an Storyboard which should be
/// mapped to a UI screen definition.
///
/// Also provides a custon init which adopts "ViewController" prefix nomenclature and
/// takes a single param that represents the name of the Storybaord
/// containing the controller with the following name structure:
///
/// Controller = "<NAME>" + "ViewController"
///
public struct Screen {
    let key: String
    let controllerName: String
    let storyboard: String
    let isEmded: Bool
    
    public init(_ named: NemoKeys, controller: String, embed: Bool) {
        self.key = named.description
        self.controllerName = controller
        self.storyboard = named.description
        self.isEmded = embed
    }
    
    public init(_ named: NemoKeys, controller: String) {
        self.init(named, controller: controller, embed: false)
    }
    
    public init(named: NemoKeys, embed: Bool = false) {
        self.init(named, controller: "\(named)ViewController", embed: embed)
    }
    
    func asController(embedInNavigation: Bool = false) -> UIViewController? {
        let storyboard = UIStoryboard(name: self.storyboard, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: self.controllerName)
        if embedInNavigation {
            return UINavigationController(rootViewController: controller)
        }
        return controller
    }
}

/// Define all aplication navigation that depends on storyboards
///
/// Provides "embedCases" array which are concrete controllers that
/// must be considered to be wrapped on a navigation controller.
open class Nemo {
    private static var screens: [String : Screen] = [:]
    
    class func add(_ newScreens: Screen...) {
        for screen in newScreens {
            screens[screen.key] = screen
        }
    }
    
    class func go(to screenKey: NemoKeys) {
        Nemo.root(Nemo.direction(for: screenKey)!)
    }
    
    class func direction(for screenKey: NemoKeys) -> UIViewController? {
        let key = screenKey.description
        guard let screen = screens[key] else {
            fatalError("You should register a Screen with \(key) id using 'add(screen:)' method")
        }
        return screen.asController(embedInNavigation: screen.isEmded)
    }
    
    class func tabs(for screenKeys: [TabBarNemoKey]) -> [UIViewController] {
        return screenKeys.enumerated().map({ index, nemoKey in
            let controller = Nemo.direction(for: nemoKey)!
            controller.tabBarItem = UITabBarItem(
                title: nemoKey.title,
                image: UIImage(named: nemoKey.icon),
                tag: index
            )
            return controller
        })
    }
}

//MARK: - Root Helper
extension Nemo {
    class func root(_ controller: UIViewController?, animatesTransition: Bool = true){
        guard controller != nil else {
            fatalError("Controller MUST not be nil")
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.window == nil {
            print("Window on delegate is nil, creating new main screen with bounds")
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        appDelegate.window?.rootViewController = controller
        
        UIView.transition(
            with: appDelegate.window!,
            duration: animatesTransition ? 0.5 : 0.0,
            options: .transitionCrossDissolve,
            animations: {
                appDelegate.window?.makeKeyAndVisible()
        },
            completion: nil
        )
    }
}
