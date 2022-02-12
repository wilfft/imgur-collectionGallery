//
//  GalleryViewModel.swift
//  ProjetoImgur
//
//  Created by William on 09/02/22.
//

import UIKit
//protocol Teste : AnyObject {
//    func didFetchData()
//
//}

class GalleryViewModel  {
    
    private let network : NetworkAPI
    var pageNumber = 0
    var filteredImages : [Image] = []
    var numberOfItemsInSection: Int { return filteredImages.count }
   
    init( network : NetworkAPI  = NetworkAPI()) {
       self.network = network 
   }
    
    func fetchImages(onCompleted: @escaping () ->  Void){ 
        DispatchQueue.global().sync { self.network.fetchImages(withPage: pageNumber) { (result: Result<[Image], RequestImagesError>) in
            switch result {
            case let .success(images):
                self.filteredImages += images.filter{ self.filterOnlyImages($0.link) } 
            case let  .failure(error): print(error)
        }
            onCompleted()
    }
        }
}
func filterOnlyImages(_ input : String) -> Bool{
    return input.hasSuffix(".png") || input.hasSuffix(".jpeg") || input.hasSuffix(".jpg") ? true : false
}
}
