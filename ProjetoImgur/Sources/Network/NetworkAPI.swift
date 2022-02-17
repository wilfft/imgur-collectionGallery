//
//  Networdk.swift
//  ProjetoImgur
//
//  Created by William on 05/02/22.
//

import Foundation
import UIKit
 
struct ImgurResponse: Codable {
    let data: [Image]
}

enum RequestImagesError  : Error  {
    case noConnection
    case unavailable
    case error
}

protocol ServiceProtocol {
    func requestImageFromURL(_ urlString: String, _ onComplete: @escaping (Result<UIImage, RequestImagesError>) -> Void)
    func requestImagesListFromPage(page : Int, _ onComplete: @escaping  (Result<ImgurResponse, RequestImagesError>) -> Void)
}

final class NetworkAPI : ServiceProtocol {
   static let shared = NetworkAPI()
    
    func requestImagesListFromPage(page: Int, _ onComplete: @escaping (Result<ImgurResponse, RequestImagesError>) -> Void) {
        guard let url = URL(string: "https://api.imgur.com/3/gallery/r/cats/time/month/" + String(page))
       else {
            onComplete(.failure(RequestImagesError.unavailable))
            return
        }
        print(url)
        self.requestObject(url, onComplete: onComplete)
    }
   
    func requestImageFromURL(_ urlString: String, _ onComplete: @escaping (Result<UIImage, RequestImagesError>) -> Void){
        guard let url = URL(string: urlString) else { return }
        let request = createRequest(url)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _  = error  {
                onComplete(.failure(.unavailable))
            }
            if let data = data, let dowloadedImage = UIImage(data: data) {
                   onComplete(.success(dowloadedImage))
                    }
                }
        dataTask.resume()
    }
    
    
   private func requestObject<T : Decodable>(  _ url : URL, onComplete: @escaping (Result<T, RequestImagesError>) -> Void)   {
       let request = createRequest(url)
       DispatchQueue.global().sync {
           let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
              if let _  = error  {
                   print("erro : URLSession.shared.dataTask")
                   onComplete(.failure(.unavailable))
               }
               if let data = data {
                   do {
                       let jsonDecoder = JSONDecoder()
                          let decode = try jsonDecoder.decode(T.self  , from: data)
                           onComplete(.success(decode))
                   }
                   catch {
                       print("Decoder error \(error)")
                       onComplete(.failure(RequestImagesError.unavailable))
                   }
               } 
           }
           dataTask.resume()
       }
    }
}

extension NetworkAPI {
    private func createRequest(_ url : URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.setValue("Client-ID 1ceddedc03a5d71", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

 
