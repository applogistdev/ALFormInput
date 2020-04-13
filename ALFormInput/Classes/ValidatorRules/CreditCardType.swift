//
//  CreditCardType.swift
//  ALTextFields
//
//  Created by AppLogist on 13.04.2020.
//  Copyright © 2020 AppLogist. All rights reserved.
//

import Foundation

public enum CreditCardType: CaseIterable {
    
    case visa
    case visaElectron
    case mastercard
    case maestro
    case americanExpress
    case dinnersClub
    case discovery
    case jcb
    
    static var all: [CreditCardType] {
        return [
            .visa,
            .visaElectron,
            .mastercard,
            .maestro,
            .americanExpress,
            .dinnersClub,
            .discovery,
            .jcb
        ]
    }
    
    var pattern: String {
        switch self {
        case .visa: return "^4[0-9]{12}(?:[0-9]{3})?$"
        case .visaElectron: return "^(4026|417500|4508|4844|491(3|7))"
        case .mastercard: return "^5[1-5][0-9]{14}$"
        case .maestro: return "^(5018|5020|5038|6304|6759|676[1-3])"
        case .americanExpress: return "^3[47][0-9]{13}$"
        case .dinnersClub: return "^3(?:0[0-5]|[68][0-9])[0-9]{11}$"
        case .discovery: return "^6(?:011|5[0-9]{2})[0-9]{12}$"
        case .jcb: return "^(?:2131|1800|35\\d{3})\\d{11}$"
        }
    }
    
    var exampleValue: String {
        switch self {
        case .visa: return "4111111111111111"
        case .visaElectron: return "4026000000000002"
        case .mastercard: return "5538383883833838"
        case .maestro: return "501800000009"
        case .americanExpress: return "347000000000000"
        case .dinnersClub: return "30099999999999"
        case .discovery: return "6550000000000000"
        case .jcb: return "180000000000000"
        }
    }
}
