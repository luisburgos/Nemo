//
//  NavigationFlowHandler.swift
//  Nemo
//
//  Created by Luis Burgos on 11/13/18.
//  Copyright © 2018 Yellowme. All rights reserved.
//

import Foundation

class NavigationFlowHandler: FlowHandler<NemoKeys> {
    let manager: NavigationFaker!
    
    init(_ manager: NavigationFaker, exitFlow: NemoKeys) {
        self.manager = manager
        super.init(exitFlow: exitFlow)
    }
    
    override func runValidations(_ callback: FlowHandlerCallback) {
        guard !manager.shouldSendToTabBarNavigation() else {
            executeEarlyExit(callback)
            return
        }
        
        executeNext(callback)
    }
}
