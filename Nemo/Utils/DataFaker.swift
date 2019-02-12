//
//  DataFaker.swift
//  Legato
//
//  Setups:
//
//  1.- Login
//    => SessionFaker(false)
//    => SessionFaker(false), ValidSessionFaker(false)
//  2.- Error
//    => SessionFaker(true), ValidSessionFaker(true), UserFaker(false)
//  3.- Main
//    => SessionFaker(true), ValidSessionFaker(true), UserFaker(true)
//
//  Created by Luis Burgos on 7/23/18.
//  Copyright © 2018 Yellowme. All rights reserved.
//

import Foundation

/// 1st validation
class SessionFaker {
    static var value: Bool = true
    
    func hasSessionStarted() -> Bool {
        return SessionFaker.value
    }
}

/// 2nd validation
class ValidSessionFaker {
    static var value: Bool = true
    
    func hasValidSession() -> Bool {
        return ValidSessionFaker.value
    }
}

/// 3rd validation
class UserFaker {
    static var value: Bool = true
    
    func userHasSomeValidProperty() -> Bool {
        return UserFaker.value
    }
}

/// 4th validation
class NavigationFaker {
    static var value: Bool = true
    
    func shouldSendToTabBarNavigation() -> Bool {
        return NavigationFaker.value
    }
}
