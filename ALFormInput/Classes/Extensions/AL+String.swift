//
//  AL+String.swift
//  ALTextFields
//
//  Created by AppLogist on 13.04.2020.
//  Copyright © 2020 AppLogist. All rights reserved.
//

import Foundation

public extension String {
    func localizeWithFormat(arguments: CVarArg...) -> String{
       String(format: self.localized, arguments: arguments)
    }

    var localized: String {
        NSLocalizedString(self, comment:"")
    }
}
