//
//  UIImage+extensions.swift
//  ConfusedMind
//
//  Created by Satish Birajdar on 2017-10-17.
//  Copyright © 2017 SBSoftwares. All rights reserved.
//

import UIKit

extension UIImage {
    
    func isEqualToImage(image: UIImage) -> Bool {
        let data1: NSData = UIImagePNGRepresentation(self)! as NSData
        let data2: NSData = UIImagePNGRepresentation(image)! as NSData
        return data1.isEqual(data2)
    }
    
}
