//
//  ReplacedExactLengthRule.swift
//  ALTextFields
//
//  Created by AppLogist on 13.04.2020.
//  Copyright © 2020 AppLogist. All rights reserved.
//

import SwiftValidatorNew

/**
 `ReplacedExactLengthRule` is a subclass of Rule that is used to make sure a the text of a field is an exact length without spesific character
 */
public class ReplacedExactLengthRule : Rule {
    /// parameter message: String of error message.
    private var message : String = "16 karakter olmalıdır"
    /// parameter length: Integer value string length
    private var length : Int
    /// parameter string: string will be removed
    private var willRemoveString: String
    /**
     Initializes an `ExactLengthRule` object to validate the text of a field against an exact length.
     
     - parameter length: Integer value of exact string length being specified.
     - parameter message: String of error message.
     - returns: An initialized `ExactLengthRule` object, or nil if an object could not be created for some reason. that would not result in an exception.
     */
    public init(length: Int, willRemoveString: String = "", message : String = "%ld karakter olmalıdır"){
        self.length = length
        self.willRemoveString = willRemoveString
        self.message = String(format: message, self.length)
    }
    
    /**
     Used to validate a field.
     
     - parameter value: String to checked for validation.
     - returns: A boolean value. True if validation is successful; False if validation fails.
     */
    public func validate(_ value: String) -> Bool {
        let tmpValue = value.replacingOccurrences(of: willRemoveString, with: "")
        return tmpValue.count == length
    }
    
    /**
     Displays error message if a field fails validation.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}
