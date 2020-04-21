//
//  ALStringPicker.swift
//  ALFormInput_Example
//
//  Created by AppLogist on 14.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftValidatorNew
import ActionSheetPicker_3_0
import AlExtensions

public protocol ALPickable {
    var stringForShowingInPickerView: String? { get }
}

public protocol ALObjectPickerDelegate: class {
    func didSelectObject(_ view: ALObjectPicker, selectedObject: ALPickable, selectedIndex: Int)
}

public class ALObjectPicker: ALValidatableTextField {
    
    weak var objectPickerDelegate: ALObjectPickerDelegate?
    private var objects : [ALPickable]?
    private var selectedObject: ALPickable?
    
    public override init(rules: [Rule], config: ALTextFieldConfig) {
        super.init(rules: rules, config: config)
        delegate = self
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        delegate = self
    }
    
    public func setupPicker(objects: [ALPickable]? = nil, selectedObject: ALPickable? = nil) {
        self.objects = objects
        self.selectedObject = selectedObject
        if let selectedObject = selectedObject {
            text = selectedObject.stringForShowingInPickerView
        }
    }
    
    private func showActionSheetStringPicker() {
        guard let objects = objects, !objects.isEmpty else {
            assertionFailure("Strings array must be set and must not be empty")
            return
        }
        /// - TODO: This is negotiable (What if picker view can contains same strings?)
        let initialSelection = Int(objects.firstIndex(where: { $0.stringForShowingInPickerView == selectedObject?.stringForShowingInPickerView }) ?? 0)
        let rows = objects.compactMap{ $0.stringForShowingInPickerView ?? ""}
        let picker = ActionSheetStringPicker(title: title,
                                             rows: rows,
                                             initialSelection: initialSelection,
                                             doneBlock: { [weak self] (_, selectedIndex, _) in
                                                guard let self = self else { return }
                                                let selectedObject = objects[selectedIndex]
                                                self.selectedObject = selectedObject
                                                self.text = selectedObject.stringForShowingInPickerView
                                                self.objectPickerDelegate?.didSelectObject(self,
                                                                                           selectedObject: selectedObject,
                                                                                           selectedIndex: selectedIndex)
        },
                                             cancel: nil,
                                             origin: self)
        picker?.addButtons()
        picker?.show()
    }
    
    
}

// MARK: - ALObjectPicker
extension ALObjectPicker: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showActionSheetStringPicker()
        return false
    }
}
