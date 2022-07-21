//
//  SpinnerViewController.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 21.07.2022.
//

import Foundation
import UIKit

class SpinnerViewController: UIViewController {
    
    var containerView: UIView!

    func showLoadingView() {
        containerView                   = UIView(frame: view.bounds)
        view.addSubview(containerView)
        print("hello")
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             =  0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}
