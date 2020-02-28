import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let tabController: UITabBarController = UITabBarController()

        //
        // MARK: - First view
        //
        let todayView: some View = TodayView()
        let todayHostingController: UIHostingController = UIHostingController(rootView: todayView)
        let todayNavigationController: UINavigationController = UINavigationController(
                rootViewController: todayHostingController
        )

        todayHostingController.title = "Today"
        todayHostingController.tabBarItem.image = UIImage(systemName: "house.fill")
        todayNavigationController.navigationBar.prefersLargeTitles = true

        //
        // MARK: - Second view
        //
        let searchView: some View = SearchView()
        let searchHostingController: UIHostingController = UIHostingController(rootView: searchView)
        let searchNavigationController: UINavigationController = UINavigationController(
                rootViewController: searchHostingController
        )
        
        searchHostingController.title = "Search"
        searchHostingController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchHostingController.navigationItem.searchController = UISearchController(searchResultsController: nil)
        searchNavigationController.navigationBar.prefersLargeTitles = true

        //
        // MARK: - Third view
        //
        let settingsHostingController: SettingsViewController = SettingsViewController()
        let settingsNavigationController: UINavigationController = UINavigationController(
                rootViewController: settingsHostingController
        )

        settingsHostingController.title = "Settings"
        settingsHostingController.tabBarItem.image = UIImage(systemName: "gear")
        settingsNavigationController.navigationBar.prefersLargeTitles = true

        tabController.viewControllers = [
            todayNavigationController,
            searchNavigationController,
            settingsNavigationController
        ]

        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)

            if(!SettingsStore.instance.isAppearanceAutomatically) {
                self.window!.overrideUserInterfaceStyle = SettingsStore.instance.appearance
            }

            UIView.appearance().tintColor = .systemPink
            
//            UINavigationBar.appearance().tintColor = .systemPink
//            UITableViewCell.appearance().tintColor = .systemPink
//            UITabBar.appearance().tintColor = .systemPink
//            UIButton.appearance().tintColor = .systemPink
            
            self.window!.rootViewController = tabController
            self.window!.makeKeyAndVisible()
        }
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        if(!SettingsStore.instance.isAppearanceAutomatically) {
            self.window?.overrideUserInterfaceStyle = SettingsStore.instance.appearance
        }
    }
}

