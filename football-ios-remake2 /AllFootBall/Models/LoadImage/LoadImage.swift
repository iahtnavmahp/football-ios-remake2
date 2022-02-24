//
//  LoadImage.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 07/07/2021.
//

import Foundation
import UIKit
final class LoadImage {
    //MARK: - singleton
    private static var sharedNetworking: LoadImage = {
        let networking = LoadImage()
        return networking
    }()
    
    class func shared() -> LoadImage {
        return sharedNetworking
    }
    
    //MARK: - init
    private init() {}
    
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
