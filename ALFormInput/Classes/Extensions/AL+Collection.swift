//
//  AL+Collection.swift
//  ALFormInput_Example
//
//  Created by AppLogist on 20.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public extension Collection where Element: ALValidatableTextField {
    func validateAll() {
        forEach({ $0.validate() })
    }
    
    var isAllSuccess: Bool {
        validateAll()
        return allSatisfy({ $0.isValidSuccess })
    }
}
