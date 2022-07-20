//
//  NetworkManager.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 19.07.2022.
//

import Foundation

//protocol DataManager {
//    func fetchPosts()
//}
//
//
//
//class NetworkManager: DataManager {
//    func fetchPosts() {
//        let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json")!
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            DispatchQueue.main.async { [self] in
//                guard let data = data, error == nil else {
//                    return
//                }
//                do {
//                    let jsonData = try Data(contentsOf: url)
//                    let posts = try JSONDecoder().decode(Results.self, from: jsonData).posts
//                    let filtered = posts
//                } catch {
//                    print("Error: \(error)")
//                }
//            }
//        }.resume()
//    }
//}
