//
//  NTabBarController.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 17.07.2022.
//

import Foundation
import UIKit

class NTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [mainNC()]
    }
    
    func mainNC() -> UINavigationController {
        let mainVC            = MainViewController()
        mainVC.title          = "Title"
        mainVC.tabBarItem = UITabBarItem(title: "Title", image: UIImage(systemName: ""), tag: 0)
        
        return UINavigationController(rootViewController: mainVC)
    }
}
