//
//  SceneDelegate.swift
//  ProjetoImgur
//
//  Created by William on 05/02/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
     
        let navController = UINavigationController()
        let coordinator = AppCoordinator(presenter: navController)
        
        coordinator.start()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
    }

    


}

