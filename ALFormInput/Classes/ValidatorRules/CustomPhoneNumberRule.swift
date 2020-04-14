//
//  CustomPhoneNumberRule.swift
//  ALTextFields
//
//  Created by AppLogist on 13.04.2020.
//  Copyright © 2020 AppLogist. All rights reserved.
//
import PhoneNumberKit
import SwiftValidatorNew
public class CustomPhoneNumberRule: Rule {
    
    
    /// Error message to be displayed if validation fails.
    private var message : String
    
    /**
     Initializes a `CustomPhoneNumberRule` object that is used to verify that text in field is a full name.
     
     - parameter message: String of error message.
     - returns: An initialized `CustomPhoneNumberRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message : String = "Geçerli bir Telefon Numarası giriniz"){
        self.message = message
    }
    
    private lazy var phoneNumberKit = PhoneNumberKit()
    private lazy var formatter = PartialFormatter()
    
    public func validate(_ value: String) -> Bool {
        let formatted = formatter.formatPartial(value)
        guard let _ = try? phoneNumberKit.parse(formatted) else {
                return false
        }
        return true
    }
    
    public func errorMessage() -> String {
        message
    }
    
}
