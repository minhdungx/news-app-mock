//
//  CategoryCell.swift
//  Mock
//
//  Created by DungHM on 21/11/24.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var logoBg : UIView!
    @IBOutlet weak var shadowWrap : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        logoBg.setGradient(fillColors: [CategoryCell.UIColorFromRGB(0x5d20cd), CategoryCell.UIColorFromRGB(0x884ff1)], orientation: .vertical)
        logoBg.roundEachCorners(corners: [.topRight , .bottomRight], radius: 20)
        dropShadow(view: shadowWrap)
    }
    
    func dropShadow(view: UIView, shadowOpacity: Float = 0.2, shadowColor: CGColor = UIColor.gray.cgColor, shadowRadius: CGFloat = 5){
        view.layer.shadowColor = shadowColor
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = shadowRadius
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static func UIColorFromRGB(_ rgbValue: Int) -> UIColor! {
        return UIColor(
            red: CGFloat((Float((rgbValue & 0xff0000) >> 16)) / 255.0),
            green: CGFloat((Float((rgbValue & 0x00ff00) >> 8)) / 255.0),
            blue: CGFloat((Float((rgbValue & 0x0000ff) >> 0)) / 255.0),
            alpha: 1.0)
    }
    
    
}


enum GradientOrientation {
    case vertical
    case horizontal
    case downDiagonal
    case upDiagonal
}

extension UIView {
    func setGradient(borderColors: [UIColor], lineWidth: CGFloat, orientation: GradientOrientation) {
        _ = self.layer.sublayers?.map {
            if $0 is CAGradientLayer {
                $0.removeFromSuperlayer()
            }
        }
        let gradient = CAGradientLayer()
        gradient.colors = borderColors.map { $0.cgColor }
        gradient.frame =  CGRect(origin: .zero, size: self.frame.size)
        gradient.cornerRadius = self.cornerRadius
        gradient.masksToBounds = true
        switch orientation {
        case .vertical:
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        case .downDiagonal:
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        case .upDiagonal:
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: 0)
        }
        
        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
        shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        
        gradient.mask = shape
        
        self.layer.addSublayer(gradient)
    }
    
    func setGradient(fillColors: [UIColor], orientation: GradientOrientation) {
        _ = self.layer.sublayers?.map {
            if $0 is CAGradientLayer {
                $0.removeFromSuperlayer()
            }
        }
        let gradient = CAGradientLayer()
        gradient.colors = fillColors.map { $0.cgColor }
        gradient.frame =  CGRect(origin: .zero, size: self.frame.size)
        gradient.cornerRadius = self.cornerRadius
        gradient.masksToBounds = true
        switch orientation {
        case .vertical:
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        case .downDiagonal:
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        case .upDiagonal:
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: 0)
        }
        self.layer.insertSublayer(gradient, at: 0)
    }
}

