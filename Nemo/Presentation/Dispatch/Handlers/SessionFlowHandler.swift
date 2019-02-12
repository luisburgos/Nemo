//
//  SessionFlowHandler.swift
//  Legato
//
//  Created by Luis Burgos on 7/23/18.
//  Copyright © 2018 Yellowme. All rights reserved.
//

import Foundation

class SessionFlowHandler: FlowHandler<NemoKeys> {
    let localManager: SessionFaker!
    
    init(_ localManager: SessionFaker, exitFlow: NemoKeys) {
        self.localManager = localManager
        super.init(exitFlow: exitFlow)
    }
    
    override func runValidations(_ callback: FlowHandlerCallback) {
        guard localManager.hasSessionStarted() else {
            executeEarlyExit(callback)
            return
        }
        
        executeNext(callback)
    }
}
