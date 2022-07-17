//
//  ViewController.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 14.07.2022.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    
    public var posts: [Post]? = []
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
        configureItems()
        
    }
}

extension MainViewController {
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
    
    private func configureItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "slider.horizontal.3"),
            style: .plain,
            target: self,
            action: #selector(navBarButtonTapped))
    }
    
    @objc func navBarButtonTapped() {
        sortPostsByLikes()
        sortPostsByDate()
        
    }
    
    func sortPostsByLikes() {
        var sortedPosts = posts?.sorted { (lhs: Post, rhs: Post) -> Bool in
            return lhs.likes_count < rhs.likes_count
        }
        print(sortedPosts)
    }
    
    func sortPostsByDate() {
        var sortedPosts = posts?.sorted { (lhs: Post, rhs: Post) -> Bool in
            return lhs.timeshamp < rhs.timeshamp
        }
    }
    
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
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
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let detailPostVC = DetailPostVC()
        detailPostVC.posts = posts?[indexPath.row]
        navigationController?.pushViewController(detailPostVC, animated: true)
        tableView.reloadData()
    }
}

// MARK: - Networking
extension MainViewController {
    
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
