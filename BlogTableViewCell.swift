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
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var blogImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
