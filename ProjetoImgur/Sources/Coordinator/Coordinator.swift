//
//  MainCoordinator.swift
//  ProjetoImgur
//
//  Created by William on 15/02/22.
//

import UIKit


protocol Coordinator : AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var presenter: UINavigationController { get set }
    
    func start()
} 
