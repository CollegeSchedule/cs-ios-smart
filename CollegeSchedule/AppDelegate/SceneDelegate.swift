import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let tabController: UITabBarController = UITabBarController()

        //
        // MARK: - First view
        //
        let todayHostingController: TodayViewController = TodayViewController()
        let todayNavigationController: UINavigationController = UINavigationController(
                rootViewController: todayHostingController
        )

        todayHostingController.title = "today.title".localized()
        todayHostingController.tabBarItem.image = UIImage(systemName: "house")
        todayNavigationController.navigationBar.prefersLargeTitles = true

        //
        // MARK: - Second view
        //
        
        let scheduleHostingController: ScheduleViewController = ScheduleViewController()
        let scheduleNavigationController: UINavigationController = UINavigationController(
                rootViewController: scheduleHostingController
        )
        
        scheduleHostingController.title = "schedule.title".localized()
        scheduleHostingController.tabBarItem.image = UIImage(systemName: "alarm")
        scheduleNavigationController.navigationBar.prefersLargeTitles = true
        
        //
        // MARK: - Third view
        //
        let searchView: some View = SearchView()
        let searchHostingController: UIHostingController = UIHostingController(rootView: searchView)
        let searchNavigationController: UINavigationController = UINavigationController(
                rootViewController: searchHostingController
        )
        
        searchHostingController.title = "search.title".localized()
        searchHostingController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        searchHostingController.navigationItem.searchController = UISearchController(searchResultsController: nil)
        searchNavigationController.navigationBar.prefersLargeTitles = true

        //
        // MARK: - Fourth view
        //
        let settingsMasterViewController: SettingsViewController = SettingsViewController()
        let settingsMasterNavigationController: UINavigationController = UINavigationController(rootViewController: settingsMasterViewController)
        
        let settingsDetailViewController: SettingsAppearanceViewController = SettingsAppearanceViewController()
        let settingsDetailNavigationController: UINavigationController = UINavigationController(rootViewController: settingsDetailViewController)
        
        let splitViewController: UISplitViewController = UISplitViewController()
        
        splitViewController.viewControllers = [settingsMasterNavigationController, settingsDetailNavigationController]
//        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.tabBarItem.image = UIImage(systemName: "gear")
        splitViewController.title = "settings.title".localized()
        splitViewController.delegate = self
        
        settingsMasterViewController.navigationController?.navigationBar.prefersLargeTitles = true
        settingsMasterViewController.title = "settings.title".localized()
        
        settingsDetailViewController.title = "settings.section.app.appearance".localized()
        
        tabController.viewControllers = [
            todayNavigationController,
            scheduleNavigationController,
            searchNavigationController,
            splitViewController
        ]

        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)

            if(!SettingsStore.instance.isAppearanceAutomatically) {
                self.window!.overrideUserInterfaceStyle = SettingsStore.instance.appearance
            }
                    
            UINavigationBar.appearance().tintColor = .systemPink
            UITableViewCell.appearance().tintColor = .systemPink
            UITabBar.appearance().tintColor = .systemPink
            UIButton.appearance().tintColor = .systemPink
            
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

extension SceneDelegate: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
