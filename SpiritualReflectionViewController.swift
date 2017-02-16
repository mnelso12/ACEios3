//
//  SpiritualReflectionViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/15/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class SpiritualReflectionViewController: UIViewController {

    var weeklyRef:String! = ""
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.textView.text = self.weeklyRef
        self.textView.font = UIFont(name: "GalaxiePolaris-Medium", size: 15)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
