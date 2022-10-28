//
//  Image.swift
//  Yamb
//
//  Created by Ana Peshevska on 26.10.22.
//

import UIKit

struct Image: Codable {
    let imageData: Data?
    
    init(image: UIImage) {
        self.imageData = image.pngData()
    }
    
    func getImage() -> UIImage? {
        guard let imageData = self.imageData else {
            return nil
        }
        let image = UIImage(data: imageData)
        return image
    }
}
