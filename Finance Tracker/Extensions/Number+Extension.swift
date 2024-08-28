//
//  NumberFormatter.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 23.07.2024.
//

import Foundation

extension NumberFormatter {
    static var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        
        if Locale.current.language.languageCode?.identifier == "en" {
            
            formatter.currencySymbol = "$"
        } else if Locale.current.language.languageCode?.identifier == "tr" {
            
            formatter.currencySymbol = "₺"
        } else {
            
            formatter.locale = Locale.current
        }
        
        return formatter
    }
    
    static var dollarFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    static var decimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
