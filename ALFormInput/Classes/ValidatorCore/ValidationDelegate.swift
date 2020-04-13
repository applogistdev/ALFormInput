//
//  ValidationDelegate.swift
//  
//
//  Created by AppLogist on 10.04.2020.
//

import UIKit
/**
 Protocol for `ValidationDelegate` adherents, which comes with two required methods that are called depending on whether validation succeeded or failed.
 */
public protocol ValidationDelegate {
    /**
     This method will be called on delegate object when validation is successful.
     
     - returns: No return value.
     */
    func validationSuccessful()
    /**
     This method will be called on delegate object when validation fails.
     
     - returns: No return value.
     */
    func validationFailed(_ errors: [(Validatable, ValidationError)])
}
