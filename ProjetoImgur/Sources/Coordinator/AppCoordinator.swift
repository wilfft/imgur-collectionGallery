//
//  AppCoordinator.swift
//  ProjetoImgur
//
//  Created by William on 15/02/22.
//

import Foundation
import UIKit


class AppCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    var presenter: UINavigationController
    
    func start() {
        let child = HomeCoordinator(presenter : presenter)
        child.parentCoordinator = self
        child.start()
    }
    
    init(presenter : UINavigationController){
        self.presenter = presenter
    }
    
    func childDidFinish(_ child: Coordinator?) {
            for (index, coordinator) in childCoordinators.enumerated() {
                if coordinator === child {
                    childCoordinators.remove(at: index)
                    break
                }
            }
        }

}
