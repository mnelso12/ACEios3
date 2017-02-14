//
//  LocationTableViewCell.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/13/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var numberOfTeachers: UILabel!
    @IBOutlet weak var numberOfSchoolsServed: UILabel!
    @IBOutlet weak var diocese: UILabel!
    @IBOutlet weak var establishedDate: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var seeOnlineButton: UIButton!
    


    
     let urlPath = ["atlanta", "austin", "baton-rouge", "biloxi", "brownsville", "chicago", "corpus-christi", "dallas", "denver", "fort-worth", "indianapolis", "jacksonville", "la-east", "lasc", "memphis", "mission", "mobile", "new-orleans", "new-york", "oakland", "oklahoma-city", "peoria", "phoenix", "richmond", "sacramento", "san-antonio", "san-jose", "santa-ana", "st-petersburg", "tampa", "tucson", "tulsa", "washington-dc"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.locationImageView.layer.cornerRadius = 5
        self.locationImageView.clipsToBounds = true
        
        self.seeOnlineButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // TODO this function is called too many times! Need a function that is called only when this cell is selected (this func is also called during initialization, so all the "see online" buttons appear)
        // show "see online" button when the cell is selected / expands
        self.seeOnlineButton.isHidden = false
    }
    
    @IBAction func pressedSeeOnline(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "https://ace.nd.edu/teach/" + urlPath[self.seeOnlineButton.tag])! as URL)
    }
   
}
