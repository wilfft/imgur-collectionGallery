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
    var canRequestMoreItens = false
  
    override init() {
        super.init()
        configure()
        fetchImagesFromVM()
    }
    
    func configure(){
        associatedView.configureDelegateCollectionView(delegate: self)
        viewModel = GalleryViewModel()
    }
    
    func fetchImagesFromVM(){
        viewModel.fetchImages{
            DispatchQueue.main.async {
            self.associatedView.imageGallery.reloadData()
            print("ItensLoaded \(self.viewModel.numberOfItemsInSection)")
        }}

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
        //print("willDisplay -> indexPath: \(indexPath.row) filteredImages  \(viewModel.filteredImages.count)")
        if indexPath.row == viewModel.filteredImages.count-1 {
            canRequestMoreItens = true
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.indentifier, for: indexPath) as! GalleryCell
        cell.setupCell(urlString: self.viewModel.filteredImages[indexPath.row].link)
        return cell
    }
    
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) ){
            if  canRequestMoreItens {
                viewModel.pageNumber+=1
                fetchImagesFromVM()
                canRequestMoreItens = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}

////    var images = [Image]() {
//        didSet {
//            DispatchQueue.main.async { [weak self] in
//                self?.associatedView.imageGallery.reloadData()
//            }
//        }
//    }
//
