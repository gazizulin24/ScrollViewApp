//
//  SceneDelegate.swift
//  ScrollViewApp
//
//  Created by Timur Gazizulin on 22.11.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // MARK: - Tab Bar
        
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
        let tb = UITabBarController()
        tb.viewControllers = [buyNC, forYouNC, searchNC, cartNC]
        tb.tabBar.backgroundColor = UIColor(red: 0.34, green: 0.3, blue: 0.3, alpha: 0.23)
        
        
        // MARK: - Window config
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        window.rootViewController = tb
        window.backgroundColor = .black
        window.makeKeyAndVisible()
        
        self.window = window
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

