//
//  Date+Ext.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 17.07.2022.
//

import Foundation
import UIKit


extension Double {
    
    func getDateStringFromUTC(with post: Post) -> String {
        
        let date = Date(timeIntervalSince1970: post.timeshamp)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        
        return dateFormatter.string(from: date)
    }
}
