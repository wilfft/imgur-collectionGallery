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
    
    private let network : ServiceProtocol
    var pageNumber = 0
    var filteredImages : [Image] = []
    var numberOfItemsInSection: Int { return filteredImages.count }
    
    init( network : NetworkAPI = NetworkAPI()) {
        self.network = network
    }
    
      func fetchImages(onComplete: @escaping () ->  Void){
           self.network.requestImagesListFromPage(page: pageNumber){ (result: Result<ImgurResponse, RequestImagesError>) in
                  switch result {
                  case let .success(images):
                  self.filteredImages += images.data.filter{ self.filterOnlyImages($0.link) }
                  case let  .failure(error): print(error)
              }
                 onComplete()
            }
          }
     
    
    func filterOnlyImages(_ input : String) -> Bool{
        return input.hasSuffix(".png") || input.hasSuffix(".jpeg") || input.hasSuffix(".jpg") ? true : false
    }
}
