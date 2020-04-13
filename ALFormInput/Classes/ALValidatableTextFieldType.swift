//
//  ALValidatableTextFieldType.swift
//  ALTextFields
//
//  Created by AppLogist on 10.04.2020.
//  Copyright © 2020 AppLogist. All rights reserved.
//

import UIKit

public enum ALValidatableTextFieldType: String {
    case email = "Email"
    case password = "Password"
    case name = "Name"
    case surname = "Surname"
    case phoneNumber = "phoneNumber"
    case tcIdentityNo = "tcIdentityNo"
    case passportNumber = "PassportNumber"
    case creditCardNumber = "CreditCardNumber"
    case birthDate = "birthDate"
    case optional
    
    
    public var rules : [Rule] {
        switch self {
            case .email:
                return [RequiredRule(), EmailRule()]
            case .password:
                return [RequiredRule(), PasswordRule()]
            case .name:
                return [RequiredRule(), MinLengthRule(length:3)]
            case .surname:
                return [RequiredRule(), MinLengthRule(length:3)]
            case .phoneNumber:
                return [RequiredRule(), CustomPhoneNumberRule()]
            case .creditCardNumber:
                return [RequiredRule(),
                        CardNumberRule(),
                        ReplacedExactLengthRule(length: 16, willRemoveString: " ")]
            case .tcIdentityNo:
                return [RequiredRule(),
                        ExactLengthRule(length: 11),
                        TCIdentityRule()]
            default:
                return []
        }
    }
    
    public var title : String? {
        switch self {
            case .email:
                return "E-posta"
            case .password:
                return "Parola"
            case .name:
                return "Adı"
            case .surname:
                return "Soyadı"
            case .phoneNumber:
                return "Cep Telefonu"
            case .creditCardNumber:
                return "Kart Numarası"
            case .tcIdentityNo:
                return "T.C Kimlik No"
            default:
                return nil
        }
    }
    
    public var placeholder: String? {
        switch self {
            case .creditCardNumber:
            return "**** **** **** ****"
            default:
                return title
        }
    }
    
    public var maxLength: Int? {
        switch self {
            case .creditCardNumber:
                return 19
            case .tcIdentityNo:
                return 11
            default:
                return nil
        }
    }
    
    public var keyboardType: UIKeyboardType {
        switch self {
            case .email:
                return .emailAddress
            case .name, .surname:
                return .namePhonePad
            case .phoneNumber:
                return .phonePad
            case .tcIdentityNo, .creditCardNumber:
                return .numberPad
            default:
                return .default
        }
    }
    
    public var contentType: UITextContentType? {
        switch self {
            case .email:
                return .emailAddress
            case .name:
                return .name
            case .surname:
                return .familyName
            case .phoneNumber:
                return .telephoneNumber
            case .creditCardNumber:
                return .creditCardNumber
            case .password:
                return .password
            default:
                return nil
        }
    }
}
