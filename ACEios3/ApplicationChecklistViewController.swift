//
//  ApplicationChecklistViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/2/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class ApplicationChecklistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var countriesinEurope = ["France","Spain","Germany"]
    var countriesinAsia = ["Japan","China","India"]
    var countriesInSouthAmerica = ["Argentia","Brasil","Chile"]
    
    var titles = ["1. Application Type and Term", "2. Personal Information", "3. Test Scores", "4. Academic History", "5. Additional Information", "6. Reference Letters", "7. Downloadable Forms", "8. Uploads", "9. Signature", "10. Review", ""]
    var desc = ["Under \"Applicant type,\" select \"Degree.\" ACE Teaching Fellows is a full-time, degreeseeking program. Please select \"ACE Teaching Fellows - M.Ed.\" The admission term for this cohort is: Summer 2017. Because ACE Teaching Fellows is a cohort-based program, you do not need to select a faculty advisor. If you’ve previously been enrolled at Notre Dame, complete the appropriate section. If you are applying to any other programs at Notre Dame, please indicate that in the appropriate section.", "Complete the personal information page. Please enter your Skype username, as this may be used in interviews later on.",
        "All applicants are required to submit GRE scores taken within the last 5 years. Notre Dame's insitution code is \"1841.\"",
        "For the sake of the application, please upload your unofficial transcript in this section. Your official transcripts will be required upon acceptance into ACE Teaching Fellows.",
        "Complete the \"Rank Performance\" section for any other programs in which you are applying. Under \"Additional Questions,\" when asked if you will be paying your application fee with a waiver, click \"Yes.\" When prompted, enter the code \"ACE39.\"",
        "You are required to have four reference letters: 2 from professors, 1 from a peer, and 1 from a residence hall director, campus minister, or service project leader who can attest to your success in living and working in a community atmosphere.",
        "Download the ACE Teaching Fellows Supplement/Program Upload (\"ACE Teaching Fellows - M.Ed.\") and complete the form.",
        "Please submit your \"Program Upload\" (\"ACE Teaching Fellows - M.Ed.\") and your Resume/CV in their related sections. Your photo can be submitted in the \"Additional Documents\" section. The Statement of Intent and a Writing Sample are NOT required for our program.",
        "Input your electronic signature.",
        "Review and confirm that you have completed all parts of the application and submit when complete.", ""]
    
    
    let cellReuseIdentifier = "applyChecklistCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // so table cell height adjusts to fit content
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        
        UITableView.appearance().separatorColor = UIColor.clear
        
        let tempImageView = UIImageView(image: UIImage(named: "gray-pattern.png"))
        tempImageView.frame = self.tableView.frame
        self.tableView.backgroundView = tempImageView;
    }

    
    
    
    
    
    // table view
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 11 // added dummy row to the end for extra space at the bottom of the table view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
   
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ApplicationTableViewCell
        
        cell.descLabel.text = desc[indexPath.section]
        cell.titleLabel.text = titles[indexPath.section]
        
        return cell
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
