//
//  ViewController.swift
//  ProjetoImgur
//
//  Created by William on 05/02/22.
//

import UIKit

class GalleryViewController : BaseViewController<GalleryView>    {
    var viewModel : GalleryViewModel! {
        didSet {
            fetchImagesFromViewModel()
        }
    }
   
    override init() {
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        associatedView.configureDelegateCollectionView(delegate: self)
        viewModel = GalleryViewModel()
    }
    
    func fetchImagesFromViewModel(){
         viewModel.fetchImages{
              DispatchQueue.main.async {
                    self.associatedView.imageGallery.reloadData()
                } 
         } 
        }
    } 


extension GalleryViewController : GalleryCollectionDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.cellLayoutSize(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // fixForFirstLoad foi usado pq ao preencher a collection com 4 itens, a view nao chega a tocar o scroll, dai houve a necessidade de startar nessa forma.
        
        if viewModel.fixForFirstLoad(indexPath)    {
            fetchImagesFromViewModel()
        }
        viewModel.cellwillDisplayIsAllowed(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if viewModel.verifyScrollViewDidEndAndFetchIsAllowed(scrollView) {
               fetchImagesFromViewModel()
            
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.customCell(collectionView, indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt
    }
}
