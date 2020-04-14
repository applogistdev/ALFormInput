//
//  ViewController.swift
//  ALFormInput
//
//  Created by sonifex on 04/13/2020.
//  Copyright (c) 2020 sonifex. All rights reserved.
//

import UIKit
import ALFormInput
import SwiftValidatorNew

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: ALValidatableTextField!
    @IBOutlet weak var passwordTextField: ALValidatableTextField!
    @IBOutlet weak var nameTextField: ALValidatableTextField!
    @IBOutlet weak var surnameTextfield: ALValidatableTextField!
    @IBOutlet weak var phoneTextField: ALValidatableTextField!
    @IBOutlet weak var creditCardNumberTextField: ALValidatableTextField!
    @IBOutlet weak var tcIdentityNoTextField: ALValidatableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    private func setupTextFields() {
        emailTextField.setConfig(.email)
        passwordTextField.setConfig(.password)
        nameTextField.setConfig(.name)
        surnameTextfield.setConfig(.surname)
        phoneTextField.setConfig(.phoneNumber)
        phoneTextField.setFormattedPhoneNumber("+905318888741")
        creditCardNumberTextField.setConfig(.creditCardNumber)
        tcIdentityNoTextField.setConfig(.tcIdentityNo)
    }
}

