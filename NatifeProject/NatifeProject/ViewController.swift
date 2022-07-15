//
//  ViewController.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 14.07.2022.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var posts: [Post]?
    
//    var post: Post?
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }
}

extension ViewController {
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        
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

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseID, for: indexPath) as! PostCell
        if let post = posts?[indexPath.row] {
            cell.configure(with: post)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Networking
extension ViewController {
    
    func fetchData() {
            let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json")!

            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async { [self] in
                    guard let data = data, error == nil else {
                        return
                    }
                    do {
                         let jsonData = try Data(contentsOf: url)
                        posts = try JSONDecoder().decode(Result.self, from: jsonData).posts
                        
                        if let result = posts {
                            self.tableView.reloadData()
                            Date(timeIntervalSince1970: TimeInterval())
                        } else {
                            print("Failed to parse")
                            
                        }
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }.resume()
    }
}
