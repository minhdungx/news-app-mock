//
//  Networking.swift
//  Mock
//
//  Created by DungHM on 25/11/24.
//

enum APIError: Error {
    case error(String)
    case errorURL
    
    var localizedDescription: String {
        switch self {
        case .error(let string):
            return string
        case .errorURL:
            return "URL String is error."
        }
    }
}

import Foundation
import UIKit

final class NetworkingManager {
    private static var sharedNetworking : NetworkingManager {
        let networking = NetworkingManager()
        return networking
    }
    
    class func shared() -> NetworkingManager{
        return sharedNetworking
    }
    
    private init() {}
    
    func request(with urlString: String, completion: @escaping (Data?, APIError?) -> Void) {
            guard let url = URL(string: urlString) else {
                let error = APIError.error("URL lỗi")
                completion(nil, error)
                return
            }
            
            let config = URLSessionConfiguration.ephemeral
            config.waitsForConnectivity = true
            
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(nil, APIError.error(error.localizedDescription))
                    } else {
                        if let data = data {
                            completion(data, nil)
                        } else {
                           completion(nil, APIError.error("Data format is error."))
                        }
                    }
                }
            }
            task.resume()
        }
    
    
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void) {
            guard let url = URL(string: url) else {
                completion(nil)
                return
            }
            let config = URLSessionConfiguration.default
            config.waitsForConnectivity = true
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let _ = error {
                        completion(nil)
                    } else {
                        if let data = data {
                            let image = UIImage(data: data)
                            completion(image)
                        } else {
                            completion(nil)
                        }
                    }
                }
            }
            task.resume()
        }

}
