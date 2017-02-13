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
    //@IBOutlet weak var cityLabel: UIButton!
    
     let urlPath = ["atlanta", "austin", "baton-rouge", "biloxi", "brownsville", "chicago", "corpus-christi", "dallas", "denver", "fort-worth", "indianapolis", "jacksonville", "la-east", "lasc", "memphis", "mission", "mobile", "new-orleans", "new-york", "oakland", "oklahoma-city", "peoria", "phoenix", "richmond", "sacramento", "san-antonio", "san-jose", "santa-ana", "st-petersburg", "tampa", "tucson", "tulsa", "washington-dc"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //@IBAction func cityPress(_ sender: Any) {
    //    print("is pressed")
    //}

}
