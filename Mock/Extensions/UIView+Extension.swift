//
//  Extension.swift
//  Mock
//
//  Created by DungHM on 22/11/24.
//

import UIKit

extension UIView {
    
    func roundEachCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
     
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 4.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func dropShadow(shadowOpacity: Float = 0.2, shadowColor: CGColor = UIColor.gray.cgColor, shadowRadius: CGFloat = 5){
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = shadowRadius	
    }


    
    @IBInspectable
        var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.cornerRadius = newValue
            }
        }
     
     
}
