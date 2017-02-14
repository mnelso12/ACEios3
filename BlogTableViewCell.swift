//
//  BlogTableViewCell.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 1/26/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class BlogTableViewCell: UITableViewCell {

    
    @IBOutlet weak var blogTitle: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var blogImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.blogTitle.font = UIFont(name: "GaramondPremrPro", size: 22)
        self.detailLabel.font = UIFont(name: "GalaxiePolaris-Medium", size: 15)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
