//
//  Networdk.swift
//  ProjetoImgur
//
//  Created by William on 05/02/22.
//

import Foundation


enum RequestImagesError  : Error {
    case noConnection
    case unavailable
}

protocol GalleryApiProtocol {
    func fetchRequest<T: Codable>(_ urlString : URL, _ onComplete: @escaping  (Result<T, RequestImagesError>) -> Void)
}


final class NetworkAPI {
    func fetchImages(withPage : Int = 0, completion: @escaping (Result<[Image], RequestImagesError>) -> Void){
        guard let url = URL(string: "https://api.imgur.com/3/gallery/r/cats/time/month/" + String(withPage)) else {
            print("erro Network : fetchImages")
            return
        }
        print(url)
        
        var request = URLRequest(url: url)
        
        request.setValue("Client-ID 1ceddedc03a5d71", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
      let dataTask = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if let _  = error  {
                    print("erro : URLSession.shared.dataTask")
                    completion(.failure(RequestImagesError.noConnection))
                }
          
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let decode = try jsonDecoder.decode(ImgurResponse.self, from: data)
                        completion(.success(decode.data))
                        print("terminei")
                    } 
                    catch {
                        print("Erro no Decoder \(error)")
                        completion(.failure(RequestImagesError.unavailable))
                    }
                }
            }
            dataTask.resume() 
    }
}

struct ImgurResponse: Decodable {
    let data: [Image]
}

