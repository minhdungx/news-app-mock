//
//  HomeCell.swift
//  Mock
//
//  Created by DungHM on 20/11/24.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var shadowWrap : UIView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var thumnailImg: UIImageView!
    @IBOutlet weak var authorLb: UILabel!
    @IBOutlet weak var sourceLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var borderWrap : UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        shadowWrap.dropShadow()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderWrap.roundEachCorners(corners: [.topLeft , .topRight], radius: 30)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
