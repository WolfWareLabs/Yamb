//
//  GlowingLabel.swift
//  Yamb
//
//  Created by Marko on 7/29/22.
//

import Foundation
import UIKit

class GlowingLabel: UILabel {
    var glowColor: CGColor?
    var glowRadius: CGFloat = 0.0
    
    public override func drawText(in rect: CGRect) {
        if (text == nil || glowColor == nil) {
            return
        }
        
        if let context = UIGraphicsGetCurrentContext() {
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
            super.drawText(in: rect)
            
            if let textImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                
                context.saveGState()
                context.setShadow(offset: .zero, blur: glowRadius, color: glowColor)
                
                textImage.draw(at: rect.origin)
                context.restoreGState()
            }
        }
    }
}
