//
//  HomeCoordinator.swift
//  ProjetoImgur
//
//  Created by William on 15/02/22.
//

import UIKit


final class HomeCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    var presenter: UINavigationController
    weak var parentCoordinator : AppCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let viewController = HomeViewController()
        viewController.viewModel.coordinator = self
        presenter.pushViewController(viewController, animated: true)
     
    }
    
    func goToGallery(){
        let viewController = GalleryViewController()
        print("galery")
        presenter.pushViewController(viewController, animated: true)
    }
    
    func onFinish(){
        parentCoordinator?.childDidFinish(self)
    }
   
    
    
}
