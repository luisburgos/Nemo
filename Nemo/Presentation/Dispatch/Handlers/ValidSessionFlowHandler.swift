//
//  ValidSessionFlowHandler.swift
//  Legato
//
//  Created by Luis Burgos on 7/23/18.
//  Copyright © 2018 Yellowme. All rights reserved.
//

import Foundation

class ValidSessionFlowHandler: FlowHandler<NemoKeys> {
    let localManager: ValidSessionFaker!
    
    init(_ localManager: ValidSessionFaker, exitFlow: NemoKeys) {
        self.localManager = localManager
        super.init(exitFlow: exitFlow)
    }
    
    override func runValidations(_ callback: FlowHandlerCallback) {
        guard localManager.hasValidSession() else {
            executeEarlyExit(callback)
            return
        }
        
        executeNext(callback)
    }
}
