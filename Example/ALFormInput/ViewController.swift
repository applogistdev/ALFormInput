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
import AlExtensions
import FontAwesome_swift

struct Person: Codable, ALPickable {
    var stringForShowingInPickerView: String? {
        return name
    }
    
    let name: String?
    let age: Int?
}

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: ALValidatableTextField!
    @IBOutlet weak var passwordTextField: ALValidatableTextField!
    @IBOutlet weak var nameTextField: ALValidatableTextField!
    @IBOutlet weak var surnameTextfield: ALValidatableTextField!
    @IBOutlet weak var phoneTextField: ALValidatableTextField!
    @IBOutlet weak var creditCardNumberTextField: ALValidatableTextField!
    @IBOutlet weak var tcIdentityNoTextField: ALValidatableTextField!
    @IBOutlet weak var datePicker: ALDatePicker!
    @IBOutlet weak var objectPicker: ALObjectPicker!
    @IBOutlet weak var monthAndYearPicker: ALMonthAndYearPicker!
    
    
    let persons = [Person(name: "Ahmet", age: 15), Person(name: "Mehmet", age: 16), Person(name: "Soner", age: 57)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    private func setupTextFields() {

        
        emailTextField.setTypesAndRules(.email)
        emailTextField.fontAwesomeImage = .envelope
        passwordTextField.setTypesAndRules(.password)
        nameTextField.setTypesAndRules(.name)
        nameTextField.fontAwesomeImage = .user
        surnameTextfield.setTypesAndRules(.surname)
        surnameTextfield.fontAwesomeImage = .user
        
        // Set spesific configuration
        let config = ALTextFieldConfig()
        config.errorColor = .purple
        phoneTextField.setConfig(config)
        
        phoneTextField.setTypesAndRules(.phoneNumber)
        phoneTextField.fontAwesomeImage = .mobileAlt
        phoneTextField.fontAwesomeStyle = .solid
        phoneTextField.setFormattedPhoneNumber("+905318888741")
        
        
        creditCardNumberTextField.setTypesAndRules(.creditCardNumber)
        tcIdentityNoTextField.setTypesAndRules(.tcIdentityNo)
        
        // Date picker
        datePicker.setConfig()
        datePicker.title = "Doğum Tarihi"
        datePicker.placeholder = "Doğum Tarihi için tıklayınız"
        datePicker.setupPicker(pickerMode: .date, dateShowFormat: "d MMMM yyyy")
        datePicker.datePickerDelegate = self
        
        objectPicker.title = "Yolcular"
        objectPicker.placeholder = "Yolcu seçmek için tıklayınız"
        objectPicker.setupPicker(objects: persons)
        objectPicker.objectPickerDelegate = self
    
        monthAndYearPicker.title = "Son Kullanma Tarihi"
        monthAndYearPicker.placeholder = "Son Kullanma Tarihini Seçiniz"
        monthAndYearPicker.datePickerDelegate = self
    }
}

// MARK: - ALDatePickerDelegate'
extension ViewController: ALDatePickerDelegate {
    func didSelectDate(_ view: ALDatePicker, selectedDate: Date) {
        // You can handle selected date
    }
}

// MARK: - ALObjectPickerDelegate'
extension ViewController: ALObjectPickerDelegate {
    func didSelectObject(_ view: ALObjectPicker, selectedObject: ALPickable, selectedIndex: Int) {
        // You can handle selected object
    }
}

