//
//  DispatchViewController.swift
//  Legato
//
//  Created by Luis Burgos on 7/23/18.
//  Copyright © 2018 Yellowme. All rights reserved.
//

import UIKit

class DispatchViewController: UIViewController, DispatchView {
    
    //MARK: - Outlets
    
    @IBOutlet weak var mainAction: UIButton!
    
    //MARK: - Attributes
    
    var presenter: DispatchViewPresenter!
    
    //MARK: - Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DispatchPresenter(view: self)
    }
    
    //MARK: - Actions
    
    @IBAction func didTapDispatch(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        presenter.decideUserMainScreen()
    }
    
    @IBAction func didChangeLoggedIn(_ sender: UISwitch) {
        SessionFaker.value = sender.isOn
    }
    
    @IBAction func didChangeValidToken(_ sender: UISwitch) {
        ValidSessionFaker.value = sender.isOn
    }
    
    @IBAction func didChangeModelAttribute(_ sender: UISwitch) {
        UserFaker.value = sender.isOn
    }
    
    @IBAction func didTabBarAsMainNavigation(_ sender: UISwitch) {
        NavigationFaker.value = sender.isOn
    }
    
    //MARK: - View
    
    func reload() {
        presenter.decideUserMainScreen()
    }
    
    func setProgress(active: Bool) {
        mainAction.alpha = active ? 0.4 : 1
        mainAction.setTitle(active ? "LOADING..." : "Dispatch!", for: .normal)
    }
    
    //MARK: - Redirection
    
    func sendToMainTabbed() {
        Nemo.root(MainTabBarViewController(screens: MainTabsConfigurator.tabs))
    }
    
    func sendToMain() {
        Nemo.go(to: .main)
    }
    
    func sendToLogin() {
        Nemo.go(to: .login)
    }
    
    func sendToError() {
        Nemo.go(to: .error)
    }
}
