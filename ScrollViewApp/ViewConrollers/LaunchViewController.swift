//
//  LaunchViewController.swift
//  ScrollViewApp
//
//  Created by Timur Gazizulin on 24.11.23.
//

import UIKit

final class LaunchViewController: UIViewController {
    
    private let timerTimeInterval:TimeInterval = 0.05
    private let changeProgressPerTimer:Float = 0.01
    
    private let tabBar = UITabBarController()
    private let progressView = UIProgressView()
    private let logoImageView = UIImageView()
    
    private var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide NavBar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        configTabBarController(tabBar)
        configProgressView(progressView)
        configImageView(logoImageView)
        configTimer()
        
    }
    
    // MARK: - Config "Loading" ImageView
    private func configImageView(_ imageView:UIImageView){
        // Style
        imageView.image = UIImage(systemName: "applelogo")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        
        view.addSubview(imageView)
        
        // Layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: progressView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
        ])
        
    }
    
    // MARK: - Timer
    private func configTimer(){
        timer = Timer.scheduledTimer(timeInterval: timerTimeInterval,
                                     target: self,
                                     selector: #selector(addProgress),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    // MARK: - Add progress every timerTimeInterval
    @objc func addProgress(){
        if progressView.progress >= 1{
            timer.invalidate()
            self.navigationController?.setViewControllers([tabBar], animated:false)
        } else{
            UIView.animate(withDuration: timerTimeInterval){ [self] in
                logoImageView.alpha += CGFloat(changeProgressPerTimer)
            }
            progressView.setProgress(progressView.progress + changeProgressPerTimer, animated: true)
        }
        
    }
    
    // MARK: - Config Progress View
    private func configProgressView(_ pgv:UIProgressView){
        // Style
        pgv.progressTintColor = .gray
        pgv.trackTintColor = .darkGray
        
        view.addSubview(pgv)
        
        // Layout
        pgv.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pgv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pgv.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pgv.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        ])
        
    }
    
    // MARK: - Tab Bar Controller That will be shown after Loading
    private func configTabBarController(_ tb: UITabBarController){
        // "Buy" Navigation Controller
        let buyNC = UINavigationController(rootViewController: BuyViewController())
        buyNC.tabBarItem = UITabBarItem(title: "Купить", image: UIImage(systemName: "macbook.and.iphone"), tag: 0)
        
        // "For you" Navigation Controller
        let forYouNC = UINavigationController(rootViewController: ForYouViewController())
        forYouNC.tabBarItem = UITabBarItem(title: "Для вас", image: UIImage(systemName: "person.circle"), tag: 1)
        
        // "Search" Navigation Controller
        let searchNC = UINavigationController(rootViewController: SearchViewController())
        searchNC.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        // "Cart" Navigation Controller
        let cartNC = UINavigationController(rootViewController: CartViewController())
        cartNC.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "bag"), tag: 3)
        
        // Tab Bar Config
        tb.viewControllers = [buyNC, forYouNC, searchNC, cartNC]
        tb.tabBar.backgroundColor = UIColor(red: 0.34, green: 0.3, blue: 0.3, alpha: 0.23)
    }

}
