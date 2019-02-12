//
//  FetchUserFlowHandler.swift
//  Legato
//
//  Created by Luis Burgos on 7/23/18.
//  Copyright © 2018 Yellowme. All rights reserved.
//

import Foundation

class FetchUserFlowHandler: FlowHandler<NemoKeys> {
    let localManager: UserFaker!
    
    init(_ localManager: UserFaker, exitFlow: NemoKeys) {
        self.localManager = localManager
        super.init(exitFlow: exitFlow)
    }
    
    override func runValidations(_ callback: FlowHandlerCallback) {
        guard localManager.userHasSomeValidProperty() else {
            executeEarlyExit(callback)
            return
        }
        
        executeNext(callback)
    }
}
