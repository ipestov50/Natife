//
//  PostCell.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 14.07.2022.
//

import Foundation
import UIKit

class PostCell: UITableViewCell {
    
    var state: Bool = true
    
    let name        = UILabel()
    let previewText = UILabel()
    let likes       = UILabel()
    let dateLabel   = UILabel()
    let button      = NButton(color: .black, title: "Expand")
    
    static let reuseID = "AccountSummaryCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        
        // Title Label
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.preferredFont(forTextStyle: .title3)
        name.adjustsFontForContentSizeCategory = true
        name.text = "Charlie"
        name.textColor = .black
        
        // Preview Text
        previewText.translatesAutoresizingMaskIntoConstraints = false
        previewText.textColor = .systemGray
        
        previewText.lineBreakMode = .byTruncatingTail
        
        
        // Likes
        likes.translatesAutoresizingMaskIntoConstraints = false
        likes.font = UIFont.preferredFont(forTextStyle: .body)
        
        
        // Date Label
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.textColor = .gray
        
        // Button
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        contentView.addSubview(name)
        contentView.addSubview(previewText)
        contentView.addSubview(likes)
        contentView.addSubview(button)
        contentView.addSubview(dateLabel)
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            // Title Label
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            // Preview Text
            previewText.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            previewText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            previewText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            // Likes
            likes.topAnchor.constraint(equalTo: previewText.bottomAnchor, constant: 8),
            likes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            // Date Label
            dateLabel.topAnchor.constraint(equalTo: previewText.bottomAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            // NButton
            button.topAnchor.constraint(equalTo: likes.bottomAnchor, constant: 20),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.centerXAnchor.constraint(equalTo: previewText.centerXAnchor),
            
        ])
        
    }
    
    @objc func buttonTapped(sender: UIButton) {
        let numberOfLines = previewText.numberOfLines == 0 ? 2 : 0
        previewText.numberOfLines = numberOfLines
        let newTitle = numberOfLines == 2 ? "Expand" : "Collapse"
        sender.setTitle(newTitle, for: .normal)
        UIView.animate(withDuration: 0.5) { self.contentView.layoutIfNeeded() }
    }
    
    func configure(with post: Post) {
        
        previewText.text = post.preview_text
        likes.text = "❤️ \(post.likes_count)"
        dateLabel.text = "\(configureDateLabel(with: post))"
    }
    
    func configureDateLabel(with post: Post) -> String {

        let exampleDate = Date(timeIntervalSince1970: TimeInterval(post.timeshamp))
        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        
        let relativeDate = formatter.localizedString(for: exampleDate, relativeTo: Date.now)
        
        return relativeDate
    }
    
}
