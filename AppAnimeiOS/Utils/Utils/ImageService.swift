//
//  ImageService.swift
//  AppAnimeiOS
//
//  Created by Juan Diego Marin on 22/11/22.
//

import Foundation
import UIKit

final class ImageService {
    
    private static var images = NSCache<NSString, NSData>()
    
    static func image(for url: URL, completion: @escaping (UIImage?) -> Void) {
        
        if let imageData = images.object(forKey: url.absoluteString as NSString) {
            guard let image = UIImage(data: imageData as Data) else { return }
            completion(image)
            return
        }
            
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                Thread.main { completion(nil) }
                return
            }
            
            guard let response = response else {
                Thread.main { completion(nil) }
                return
            }
            
            guard NetworkingValidator.isFulfilledStatusCode(response: response) else {
                Thread.main { completion(nil) }
                return
            }
            
            guard NetworkingValidator.isImage(response: response) else {
                Thread.main { completion(nil) }
                return
            }
            
            guard let data = data else {
                Thread.main { completion(nil) }
                return
            }
            
            guard let image = UIImage(data: data) else {
                Thread.main { completion(nil) }
                return
            }
            
            self.images.setObject(data as NSData, forKey: url.absoluteString as NSString)

            Thread.main { completion(image)}
        }
        dataTask.resume()
    }
}
