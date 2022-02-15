//
//  Gallery.swift
//  ProjetoImgur
//
//  Created by William on 09/02/22.
//

import UIKit


protocol GalleryCollectionDelegate :   UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
 
}
final class GalleryView: UIView, ViewCode {
    
    weak var delegate : GalleryCollectionDelegate?
  
    lazy var imageGallery : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.indentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false 
        layout.scrollDirection = .vertical
        collectionView.isPrefetchingEnabled = true
        return collectionView
    }()
    
     init() {
        super.init(frame: .zero)
        setupView()
    }
    
    func configureDelegateCollectionView(delegate : GalleryCollectionDelegate ){
        self.delegate =  delegate
        imageGallery.dataSource = self.delegate
        imageGallery.delegate = self.delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    func setupHierarchy() {
        self.addSubview(imageGallery)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([  imageGallery.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                                       imageGallery.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                       imageGallery.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                       imageGallery.bottomAnchor.constraint(equalTo: self.bottomAnchor) ]
        )
    }
    
    func setupConfiguration() {
        self.backgroundColor = .white
    }
    
}
