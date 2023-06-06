//
//  AppDelegate.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 07/05/23.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setupTabBar()
        self.updateRealm()
        return true
    }
    
    private func updateRealm() {
        let config = Realm.Configuration(
          schemaVersion: 2,

          // Set the block which will be called automatically when opening a Realm with
          // a schema version lower than the one set above
          migrationBlock: { migration, oldSchemaVersion in
            // We haven’t migrated anything yet, so oldSchemaVersion == 0
            if (oldSchemaVersion < 1) {
              // Nothing to do!
              // Realm will automatically detect new properties and removed properties
              // And will update the schema on disk automatically
            }
          })

        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
    private func setupTabBar() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let gameCatalogNavigationController = GameCatalogRouter.createModule()
        
        let wishlistNavigationController = WishlistRouter.createModule()
        
        let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
        let tabBarController = UITabBarController()
        gameCatalogNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        wishlistNavigationController.tabBarItem = UITabBarItem(title: "heart", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        tabBarController.viewControllers = [gameCatalogNavigationController, wishlistNavigationController, profileViewController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

