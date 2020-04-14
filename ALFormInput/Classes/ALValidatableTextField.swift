//
//  ALValidatableTextFieldT.swift
//  ALFormInput
//
//  Created by AppLogist on 10.04.2020.
//  Copyright © 2020 AppLogist. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import PhoneNumberKit
import SwiftValidatorNew
import ActionSheetPicker_3_0

public class ALValidatableTextField: SkyFloatingLabelTextField {
    
    private let validator = Validator()
    private var config = ALTextFieldConfig()
    private var type = ALValidatableTextFieldType.optional
        
    private lazy var phoneNumberKit = PhoneNumberKit()
    private lazy var phoneFormatter = PartialFormatter()
    
    
    // MARK: - Properties
    private var padding: UIEdgeInsets? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var paddingNeeded: Bool = false {
        didSet {
            if paddingNeeded {
                addTarget(self, action: #selector(setPaddingForEditingTextFields), for: .editingChanged)
            } else {
                removeTarget(self, action: #selector(setPaddingForEditingTextFields), for: .editingChanged)
            }
        }
    }
    
    public init(rules: [Rule], config: ALTextFieldConfig) {
        super.init(frame: .zero)
        self.config = config
        validator.registerField(self, rules: rules)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        // Common init
        setupDefaultLook()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        // Common init
        setupDefaultLook()
    }
    
    
    public func setConfig(_ type: ALValidatableTextFieldType = .optional,
                          _ config: ALTextFieldConfig = ALTextFieldConfig(),
                          rules: [Rule] = [],
                          validateWhileTyping: Bool = false
                          ) {
        self.config = config
        self.type = type
        let tmpRules = rules.isEmpty ? type.rules : rules
        keyboardType = type.keyboardType
        textContentType = type.contentType
        isSecureTextEntry = type == .password
        title = type.title
        placeholder = type.placeholder
        if let maxLength = type.maxLength {
            self.maxLength = maxLength
        }
        if type == .phoneNumber {
            addTarget(self, action: #selector(formatPhoneNumber(_:)), for: .editingChanged)
        }
        if type == .creditCardNumber {
            addTarget(self, action: #selector(formatCreditCardString(_:)), for: .editingChanged)
        }
        
        if type == .datePicker {
            delegate = self
        }
        
        validator.registerField(self, rules: tmpRules)
    }
    
    
    private func setupDefaultLook() {
        titleFont = config.titleFont
        placeholderFont = config.placeholderFont
        setTitleVisible(config.isTitleVisible)
        tintColor = config.tintColor
        textColor = config.textColor
        placeholderColor = config.placeholderColor
        lineColor = config.lineColor
        selectedTitleColor = config.selectedTitleColor
        selectedLineColor = config.selectedLineColor
        titleColor = config.titleColor
        
        errorColor = config.errorColor
        textErrorColor = config.textErrorColor
        lineErrorColor = config.lineErrorColor
        titleErrorColor = config.titleErrorColor
        addTarget(self, action: #selector(resignFirstResponder), for: .editingDidEndOnExit)
        addTarget(self, action: #selector(textFieldValidateAction(_:)), for: config.validateEventType)
        setupValidator()
    }
    
    @objc private func formatCreditCardString(_ textField: UITextField) {
        let creditCardString = textField.text ?? ""
        let trimmedString = creditCardString.components(separatedBy: .whitespaces).joined()

        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""

        if !arrOfCharacters.isEmpty {
            for index in 0...arrOfCharacters.count-1 {
                modifiedCreditCardString.append(arrOfCharacters[index])
                if (index+1) % 4 == 0 && index+1 != arrOfCharacters.count {
                    modifiedCreditCardString.append(" ")
                }
            }
        }
        textField.text = modifiedCreditCardString
    }
    
    @objc private func formatPhoneNumber(_ textField: SkyFloatingLabelTextField) {
        self.text = phoneFormatter.formatPartial(self.text ?? "")
    }
    
    @objc private func textFieldValidateAction(_ textfield: UITextField) {
        guard let textField = textfield as? ALValidatableTextField else { return }
        
        validator.validateField(textField){ error in
            if error == nil {
                dump("Success")
                textField.errorMessage = nil
            } else {
                dump("Error occurred")
                // Validation error occurred
            }
        }
    }
    
    private func setupValidator() {
        validator.styleTransformers(success: { (validationRule) in
            if let textField = validationRule.field as? SkyFloatingLabelTextField {
                if textField.errorMessage == nil {
                    return
                }
                self.titleLabel.alpha = 0.0
                UIView.animate(withDuration: 0.4) {
                    self.titleLabel.alpha = 1.0
                    textField.errorMessage = nil
                }
            }
            
            if let textField = validationRule.field as? UITextView {
                textField.layer.borderColor = self.config.errorColor.cgColor
                textField.layer.borderWidth = 0.5
            }
        }) { (validationError) in
            print(validationError.errorMessage)
            
            if let textField = validationError.field as? SkyFloatingLabelTextField {
                if textField.errorMessage == validationError.errorMessage {
                    textField.errorMessage = validationError.errorMessage
                    return
                }
                self.titleLabel.alpha = 0.0
                UIView.animate(withDuration: 0.4) {
                    self.titleLabel.alpha = 1.0
                    textField.errorMessage = validationError.errorMessage
                }
            }
            if let textField = validationError.field as? UITextView {
                textField.layer.borderColor = self.config.errorColor.cgColor
                textField.layer.borderWidth = 1.0
            }
        }
    }
    
    public func setFormattedPhoneNumber(_ phoneNumber: String) {
        if type != .phoneNumber {
            return
        }
        guard let parsed = try? phoneNumberKit.parse(phoneNumber) else {
            return
        }
        let formattedPhoneNumber = phoneNumberKit.format(parsed, toType: .national)
        text = formattedPhoneNumber
    }
    
    public func get(_ phoneNumber: String, for region: String = "TR") -> String? {
        if type != .phoneNumber { return nil }
        do {
            let formatted = phoneFormatter.formatPartial(text ?? "")
            let phoneNumber = try phoneNumberKit.parse(formatted, withRegion: region, ignoreType: true)
            return "\(phoneNumber.nationalNumber)"
        } catch {
            print("Generic parser error")
        }
        return nil
    }
    
    
    func validationSuccessful() {
        // submit the form
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        // turn the fields to red
        for (field, error) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = config.errorColor.cgColor
                field.layer.borderWidth = 1.0
            }
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.isHidden = false
        }
    }
    
    /// Gets called when editing starts on a paddingNeeded enabled textfield
    @objc private func setPaddingForEditingTextFields() {
        let editingPad = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        !(text?.isEmpty ?? true) ? setPadding(editingPad) : setPadding()
    }
    
    /// Default padding is --> top: 4, left: 0, bottom: 4, right: 0
    private func setPadding(_ padding: UIEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)) {
        self.padding = padding
    }
}
// MARK: - UITextFieldDelegate
extension ALValidatableTextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if type == .datePicker {
            
            return false
        }
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        //
    }
}

// MARK: - TextField Padding
extension ALValidatableTextField {
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        paddingNeeded ? bounds.insetBy(dx: padding?.top ?? 0, dy: padding?.bottom ?? 0) : super.textRect(forBounds: bounds)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        paddingNeeded ? bounds.insetBy(dx: padding?.top ?? 0, dy: padding?.bottom ?? 0) : super.textRect(forBounds: bounds)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        paddingNeeded ? bounds.insetBy(dx: padding?.top ?? 0, dy: padding?.bottom ?? 0) : super.textRect(forBounds: bounds)
    }
}
