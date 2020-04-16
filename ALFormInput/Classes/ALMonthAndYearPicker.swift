//
//  ALMonthAndYearPicker.swift
//  ALFormInput_Example
//
//  Created by AppLogist on 14.04.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ActionSheetPicker_3_0

public enum ALMonthAndYearPickerFormat {
    /// 01/2020
    case withNumeric
    /// January 2020
    case withMonthSymbol
}

public class ALMonthAndYearPicker: ALDatePicker {
    
    // Formats: 01/2020, January 2020
    
    private var monthSymbols = DateFormatter().monthSymbols
    private var format: ALMonthAndYearPickerFormat? = .withNumeric
    
    private var minYear: Int? = Calendar.current.dateComponents([.year], from: Date()).year ?? 0
    private var maxYear: Int? = (Calendar.current.dateComponents([.year], from: Date()).year ?? 0) + 20
    private var selectedIndexes: [Int]?
    
    
    /// You can get a certain day with setting this variable. Default value is **1**
    public var day: Int = 1
    
    private func convertToDate(month: Int, year: Int) -> Date? {
        let components = DateComponents(calendar: .current,
                                        timeZone: .current,
                                        year: year,
                                        month: month,
                                        day: day)
        return Calendar.current.date(from: components)
    }
    
    
    /// You can setup datepicker minimum year and maximum year
    /// - Parameters:
    ///   - minYear: Minimum Year
    ///   - maxYear: Maximum Year
    ///   - format: Format for display (default `.withNumeric`)
    public func setup(minYear: Int? = Calendar.current.dateComponents([.year], from: Date()).year ?? 0,
                      maxYear: Int? = (Calendar.current.dateComponents([.year], from: Date()).year ?? 0) + 20,
                      format: ALMonthAndYearPickerFormat = .withNumeric) {
        self.minYear = minYear
        self.maxYear = maxYear
        self.format = format
    }
    
    

    private func showActionSheetDatePicker() {
        guard let minYear = minYear, let maxYear = maxYear else { return }
        let years = (minYear...maxYear).map { "\($0)"}
        let months = format == .withNumeric ? monthSymbols?.compactMap{ String((monthSymbols?.firstIndex(of: $0) ?? 0) + 1)} : (monthSymbols ?? [])
        let picker = ActionSheetMultipleStringPicker(title: title,
                                                       rows: [months ?? [], years ],
                                                       initialSelection: selectedIndexes ?? [0,0] ,
                                                       doneBlock: { [weak self] (_, indexes, _) in
                                                        guard let self = self else { return }
                                                        guard let indexes = indexes as? [Int] else { return }
                                                        self.selectedIndexes = indexes
                                                        let month = months?[indexes[0]] ?? ""
                                                        
                                                        let year = years[indexes[1]]
                                                        
                                                        if let year = Int(year),
                                                            let monthIndex = indexes.first,
                                                            let selectedDate = self.convertToDate(month: monthIndex + 1,
                                                                                                 year: year) {
                                                        self.datePickerDelegate?.didSelectDate(self, selectedDate: selectedDate)
                                                        self.selectedDate = selectedDate
                                                        }
                                                        
                                                        if self.format == .withNumeric {
                                                            let month = String(format:"%02d",(indexes.first ?? 0) + 1)
                                                            self.text = "\(month)/\(year)"
                                                            return
                                                        }
                                                        self.text = "\(month) \(year)"
                                                        
          },
                                                       cancel: nil,
                                                       origin: self)
        
        
          picker?.addButtons()
          picker?.show()
      }
    
    public override func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showActionSheetDatePicker()
        return false
    }
}


