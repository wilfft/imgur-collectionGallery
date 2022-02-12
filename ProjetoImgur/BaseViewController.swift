//
//  BaseViewController.swift
//  ProjetoImgur
//
//  Created by William on 09/02/22.
//

import UIKit



protocol ViewCode  {
    func setupHierarchy()
    func setupConstraints()
    func setupConfiguration()
}

extension ViewCode {
    func setupView() {
        setupHierarchy()
        setupConstraints()
        setupConfiguration()
    }
} 

class BaseViewController<V : ViewCode> : UIViewController where V : UIView {
    
    var associatedView: V! {  return self.view as? V }
      
     override func viewDidLoad() {
        super.viewDidLoad()
        self.view = V()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
