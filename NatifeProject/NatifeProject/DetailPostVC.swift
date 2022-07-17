//
//  DetailPostVC.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 15.07.2022.
//

import Foundation

import Foundation
import UIKit

class DetailPostVC: UIViewController {
    
    var posts: Post?
    
    let imageView       = UIImageView()
    let stackView       = UIStackView()
    let titleLabel      = UILabel()
    let previewText     = UILabel()
    let likes           = UILabel()
    let dateLabel       = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension DetailPostVC {
    func style() {
        
        // Image View
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        
        // Stack View
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        
        // Title Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        titleLabel.adjustsFontForContentSizeCategory = true // A Boolean that indicates whether the object automatically updates its font when titleLabelitleevice's content size category changes.
        titleLabel.text = "Charlie Deets"
        titleLabel.textColor = .black
        
        // Preview Text
        previewText.translatesAutoresizingMaskIntoConstraints = false
        previewText.text = posts?.preview_text
        previewText.font = UIFont.preferredFont(forTextStyle: .body)
        previewText.numberOfLines = 10
        
        // Likes
        likes.translatesAutoresizingMaskIntoConstraints = false
        likes.font = UIFont.preferredFont(forTextStyle: .body)
        likes.text = "❤️ \(posts?.likes_count ?? 0)"
        
        // Date Label
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        dateLabel.adjustsFontForContentSizeCategory = true // A Boolean that indicates whether the object automatically updates its font when dateLabelitleevice's content size category changes.
        dateLabel.text = "\(posts?.timeshamp.convertToMonthYearFormat() ?? "")"
        dateLabel.textColor = .gray
    }
    
    func layout() {
        stackView.addArrangedSubview(previewText)
        
        view.addSubview(stackView)
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(likes)
        view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            
            // Image View
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            imageView.widthAnchor.constraint(equalToConstant: 400),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            
            // Stack View
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            // Likes
            likes.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            likes.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            
            
            // Date Label
            dateLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0),
            
        ])
    }
}
