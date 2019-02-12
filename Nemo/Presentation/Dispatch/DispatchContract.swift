//
//  DispatchContract.swift
//  Legato
//
//  Created by Luis Burgos on 7/23/18.
//  Copyright © 2018 Yellowme. All rights reserved.
//

import Foundation

@objc protocol DispatchView {
    /**
     Triggers all the methods from this contract, from animations to
     display information. This methods is useful when running dispatch
     validations and you need to redirect the user.
     */
    func reload()
    
    /**
     Execute ENTER animations for view layout.
     (Optional, presenter must implment StartAwarePresenter)
     */
    @objc optional func runInitialAnimations()
    
    /**
     Execute EXIT animations for view layout.
     (Optional, presenter must implment StartAwarePresenter)
     */
    @objc optional func runExitAnimations()
    
    /**
     Executes or clears the blinking animation.
     - parameter active: value for the indicator
     */
    func setProgress(active: Bool)
    
    // MARK: - Navigation
    
    /**
     * Redirects the user to the main screen.
     */
    func sendToMain()
    
    /**
     * Redirects the user to the main tabbed screen.
     */
    func sendToMainTabbed()
    
    // HERE:
    // Below add all your "sendToScreen" methods
    // mapping each case of the "Screen" enum
    
    /**
     * Redirects the user to the login screen.
     */
    func sendToLogin()
    
    /**
     * Redirects the user to the error screen.
     */
    func sendToError()
}

protocol DispatchViewPresenter {
    
    /*
     Required init
     */
    init(view: DispatchView)
    
    /*
     Executes all flow handlers to decide which is the first
     screen the user should see inside the app.
     
     This method should setup a FLAG in order for
     the method "sendToMainScreen" to work properly.
     */
    func decideUserMainScreen()
    
    /*
     Executes a pending "transaction" inside the presenter to tell the
     view which "send" method should execute.
     */
    func sendToMainScreen()
}
