//
//  ALValidatableTextFieldType.swift
//  ALFormInput
//
//  Created by AppLogist on 10.04.2020.
//  Copyright © 2020 AppLogist. All rights reserved.
//

import UIKit
import SwiftValidatorNew

public enum ALValidatableTextFieldType: String {
    case email = "Email"
    case password = "Password"
    case name = "Name"
    case surname = "Surname"
    case phoneNumber = "phoneNumber"
    case tcIdentityNo = "tcIdentityNo"
    case passportNumber = "PassportNumber"
    case creditCardNumber = "CreditCardNumber"
    case datePicker = "DatePicker"
    case birthDate = "birthDate"
    case optional
    
    
    private var emailRule : EmailRule {
        EmailRule(message: "Geçersiz E-Posta Adresi".uppercased)
    }
    
    private var requiredRule: RequiredRule {
        RequiredRule(message: "Bu alan zorunludur".uppercased)
    }
    
    private func minLengthRule(_ length: Int) -> MinLengthRule {
        MinLengthRule(length: length, message: "En %ld karakter olmalıdır".uppercased)
    }
    
    private func exactLengthRule(_ length: Int) -> ExactLengthRule {
        ExactLengthRule(length: length, message: "%ld karakter olmalıdır".uppercased)
    }
    
    private func passwordRule(_ length: Int) -> PasswordRule {
        PasswordRule(regex: "^(?=.*?[A-Z]).{\(length),}$",
            message: String(format: "En az %ld karakter olmalıdır".uppercased, length))
    }
    
    public var rules : [Rule] {
        switch self {
            case .email:
                return [requiredRule, emailRule]
            case .password:
                return [requiredRule, passwordRule(6)]
            case .name, .surname:
                return [requiredRule, minLengthRule(3)]
            case .phoneNumber:
                return [requiredRule, CustomPhoneNumberRule()]
            case .creditCardNumber:
                return [requiredRule,
                        CardNumberRule(),
                        ReplacedExactLengthRule(length: 16, willRemoveString: " ")]
            case .tcIdentityNo:
                return [requiredRule,
                        exactLengthRule(11),
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
