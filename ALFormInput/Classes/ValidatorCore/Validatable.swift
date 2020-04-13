//
//  Validatable.swift
//
//
//  Created by AppLogist on 10.04.2020.
//

import UIKit

public typealias ValidatableField = AnyObject & Validatable

public protocol Validatable {
    
    var validationText: String {
        get
    }
}

extension UITextField: Validatable {
    
    open var validationText: String {
        return text ?? ""
    }
}

extension UITextView: Validatable {
    
    public var validationText: String {
        return text ?? ""
    }
}
