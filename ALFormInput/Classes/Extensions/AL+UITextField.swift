//
//  AL+UITextField.swift
//  ALTextFields
//
//  Created by AppLogist on 13.04.2020.
//  Copyright © 2020 AppLogist. All rights reserved.
//

import UIKit
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
               return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        guard let t = textField.text else { return }
        textField.text = String(t.prefix(maxLength))
    }
}
