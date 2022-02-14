//
//  ViewController.swift
//  ProjetoImgur
//
//  Created by William on 05/02/22.
//

import UIKit



extension GalleryViewController   {
    func didFetchData() {  }
}

class GalleryViewController : BaseViewController<GalleryView>    {
    var viewModel : GalleryViewModel!
    var fetchMoreImagesIsAllowed = false
    var lastPageLoaded : Int?
    
    override init() {
        super.init()
        configure()
        fetchImagesFromViewModel()
    }
    
    func configure(){
        associatedView.configureDelegateCollectionView(delegate: self)
        viewModel = GalleryViewModel()
    }
    
    func fetchImagesFromViewModel(){
        if  lastPageLoaded == nil || viewModel.pageNumber != lastPageLoaded {
            self.lastPageLoaded = self.viewModel.pageNumber
            viewModel.fetchImages{
            DispatchQueue.main.async { 
            self.associatedView.imageGallery.reloadData()
            self.viewModel.pageNumber += 1
        }}
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GalleryViewController : GalleryCollectionDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width - 4) / 3
        return CGSize(width: size ,  height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       if indexPath.row == viewModel.filteredImages.count-1 {
            print("\(indexPath.row)  filtered: \(viewModel.filteredImages.count-1)")
            fetchMoreImagesIsAllowed = true
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) ){
           if  fetchMoreImagesIsAllowed {
                fetchImagesFromViewModel()
                fetchMoreImagesIsAllowed = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.indentifier, for: indexPath) as! GalleryCell
        cell.setupCell(urlString: self.viewModel.filteredImages[indexPath.row].link)
        return cell
    }
      
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
