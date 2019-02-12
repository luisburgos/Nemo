//
//  FlowHandler.swift
//  Legato
//
//  Base flow handler class.
//
//  Created by Luis Burgos on 7/23/18.
//  Copyright © 2018 Yellowme. All rights reserved.
//

import Foundation

/// Notifies when the chain of flow reaches the end with success.
protocol FlowHandlerCallback {
    func onEndReached()
    func onEarlyExit(flow: Any)
}

/// This class allows to create a chain of flow validation with
/// interruption callbacks.
public class FlowHandler<ExitFlow> {
    
    var next: FlowHandler?
    let exitFlow: ExitFlow
    
    public init(exitFlow: ExitFlow) {
        self.exitFlow = exitFlow
    }
    
    /// Builds chains of handler objects.
    func link(with next: FlowHandler) -> FlowHandler {
        debugPrint("On \(self) link next: \(next)")
        self.next = next
        return self.next!
    }
    
    /**
     Subclasses will implement this method with concrete validations.
     
     IMPORTANT: This method should call "executeNext" method in order to
     continue with the chain.
     
     Also you are responsible for calling the method "onEarlyExit"
     which is the interruption assigned on the concrete handler.
     
     - Parameter callback: which handles logic after validation.
     */
    func runValidations(_ callback: FlowHandlerCallback) {
        //MUST OVERRIDE
    }
    
    /***
     Runs the "runValidations" method on the next not nil handler.
     
     The chain will reach the end if there is no next handler on
     the chain.
     
     If the chain reaches the end and the success execution
     callback will be called.
     
     - Parameter callback: which handles logic after validation.
     */
    func executeNext(_ callback: FlowHandlerCallback ) {
        debugPrint("Execute: \(self)")
        if let next = next {
            next.runValidations(callback);
        } else {
            callback.onEndReached();
        }
    }
    
    /**
     Handles flow validation interruption assigned on the
     concrete handler.
     
     - Parameter callback: which handles logic after validation.
     */
    func executeEarlyExit(_ callback: FlowHandlerCallback) {
        debugPrint("Early exit on: \(self)")
        callback.onEarlyExit(flow: exitFlow);
    }
}
