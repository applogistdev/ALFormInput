//
//  File.swift
//  
//
//  Created by AppLogist on 10.04.2020.
//

import UIKit

public class ALTextFieldConfig {
    static let shared = ALTextFieldConfig()
    
    // MARK: - Fonts
    public var titleFont : UIFont = UIFont.systemFont(ofSize: 13, weight: .semibold)
    
    public var placeholderFont: UIFont = UIFont.systemFont(ofSize: 13)
    
    public var isTitleVisible: Bool = true
    
    public var tintColor: UIColor = .systemBlue
    
    public var textColor: UIColor = .systemGray
    
    public var titleColor: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return UIColor.lightGray
        }
    }
    
    public var placeholderColor: UIColor = .lightGray
    
    public var lineColor: UIColor = .systemGray
    
    public var selectedTitleColor: UIColor = .systemBlue
    
    public var selectedLineColor: UIColor = .systemBlue
    
    // MARK: - Error Colors
    
    public var errorColor: UIColor = .systemRed
    
    public var textErrorColor: UIColor? {
        errorColor
    }
    
    public var lineErrorColor: UIColor? {
        errorColor
    }
    
    public var titleErrorColor: UIColor? {
        errorColor
    }
    
    // MARK: - TextField UIControl Event
    
    public var validateEventType: UIControl.Event = .editingDidEnd
    
    
    public init () {}
}
