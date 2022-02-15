//
//  Home.swift
//  ProjetoImgur
//
//  Created by William on 15/02/22.
//

import UIKit


protocol HomeViewDelegate : AnyObject {
    func routeToGalleryView()
    
}

final class HomeView : UIView, ViewCode {
    weak var delegate : HomeViewDelegate?
    
    
    private lazy var startButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Iniciar", for: .normal)
        button.addTarget(self, action: #selector(routeToGallery), for: .touchDown)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        addSubview(startButton)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: centerYAnchor)]
        )
    }
    
    func setupConfiguration() {
        
    }
    
    
    @objc
    func routeToGallery(){
        delegate?.routeToGalleryView()
    }
    
    
}
