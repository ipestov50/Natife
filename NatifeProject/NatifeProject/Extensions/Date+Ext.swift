//
//  Date+Ext.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 17.07.2022.
//

import Foundation
import UIKit

extension Date {
    
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().day())
    }
    
    // func convertToDateAgo() -> String 
}
