//
//  PostCell.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 14.07.2022.
//

import Foundation
import UIKit

class PostCell: UITableViewCell {
    
    var posts: Post?
    
    let name        = UILabel()
    let previewText = UILabel()
    let likes       = UILabel()
    let likesNumber = UILabel()
    let dateLabel   = UILabel()
    let button      = NButton(color: .black, title: "Expand")
    
    let previewTextStack = UIStackView()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 150
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
        configure(with: posts)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        // Title Label
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.preferredFont(forTextStyle: .title3)
        name.adjustsFontForContentSizeCategory = true // A Boolean that indicates whether the object automatically updates its font when titleevice's content size category changes.
        name.text = "Charlie"
        name.textColor = .black
        
        // Preview Text
        previewText.translatesAutoresizingMaskIntoConstraints = false
        previewText.font = UIFont.preferredFont(forTextStyle: .body)
        previewText.textColor = .systemGray
        previewText.numberOfLines = 2
//        previewText.text = "Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets Charlie Deets"
        
        // Likes
        likes.translatesAutoresizingMaskIntoConstraints = false
        likes.font = UIFont.preferredFont(forTextStyle: .body)
        likes.text = "❤️"
        
        // Likes Number
        likesNumber.translatesAutoresizingMaskIntoConstraints = false
        likesNumber.font = UIFont.preferredFont(forTextStyle: .caption1)
        likesNumber.textColor = .gray
//        likesNumber.text = "9"
        
        // Date Label
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        dateLabel.adjustsFontForContentSizeCategory = true // A Boolean that indicates whether the object automatically updates its font when dateLabelitleevice's content size category changes.
        dateLabel.text = "21 day ago"
        dateLabel.textColor = .gray
        
        // Button
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Stack View
        previewTextStack.translatesAutoresizingMaskIntoConstraints = false
        previewTextStack.axis = .vertical
        previewTextStack.spacing = 8
        
        contentView.addSubview(name)
        contentView.addSubview(previewTextStack)
        contentView.addSubview(likes)
        contentView.addSubview(likesNumber)
        contentView.addSubview(button)
        contentView.addSubview(dateLabel)
        
        
        previewTextStack.addArrangedSubview(previewText)
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            // Title Label
            name.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            name.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            // Preview Text
            previewText.topAnchor.constraint(equalToSystemSpacingBelow: name.bottomAnchor, multiplier: 1),
            previewText.leadingAnchor.constraint(equalToSystemSpacingAfter: name.leadingAnchor, multiplier: 0),
            
            // Likes
            likes.topAnchor.constraint(equalToSystemSpacingBelow: name.bottomAnchor, multiplier: 8),
            likes.leadingAnchor.constraint(equalToSystemSpacingAfter: name.leadingAnchor, multiplier: 0),
            
            // Likes Number
            likesNumber.topAnchor.constraint(equalTo: likes.topAnchor, constant: 4),
            likesNumber.leadingAnchor.constraint(equalToSystemSpacingAfter: likes.leadingAnchor, multiplier: 3),
            
            // Date Label
            dateLabel.topAnchor.constraint(equalToSystemSpacingBelow: previewText.bottomAnchor, multiplier: 2.5),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            // NButton
            button.topAnchor.constraint(equalTo: likesNumber.bottomAnchor, constant: 10),
            button.centerXAnchor.constraint(equalTo: previewText.centerXAnchor, constant: 0),
            button.widthAnchor.constraint(equalToConstant: 300),
            
            // Preview Stack View
            previewTextStack.topAnchor.constraint(equalToSystemSpacingBelow: name.bottomAnchor, multiplier: 0),
            previewTextStack.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: previewTextStack.trailingAnchor, multiplier: 1),
//            bottomAnchor.constraint(equalToSystemSpacingBelow: previewTextStack.bottomAnchor, multiplier: 1),
        ])
        
    }
    
    @objc func buttonTapped() {
        print("tapped")
    }
    
    func configure(with post: Post?) {
        
        previewText.text = post?.preview_text
        likesNumber.text = "\(post?.likes_count)"
    }
    
    
    
}
