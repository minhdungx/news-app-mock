//
//  EventCell.swift
//  Mock
//
//  Created by DungHM on 20/11/24.
//

import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var shadowWrap : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        dropShadow(view: shadowWrap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dropShadow(view: UIView, shadowOpacity: Float = 0.2, shadowColor: CGColor = UIColor.gray.cgColor, shadowRadius: CGFloat = 5){
        view.layer.shadowColor = shadowColor
        view.layer.shadowOpacity = shadowOpacity
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = shadowRadius
    }
    
}
