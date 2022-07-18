//
//  ViewController.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 14.07.2022.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    
    var posts: [Post] = []
    var filtered: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        let controller = UIAlertController(
            title: "Sorting Filter",
            message: nil,
            preferredStyle: .actionSheet)
        
        let byLikesButton = UIAlertAction(title: "Sort by likes", style: .default) { _ in
            controller.dismiss(animated: true) { [weak self] in
                self?.sortPostsByLikes()
            }
        }
        
        let byDateButton = UIAlertAction(title: "Sort by date", style: .default) { _ in
            controller.dismiss(animated: true) { [weak self] in
                self?.sortPostsByDate()
            }
        }
        
        let resetFilterButton = UIAlertAction(title: "Reset sorting", style: .destructive) { _ in
            controller.dismiss(animated: true) { [weak self] in
                self?.resetPostSorting()
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            controller.dismiss(animated: true)
        }
        
        [byLikesButton, byDateButton, resetFilterButton, cancel].forEach {
            controller.addAction($0)
        }
        
        present(controller, animated: true)
        
    }
    
    func sortPostsByLikes() {
        let sortedPosts = posts.sorted { (lhs: Post, rhs: Post) -> Bool in
            return lhs.likes_count < rhs.likes_count
        }
        filtered = sortedPosts
    }
    
    func sortPostsByDate() {
        let sortedPosts = posts.sorted { (lhs: Post, rhs: Post) -> Bool in
            return lhs.timeshamp < rhs.timeshamp
        }
        filtered = sortedPosts
    }
    
    func resetPostSorting() {
        filtered = posts
    }
    
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseID, for: indexPath) as! PostCell
        let post = filtered[indexPath.row]
        cell.configure(with: post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print((cell as? PostCell)?.previewText.numberOfLines)
    }
    
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let detailPostVC = DetailPostVC()
        detailPostVC.posts = filtered[indexPath.row]
        detailPostVC.hidesBottomBarWhenPushed = true
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
                    filtered = posts
                } catch {
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
}
