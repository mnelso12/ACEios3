//
//  NewsletterViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/11/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class NewsletterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpForNewsletter(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "http://ace.us2.list-manage.com/subscribe?u=5999fc41ff424155ced84575a&id=f881afc9ef")! as URL)
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
