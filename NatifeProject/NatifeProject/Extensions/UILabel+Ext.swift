//
//  UILabel+Ext.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 18.07.2022.
//

import Foundation
import UIKit

extension UILabel {
    func countLabelLines() -> Int {
        let textHeight = sizeThatFits(bounds.size).height
        return Int(textHeight / font.lineHeight)
    }

    func isTruncated(for linesCount: Int = 1) -> Bool {
        layoutIfNeeded()

        if numberOfLines == 1 {
            let size = ((text ?? "") as NSString).size(withAttributes: [.font: font as Any])
            return size.width > bounds.width
        } else {
            return linesCount < countLabelLines()
        }
    }
}
