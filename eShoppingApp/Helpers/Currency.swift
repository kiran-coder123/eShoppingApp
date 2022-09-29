//
//  Currency.swift
//  eShoppingApp
//
//  Created by Kiran Sonne on 25/09/22.
//

import Foundation

func convertToCurrency(_ number: Double) -> String {
    let currencyFormater = NumberFormatter()
    currencyFormater.usesGroupingSeparator = true
    currencyFormater.numberStyle = .currency
    currencyFormater.locale = Locale.current
    
   return currencyFormater.string(from: NSNumber(value: number))!
    
    
}
