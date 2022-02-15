//
//  ViewCode.swift
//  ProjetoImgur
//
//  Created by William on 15/02/22.
//

import Foundation

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
