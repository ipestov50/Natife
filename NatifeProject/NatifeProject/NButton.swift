//
//  NButton.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 15.07.2022.
//

import Foundation
import UIKit

class NButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, title: String) {
        self.init(frame: .zero)
        set(color: color, title: title)
    }
    
    private func configure() {
        configuration = .tinted()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(color: UIColor, title: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
        
    }
}
