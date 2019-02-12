//
//  Nemo+Transitions.swift
//  Nemo
//
//  Created by Luis Burgos on 9/2/18.
//  Copyright © 2018 Yellowme. All rights reserved.
//

import UIKit

//MARK: - Animation Types
public enum TransitionAnimationType {
    case none
    case push
}

extension UINavigationController {
    /// Executes a defined push/pop transition using the controller defined on a particular Screen
    func execute<T: UIViewController>(
        transitionFor screen: Screen,
        castingTo type: T.Type,
        animation: TransitionAnimationType = .none) {
        
        let controller = screen.asController()
        switch animation {
        case .push:
            push(viewController: controller!)
            break
        default:
            pushViewController(controller as! T, animated: true)
            break
        }
    }
}

//MARK: - Methods
fileprivate extension UINavigationController {
    
    /**
     Pop current view controller to previous view controller.
     
     - Parameter type:     transition animation type.
     - Parameter duration: transition animation duration.
     */
    func pop(transitionType type: String = kCATransitionFade, duration: CFTimeInterval = 0.5) {
        addTransition(type, duration: duration)
        popViewController(animated: false)
    }
    
    /**
     Push a new view controller on the view controllers's stack.
     
     - Parameter controller: view controller to push.
     - Parameter type: transition animation type.
     - Parameter duration: transition animation duration.
     */
    func push(viewController controller: UIViewController, type: String = kCATransitionFade, duration: CFTimeInterval = 0.5) {
        addTransition(type, duration: duration)
        pushViewController(controller, animated: false)
    }
    
    /**
     Adds a layer with the transition type defined
     */
    func addTransition(_ type: String = kCATransitionFade, duration: CFTimeInterval = 0.5) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = type
        view.layer.add(transition, forKey: nil)
    }
}
