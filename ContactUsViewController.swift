//
//  ContactUsViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/13/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var mediaInquiriesButton: UIButton!
    @IBOutlet weak var techSupportButton: UIButton!
    @IBOutlet weak var generalInquiriesButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var faxButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.alignButtonsRight()
    }

    func alignButtonsRight() {
        self.mediaInquiriesButton.contentHorizontalAlignment = .right
        self.techSupportButton.contentHorizontalAlignment = .right
        self.generalInquiriesButton.contentHorizontalAlignment = .right
        self.phoneButton.contentHorizontalAlignment = .right
        self.faxButton.contentHorizontalAlignment = .right
        
    }
    
    
    @IBAction func phonePressed(_ sender: Any) {
        // TODO test this
        // call ACE's phone number
        let phoneNum = self.phoneButton.titleLabel?.text
        if let url = URL(string: "tel://\(phoneNum)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    
    // TODO test the email ones too!
    
    @IBAction func generalPressed(_ sender: Any) {
        let email = self.generalInquiriesButton.titleLabel?.text
        if let url = URL(string: "mailto://\(email)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }

    }
    
    @IBAction func techPressed(_ sender: Any) {
        let email = self.techSupportButton.titleLabel?.text
        if let url = URL(string: "mailto://\(email)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
    
    @IBAction func mediaPressed(_ sender: Any) {
        let email = self.mediaInquiriesButton.titleLabel?.text
        if let url = URL(string: "mailto://\(email)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
