//
//  CardNumberRule.swift
//  ALTextFields
//
//  Created by AppLogist on 13.04.2020.
//  Copyright © 2020 AppLogist. All rights reserved.
//

import Foundation
/**
 `CardNumberRule` is a subclass of Rule that defines how a credit card number is validated.
 */
public class CardNumberRule: Rule {
    
    /// Error message to be displayed if validation fails.
    private var message : String
    
    /**
     Initializes a `CardNumberRule` object that is used to verify that text in field is a full name.
     
     - parameter message: String of error message.
     - returns: An initialized `CardNumberRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(message : String = "Geçerli bir kart numarası giriniz"){
        self.message = message
    }
    
    func isCreditCardNumberValid(value: String?) -> Bool {
        // Sadece birinden geçmesi yeterli
        guard var value = value else { return false }
        value = value.replacingOccurrences(of: " ", with: "")
        let matchedTypes = CreditCardType.all.filter {
            do {
                let regex = try NSRegularExpression(pattern: $0.pattern,
                                                    options: .caseInsensitive)
                let hasMatches = regex.matches(in: value,
                                            options: [],
                                            range: NSMakeRange(0, value.count)).count > 0
                return hasMatches
            } catch {
                return false
            }
        }
        
        return !matchedTypes.isEmpty
    }
    
    public func validate(_ value: String) -> Bool {
        isCreditCardNumberValid(value: value)
    }
    
    public func errorMessage() -> String {
        message
    }
}
