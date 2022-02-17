//
//  GalleryViewModel.swift
//  ProjetoImgur
//
//  Created by William on 09/02/22.
//

import UIKit

class GalleryViewModel  {
    private let network : ServiceProtocol
      let minimumInteritemSpacingForSectionAt : CGFloat = 2
      let minimumLineSpacingForSectionAt : CGFloat = 2
    private let collectionViewRows :  CGFloat = 4
    private var cellSizeFormula :  CGFloat {
        minimumInteritemSpacingForSectionAt * collectionViewRows / collectionViewRows
    }
    
    var currentPage = 0
    var filteredImages : [Image] = []
    var numberOfItemsInSection: Int { return filteredImages.count }
    var allowFetchMoreImages = true
    var lastPageLoaded : Int?
    
    
    
    func cellwillDisplayIsAllowed(_ indexPath: IndexPath)   {
        if indexPath.row == self.numberOfItemsInSection-1 {
            allowFetchMoreImages = true
        }
    }
    
    func fetchImages(onComplete: @escaping () ->  Void){
        if lastPageLoaded == nil || currentPage != lastPageLoaded {
            lastPageLoaded = currentPage
            
            self.network.requestImagesListFromPage(page: currentPage){ (result: Result<ImgurResponse, RequestImagesError>) in
                switch result {
                case let .success(images):
                    self.filteredImages += images.data.filter{ self.filterOnlyImages($0.link) }
                case let .failure(error): print(error)
                }
                self.currentPage += 1
                onComplete()
            }
            self.allowFetchMoreImages = false
        }
    }
    
    func verifyScrollViewDidEndAndFetchIsAllowed(_ scrollView: UIScrollView) -> Bool{
        return ((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && self.allowFetchMoreImages
    }
    
    func customCell(_ collectionView : UICollectionView, _ indexPath : IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.indentifier, for: indexPath) as! GalleryCell
        cell.setupCell(urlString: filteredImages[indexPath.row].link)
        
        return cell
    }
    
    init( network : NetworkAPI = NetworkAPI()) {
        self.network = network
    }
    
    func cellLayoutSize(_ collectionView : UICollectionView) -> CGSize {
        let size = (collectionView.bounds.width - minimumInteritemSpacingForSectionAt * collectionViewRows) / collectionViewRows
        
        return  CGSize(width: size ,  height: size)
    }
    
    
    func filterOnlyImages(_ input : String) -> Bool{
        return input.hasSuffix(".png") || input.hasSuffix(".jpeg") || input.hasSuffix(".jpg") ? true : false
    }
}
