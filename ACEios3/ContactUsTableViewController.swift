//
//  ContactUsTableViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 3/8/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class ContactUsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let section2Labels = ["General Inquiries", "Technology Support", "Media Inquiries"]
    let section3Labels = ["Teaching Fellows", "Remick Leadership\nProgram", "English as a\nNew Language", "Program for\nInclusive Education", "Program for\nEducational Access", "ACE Interns\nand Ambassadors"]
    
    let section1 = ["574-631-7052", "574-631-7939", "107 Carole Sandner Hall\nNotre Dame, IN 46556"]
    let section2 = ["ace1@nd.edu", "twill1@nd.edu", "thelm1@nd.edu"]
    let section3 = ["mpicken1@nd.edu\nmcomunie@nd.edu", "agarcia9@nd.edu", "kwalter5@nd.edu", "lindsaywill@nd.edu\ncbonfiglio@nd.edu", "edaccess@nd.edu", "mcomunie@nd.edu"]

    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "contactUsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // table view background image
        let tempImageView = UIImageView(image: UIImage(named: "bluePattern.png"))
        tempImageView.frame = self.tableView.frame
        self.tableView.backgroundView = tempImageView;
        
        // set back button to be blue
         self.navigationController?.navigationBar.tintColor = UIColor(red: 0.01, green: 0.16, blue: 0.40, alpha: 1.0)
        
        
        // make cell row height adjust to content inside
        self.tableView.estimatedRowHeight = 55.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
    }

    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return section1.count
        }
        else if (section == 1) {
            return section2.count
        }
        else if (section == 2) {
            return section3.count
        }
        else if (section == 3) {
            return 0
        }
        else {
            print("ERROR! section not found in contact us table view")
            return 0
        }

    }
    
    // do section stuff
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.clear
        
        return vw
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ContactUsTableViewCell
        
        cell.label.font = cell.label.font.withSize(15)
        
        
        if (indexPath.section == 1) { // second - inquiries section
            cell.label.text = section2Labels[indexPath.row]
            cell.detailLabel.text = section2[indexPath.row]
        }
        else if (indexPath.section == 2) { // second - inquiries section
            cell.label.text = section3Labels[indexPath.row]
            cell.detailLabel.text = section3[indexPath.row]
        }
        else if (indexPath.section == 0) { // first - icon section
            cell.detailLabel.text = section1[indexPath.row]
            if (indexPath.row == 2) {
                cell.label.setFAIcon(icon: .FAEnvelope, iconSize: 25)
            }
            else if (indexPath.row == 0) {
                cell.label.setFAIcon(icon: .FAPhone, iconSize: 25)
            }
            else if (indexPath.row == 1) {
                cell.label.setFAIcon(icon: .FAFax, iconSize: 25)
            }
        }
        
        return cell
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
