//
//  CollectionViewCell.swift
//  ProjetoImgur
//
//  Created by William on 05/02/22.
//

import UIKit

class GalleryCell : UICollectionViewCell {
    static let indentifier = "Cell"
    private var task : URLSessionDataTask!
    
    private lazy var loading : UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.translatesAutoresizingMaskIntoConstraints = false 
        return loading
    }()
    
    private lazy var imageView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews()
        self.setupConstraints()
        loading.startAnimating()
    }
    
    public func setupCell(urlString : String){
        self.imageView.loadImageFromURL(urlString: urlString){
        self.stopLoading()
        }
    }

    public func stopLoading(){
        loading.stopAnimating()
        loading.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(imageView)
        self.addSubview(loading)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            loading.centerXAnchor.constraint(equalTo: centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        )
    }
}

 
