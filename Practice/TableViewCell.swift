//
//  TableViewCell.swift
//  Practice
//
//  Created by Mitsu Kumagai on 2022/04/04.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var labelB: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.button.layer.borderWidth  = 1
        self.button.layer.borderColor = UIColor.white.cgColor
        self.button.layer.cornerRadius = 13.5
        self.labelB.layer.cornerRadius = 14.5
        
        self.labelB.layer.borderWidth  = 1
        self.labelB.layer.borderColor  = UIColor.red.cgColor
        
        self.contentView.sendSubviewToBack(labelB)
        
//        labelB.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
