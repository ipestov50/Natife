//
//  ViewController.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 14.07.2022.
//

import UIKit

import Foundation
import UIKit


class ViewController: UIViewController {
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchPosts()
    }
}

extension ViewController {
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseID)
        tableView.rowHeight = PostCell.rowHeight
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseID, for: indexPath) as! PostCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Networking
extension ViewController {
    
    func fetchPosts() {
            let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json")!

            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        return
                    }
                    
                    var result: Result?
                    do {
                         let jsonData = try Data(contentsOf: url)
                        result = try JSONDecoder().decode(Result.self, from: jsonData)
                        
                        if let result = result {
                            print(result)
                        } else {
                            print("Failed to parse")
                        }
                    } catch {
                        print("Error: \(error)")
                    }
                    
                }
            }.resume()
    }

    struct Result: Codable {
        let posts: [Post]
    }

    struct Post: Codable {
        
        let title: String
        let preview_text: String
        let likes_count: Int
        
    }
}
