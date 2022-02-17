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
    
    
   lazy var contentSize = CGSize(width: self.frame.width, height: self.frame.height + 400)
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .red
      //  scrollView.frame = self.bounds
     scrollView.contentSize = contentSize
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsVerticalScrollIndicator = true
        
        return scrollView
        
    }()
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
  //      view.frame.size = contentSize
        view.backgroundColor = .blue
        return view
        
    }()
    
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
 
  //      containerView.addSubview(imageGallery)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//                                       scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//                                       scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//                                       scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//                                       containerView.topAnchor.constraint(equalTo: self.topAnchor),
//                                       containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//                                       containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//                                       containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                       imageGallery.topAnchor.constraint(equalTo: self.topAnchor),
                                       imageGallery.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                       imageGallery.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                       imageGallery.bottomAnchor.constraint(equalTo: self.bottomAnchor),

                                    ]
    )   }
    
    func setupConfiguration() {
        self.backgroundColor = .white
    }
    
}
