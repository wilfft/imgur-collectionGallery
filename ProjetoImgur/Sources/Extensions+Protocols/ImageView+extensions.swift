//
//  ImageCache+extension.swift
//  ProjetoImgur
//
//  Created by William on 06/02/22.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
  

extension UIImageView {
    @discardableResult
           func loadImageFromURL(urlString : String, onCompletion : @escaping ()-> Void ) -> URLSessionDataTask? {
               self.image = nil
               if let cachedImage = imageCache.object(forKey: NSString(string: urlString))   {
                   self.image = cachedImage
                   return nil
               }
               guard let url = URL(string: urlString) else {
                   return nil
               }
               let task = URLSession.shared.dataTask(with: url){
                   data, _, _ in
                       if let data = data, let dowloadedImage = UIImage(data: data) {
                           imageCache.setObject(dowloadedImage, forKey: NSString(string: urlString))
                           DispatchQueue.main.async {
                           self.image = dowloadedImage
                           onCompletion()
                           }
                   }
               }
               task.resume()
               return task
           }
}
