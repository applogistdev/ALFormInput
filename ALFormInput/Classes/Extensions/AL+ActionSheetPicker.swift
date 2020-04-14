//
//  AL+ActionSheetPicker.swift
//  ALFormInput_Example
//
//  Created by AppLogist on 14.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ActionSheetPicker_3_0

extension ActionSheetStringPicker {
    func addButtons() {
        /// - TODO: Titles should be localized
        let doneButton = UIBarButtonItem(title: "Tamam", style: .done, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Vazgeç", style: .plain, target: nil, action: nil)
        setDoneButton(doneButton)
        setCancelButton(cancelButton)
    }
}
extension ActionSheetDatePicker {
    func addButtons() {
        /// - TODO: Titles should be localized
        let doneButton = UIBarButtonItem(title: "Tamam", style: .done, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Vazgeç", style: .plain, target: nil, action: nil)
        setDoneButton(doneButton)
        setCancelButton(cancelButton)
    }
}

extension ActionSheetMultipleStringPicker {
    func addButtons() {
        /// - TODO: Titles should be localized
        let doneButton = UIBarButtonItem(title: "Tamam", style: .done, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Vazgeç", style: .plain, target: nil, action: nil)
        setDoneButton(doneButton)
        setCancelButton(cancelButton)
    }
}
