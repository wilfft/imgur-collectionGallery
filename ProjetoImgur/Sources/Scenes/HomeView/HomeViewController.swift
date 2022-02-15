//
//  HomeViewController.swift
//  ProjetoImgur
//
//  Created by William on 15/02/22.
//

import UIKit

class HomeViewController: BaseViewController<HomeView> {

    
    var viewModel : HomeViewModel = HomeViewModel()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        associatedView.delegate = self
    } }

extension HomeViewController : HomeViewDelegate {
    func routeToGalleryView() { 
        viewModel.coordinator?.goToGallery()
    }
    
    
}
