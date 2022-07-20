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

extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 2
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
}
