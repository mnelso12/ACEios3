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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //var countriesinEurope = ["France","Spain","Germany"]
    //var countriesinAsia = ["Japan","China","India"]
    //var countriesInSouthAmerica = ["Argentia","Brasil","Chile"]
    
    // TF - Teaching Fellows
    var tfTitles = ["1. Application Type and Term", "2. Personal Information", "3. Test Scores", "4. Academic History", "5. Additional Information", "6. Reference Letters", "7. Downloadable Forms", "8. Uploads", "9. Signature", "10. Review", ""]
    var tfDesc = ["Under \"Applicant type,\" select \"Degree.\" ACE Teaching Fellows is a full-time, degree-seeking program. Please select \"ACE Teaching Fellows - M.Ed.\" The admission term for this cohort is: Summer 2017. Because ACE Teaching Fellows is a cohort-based program, you do not need to select a faculty advisor. If you’ve previously been enrolled at Notre Dame, complete the appropriate section. If you are applying to any other programs at Notre Dame, please indicate that in the appropriate section.", "Complete the personal information page. Please enter your Skype username, as this may be used in interviews later on.",
        "All applicants are required to submit GRE scores taken within the last 5 years. Notre Dame's insitution code is \"1841.\"",
        "For the sake of the application, please upload your unofficial transcript in this section. Your official transcripts will be required upon acceptance into ACE Teaching Fellows.",
        "Complete the \"Rank Performance\" section for any other programs in which you are applying. Under \"Additional Questions,\" when asked if you will be paying your application fee with a waiver, click \"Yes.\" When prompted, enter the code \"ACE39\".",
        "You are required to have four reference letters: 2 from professors, 1 from a peer, and 1 from a residence hall director, campus minister, or service project leader who can attest to your success in living and working in a community atmosphere.",
        "Download the ACE Teaching Fellows Supplement/Program Upload (\"ACE Teaching Fellows - M.Ed.\") and complete the form.",
        "Please submit your \"Program Upload\" (\"ACE Teaching Fellows - M.Ed.\") and your Resume/CV in their related sections. Your photo can be submitted in the \"Additional Documents\" section. The Statement of Intent and a Writing Sample are NOT required for our program.",
        "Input your electronic signature.",
        "Review and confirm that you have completed all parts of the application and submit when complete.", ""]
    
    // RLP - Remick Leadership Program
    var rlpTitles = ["1. Application Type and Term", "2. Personal Information", "3. Test Scores", "4. Academic History", "5. Additional Information", "6. Recommendations", "7. Downloadable Forms", "8. Uploads", "9. Signature", "10. Review", ""]
    var rlpDesc = ["Under \"Applicant type,\" select \"Degree.\" Next to \"Do you plan to attend full time?\" select \"Yes.\" In the dropdown under \"Program Applying To:\" select \"ACE Remick Leadership - M.A.\n\n Please node: Candidates are not eligible to apply to both the ACE Teaching Fellows Program and the Remick Leadership Program. These are two separate programs for teachers in different phases of their careers. ACE Teaching Fellows is for recent college graduates with little to no previous teaching experience, whereas Remick Leadership Program is for current educators and leaders seeking further formation and their Masters in Educational Leadership degree. NOTE: Full-time employment in a Catholic school is a requirement for acceptance into the Remick Leadership Program. The Remick Leadership Program is an \"M.A.\" program while the ACE Teaching Fellows Program is an \"M.Ed.\" Please make sure you're applying to the currect ACE program before you continue.\n\n Provide the name of your (arch)diocese. (You might have to refresh the page for these boxes to show up at first).\n Your internship site is the Catholic school in which you are currently employed (or plan on being employed in the Fall of 2017).\n Provide the address for the internship site.\n Please be as specific as possible when completing your position information (i.e., put \"6/7/8 Language Arts\" instead of just \"Teacher\").\n Next to \"Admission Term\" select \"Summer 2017.\"\n The Remick Leadership Program is a cohort-based program, so you do not need to select a faculty advisor.\n\n If you've previously been enrolled at Notre Dame, complete the appropriate section. If you're applying to any other programs at Notre Dame, please indicate that in the appropriate section.",
        "Complete all of the information in the \"Personal Information\" section.",
        "The Remick Leadership Program only requires the GRE. All applicants are required to submit GRE scores taken within the last 5 years. Notre Dame's insitution code is \"1841.\" Once you have completed the GRE, add the test and date by clicking \"Add Test\" on the page. Log into the ETS website (www.ets.org), and take a screenshot of your scores, and upload that image by clicking \"Browse...\" on the right.",
        "As the instructions state, official transcripts are not required until admission to the program is offered, but we do need copies. These are usually available online. Please submit copies of transcripts for all undergraduate and graduate institutions you have attended.",
        "Complete the \"Additional Information\" page.",
        "You are required to have three recommendations:\n\t 1. From your principal or direct supervisor at your school/diocese\n\t 2. A colleague who can speak to your professional strengths\n\t 3. An academic or other professional reference (i.e. a former professor, pastor at your school, etc.)\n\n Note: While a letter of recommendation is not required from your superintendent, they do need to endorse your participation in the program. Upon completion of your application, we will be in touch with your superintendent or other appropriate diocesan administrators/religious superiors to confirm your endorsement.",
        "Download the \"ACE M.A.\" supplement from this page and follow the directions in that document. IMPORTANT: The \"ACE M.Ed.\" supplement contains directions for a different program. To apply for the Remick Leadership Program, please make sure you have the \"ACE M.A.\" supplement.\n\nYou will upload your completed supplement form in the \"Uploads\" section.",
        "The Remick Leadership Program does not require a Writing Sample. Upload your Resume or CV in the appropriate section. For the \"Statement of Intent,\" please upload a document responding to the following prompt:\n\n Briefly (250 words or less) explain why you feel called to become a Catholic school leader.\n\n Under \"Additional Documents,\" upload your completed supplement under \"Document 1.\" Upload your high-quality headshot under \"Document 2.\"",
        "Input your electronic signature.",
        "Here you will be able to see what parts of hte application you have completed. You may save your progress at any time. Review and confirm that you have completed all parts of the application and submit when complete.\n\nIf you have any questions at any time during the application, feel free to call or email April Garcia, a faculty member and recruiter at agarcia9@nd.edu or 574-631-9309.",
        ""]
    
    
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
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.01, green: 0.16, blue: 0.40, alpha: 1.0)
    }

    

    @IBAction func changedSwitchView(_ sender: Any) {
        print(self.segmentedControl.selectedSegmentIndex)
        self.tableView.reloadData()
    }
    
    
    
    // table view
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            return tfTitles.count + 1 // added dummy row to the end for extra space at the bottom of the table view
        }
        else if (self.segmentedControl.selectedSegmentIndex == 0) {
            return rlpTitles.count + 1 // added dummy row to the end for extra space at the bottom of the table view
        }
        return 11

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
   
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ApplicationTableViewCell
        
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            cell.descLabel.text = tfDesc[indexPath.section]
            cell.titleLabel.text = tfTitles[indexPath.section]
        }
        else if (self.segmentedControl.selectedSegmentIndex == 1) {
            cell.descLabel.text = rlpDesc[indexPath.section]
            cell.titleLabel.text = rlpTitles[indexPath.section]
        }
        
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
