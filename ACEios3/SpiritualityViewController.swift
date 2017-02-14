//
//  SpiritualityViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/7/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class SpiritualityViewController: UIViewController {

    @IBOutlet weak var spiritualityImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.spiritualityImageView.layer.cornerRadius = 5
        self.spiritualityImageView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func spiritualityResourcesPressed(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "https://ace.nd.edu/resources/spiritual-resources")! as URL)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
