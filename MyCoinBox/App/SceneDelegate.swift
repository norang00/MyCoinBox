//
//  SceneDelegate.swift
//  MyCoinBox
//
//  Created by Kyuhee hong on 3/6/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = SceneDelegate.getMainTabBarController()
        window?.makeKeyAndVisible()
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
    
    // MARK: - TabBarController
    static func getMainTabBarController() -> UITabBarController {
        let orderbookVC = OrderBookViewController()
        let marketVC = MarketViewController()
        let trendingVC = UINavigationController(rootViewController: TrendingViewController())
        let portfolioVC = UINavigationController(rootViewController: PortfolioViewController())

        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([orderbookVC, marketVC, trendingVC, portfolioVC], animated: true)
        tabBarController.tabBar.tintColor = .accent
        tabBarController.tabBar.items![0].title = Resources.Tab.Title.orderbook.rawValue
        tabBarController.tabBar.items![0].image = UIImage(systemName: Resources.Tab.Image.orderbook.rawValue)
        tabBarController.tabBar.items![1].title = Resources.Tab.Title.market.rawValue
        tabBarController.tabBar.items![1].image = UIImage(systemName: Resources.Tab.Image.market.rawValue)
        tabBarController.tabBar.items![2].title = Resources.Tab.Title.trending.rawValue
        tabBarController.tabBar.items![2].image = UIImage(systemName: Resources.Tab.Image.trending.rawValue)
        tabBarController.tabBar.items![3].title = Resources.Tab.Title.portfolio.rawValue
        tabBarController.tabBar.items![3].image = UIImage(systemName: Resources.Tab.Image.portfolio.rawValue)
        return tabBarController
    }
}

