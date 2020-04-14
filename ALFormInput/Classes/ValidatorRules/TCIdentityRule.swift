//
//  TCIdentityRule.swift
//  ALTextFields
//
//  Created by AppLogist on 13.04.2020.
//  Copyright © 2020 AppLogist. All rights reserved.
//

import SwiftValidatorNew

/**
 The `TCIdentityRule` is a subclass of Rule that defines how a Turkish Identity number is validated.
 */
public class TCIdentityRule: Rule {
    
    /// parameter message: String of error message.
    private var message : String = "Geçerli bir T.C No giriniz "
    
    /**
     Initializes `TCIdentityRule` object with error message. Used to validate a field that requires text.
     
     - parameter message: String of error message.
     - returns: An initialized `TCIdentityRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(_ message : String = "Geçerli bir T.C No giriniz"){
        self.message = message
    }
    
    
    public func validate(_ value: String) -> Bool {
        isValid(TCKN: value)
    }
    
    public func errorMessage() -> String {
        message
    }
    
    
    func isValid(TCKN: String?) -> Bool {
        guard let TCKN = TCKN else { return false }
        let digits = TCKN.compactMap({ Int( $0.description )})
        
        if digits.count != 11{
            return false
        }
        
        if digits.first == 0 {
            return false
        }
        
        let first   = (digits[0] + digits[2] + digits[4] + digits[6] + digits[8]) * 7
        let second  = (digits[1] + digits[3] + digits[5] + digits[7])
        
        let digit10 = (first - second) % 10
        let digit11 = (digits[0] + digits[1] + digits[2] + digits[3] + digits[4] + digits[5] + digits[6] + digits[7] + digits[8] + digits[9]) % 10
        
        if (digits[10] == digit11) && (digits[9] == digit10) {
            return true
        }
        return false
    }
    
}
