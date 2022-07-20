//
//  PostCell.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 14.07.2022.
//

import Foundation
import UIKit

class PostCell: UITableViewCell {
    
    var collapsed: Bool = true
    var shouldUpdateCell: (() -> Void)?
    
    let container = UIStackView()
    let cover = UIView()
    let buttonCover = UIView()
    
    let name        = UILabel()
    let previewText = UILabel()
    let likes       = UILabel()
    let dateLabel   = UILabel()
    let button      = UIButton()
    
    static let reuseID = "AccountSummaryCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        container.axis = .vertical
        container.spacing = 10
        container.alignment = .center
        
        // Title Label
        
        name.font = UIFont.preferredFont(forTextStyle: .title3)
        name.adjustsFontForContentSizeCategory = true
        name.text = "Charlie Deets"
        name.textColor = .black
        
        // Preview Text
        previewText.textColor = .systemGray
        previewText.lineBreakMode = .byTruncatingTail
        previewText.numberOfLines = 0
        
        // Likes
        likes.font = UIFont.preferredFont(forTextStyle: .body)
        
        // Date Label
        dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.textColor = .gray
        
        // Button
        button.setTitle("Expand", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        
        container.addArrangedSubview(cover)
        container.addArrangedSubview(buttonCover)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
        button.translatesAutoresizingMaskIntoConstraints = false
        buttonCover.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: buttonCover.topAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: buttonCover.leadingAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: buttonCover.trailingAnchor, constant: -10),
            button.bottomAnchor.constraint(equalTo: buttonCover.bottomAnchor, constant: -10),
            
            button.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalToConstant: 40),
        ])
        name.translatesAutoresizingMaskIntoConstraints = false
        cover.addSubview(name)
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: cover.topAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: cover.leadingAnchor, constant: 10),
        ])
        previewText.translatesAutoresizingMaskIntoConstraints = false
        cover.addSubview(previewText)
        NSLayoutConstraint.activate([
            previewText.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            previewText.leadingAnchor.constraint(equalTo: cover.leadingAnchor, constant: 10),
            previewText.trailingAnchor.constraint(equalTo: cover.trailingAnchor, constant: -10),
        ])
        likes.translatesAutoresizingMaskIntoConstraints = false
        cover.addSubview(likes)
        NSLayoutConstraint.activate([
            likes.topAnchor.constraint(equalTo: previewText.bottomAnchor, constant: 8),
            likes.leadingAnchor.constraint(equalTo: cover.leadingAnchor, constant: 10),
            likes.bottomAnchor.constraint(equalTo: cover.bottomAnchor, constant: -10),
        ])
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        cover.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: previewText.bottomAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: cover.trailingAnchor, constant: -10),
        ])
    }

    @objc func buttonTapped(sender: UIButton) {
        
        if collapsed {
            sender.setTitle("Collapse", for: .normal)
            previewText.numberOfLines = 0
        } else {
            sender.setTitle("Expand", for: .normal)
            previewText.numberOfLines = 2
        }
        collapsed.toggle()
        shouldUpdateCell?()
    }
    
    func configure(with post: Post) {
        
        previewText.text = post.preview_text
        likes.text = "❤️ \(post.likes_count)"
        dateLabel.text = "\(configureDateLabel(with: post))"
        
        updateState()
    }
    
    func configureDateLabel(with post: Post) -> String {

        let exampleDate = Date(timeIntervalSince1970: TimeInterval(post.timeshamp))
        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        
        let relativeDate = formatter.localizedString(for: exampleDate, relativeTo: Date.now)
        
        return relativeDate
    }
    
    func updateState() {
        
      let lines = previewText.countLines(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        
        if lines > 2 {
            previewText.numberOfLines = 2
            buttonCover.isHidden = false
        } else {
            previewText.numberOfLines = 0
            buttonCover.isHidden = true
        }
    
    }
    
}
