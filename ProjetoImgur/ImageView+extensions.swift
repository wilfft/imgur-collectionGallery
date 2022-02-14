//
//  ImageCache+extension.swift
//  ProjetoImgur
//
//  Created by William on 06/02/22.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
  

extension UIImageView {
    
    func loadImageFromURL(urlString : String, onCompletion : @escaping ()-> Void )   {
      
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
           }
        
        else {
            NetworkAPI.shared.requestImageFromURL(urlString){
                result in
                switch result {
                case .success(let data):
                    imageCache.setObject(data, forKey: NSString(string: urlString))
                    DispatchQueue.main.async {
                        self.image = data
                        onCompletion()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
        
