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
    @IBOutlet weak var programTitleLabel: UILabel!
    
    let programs = ["Teaching Fellows", "Remick Leadership Program", "English as a New Language", "Program for Inclusive Education"]
    
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
    var rlpDesc = ["Under \"Applicant type,\" select \"Degree.\" Next to \"Do you plan to attend full time?\" select \"Yes.\" In the dropdown under \"Program Applying To:\" select \"ACE Remick Leadership - M.A.\"\n\nPlease note: Candidates are not eligible to apply to both the ACE Teaching Fellows Program and the Remick Leadership Program. These are two separate programs for teachers in different phases of their careers. ACE Teaching Fellows is for recent college graduates with little to no previous teaching experience, whereas Remick Leadership Program is for current educators and leaders seeking further formation and their Masters in Educational Leadership degree. NOTE: Full-time employment in a Catholic school is a requirement for acceptance into the Remick Leadership Program. The Remick Leadership Program is an \"M.A.\" program while the ACE Teaching Fellows Program is an \"M.Ed.\" Please make sure you're applying to the currect ACE program before you continue.\n\n Provide the name of your (arch)diocese. (You might have to refresh the page for these boxes to show up at first).\n\nYour internship site is the Catholic school in which you are currently employed (or plan on being employed in the Fall of 2017).\n Provide the address for the internship site.\n\nPlease be as specific as possible when completing your position information (i.e., put \"6/7/8 Language Arts\" instead of just \"Teacher\").\n\nNext to \"Admission Term\" select \"Summer 2017.\"\n\nThe Remick Leadership Program is a cohort-based program, so you do not need to select a faculty advisor.\n\nIf you've previously been enrolled at Notre Dame, complete the appropriate section. If you're applying to any other programs at Notre Dame, please indicate that in the appropriate section.",
        "Complete all of the information in the \"Personal Information\" section.",
        "The Remick Leadership Program only requires the GRE. All applicants are required to submit GRE scores taken within the last 5 years. Notre Dame's insitution code is \"1841.\" Once you have completed the GRE, add the test and date by clicking \"Add Test\" on the page. Log into the ETS website (www.ets.org), and take a screenshot of your scores, and upload that image by clicking \"Browse...\" on the right.",
        "As the instructions state, official transcripts are not required until admission to the program is offered, but we do need copies. These are usually available online. Please submit copies of transcripts for all undergraduate and graduate institutions you have attended.",
        "Complete the \"Additional Information\" page.",
        "You are required to have three recommendations:\n\n1. From your principal or direct supervisor at your school/diocese\n\n2. A colleague who can speak to your professional strengths\n\n3. An academic or other professional reference (i.e. a former professor, pastor at your school, etc.)\n\n Note: While a letter of recommendation is not required from your superintendent, they do need to endorse your participation in the program. Upon completion of your application, we will be in touch with your superintendent or other appropriate diocesan administrators/religious superiors to confirm your endorsement.",
        "Download the \"ACE M.A.\" supplement from this page and follow the directions in that document. IMPORTANT: The \"ACE M.Ed.\" supplement contains directions for a different program. To apply for the Remick Leadership Program, please make sure you have the \"ACE M.A.\" supplement.\n\nYou will upload your completed supplement form in the \"Uploads\" section.",
        "The Remick Leadership Program does not require a Writing Sample. Upload your Resume or CV in the appropriate section. For the \"Statement of Intent,\" please upload a document responding to the following prompt:\n\n Briefly (250 words or less) explain why you feel called to become a Catholic school leader.\n\n Under \"Additional Documents,\" upload your completed supplement under \"Document 1.\" Upload your high-quality headshot under \"Document 2.\"",
        "Input your electronic signature.",
        "Here you will be able to see what parts of hte application you have completed. You may save your progress at any time. Review and confirm that you have completed all parts of the application and submit when complete.\n\nIf you have any questions at any time during the application, feel free to call or email April Garcia, a faculty member and recruiter at agarcia9@nd.edu or 574-631-9309.",
        ""]
    
    // enl - English as a New Language
    let enlTitles = ["1. Background Information", "2. Demographics", "3. Academic History", "4. Teaching Information", "5. School Information", "6. Short Answer Questions", "7. Commitment Acknowledgement", "8. Principal Recommendation", "9. Official Transcripts", "10. Principal Recommendation Form completed by a School Administrator", "11. Tuition Assistance Form", ""]
    let enlDesc = ["Name\nContact information",
                   "Gender and ethnicity\nLanguage proficiencies (if applicable)",
                   "Undergraduate degree and G.P.A\nGraduate degree and G.P.A (if applicable)",
                   "Subjects taught\nGrade level\nTeaching experience\nTeaching license (if applicable)\nNote: a copy of license must be uploaded\nResume \n\nNote: a current resume or C.V. must be uploaded",
                   "Contact information\nEnrollment\nPercentage of English language learners\nLatino population growth in recent years\nOther ESL/ENL/ELL teachers on staff\nPrincipal information",
                   "(500 words or less)\n\nNote: short answer responses are best prepared ahead of time and cut and pasted into the application\n\n1. Explain your experience teaching English language learners\n\n2. Explain why you would like to participate in the English as a New Language Program\n\n3. Make the case for why ENL/ESL resources are needed at your school",
                   "Knowledge of and commitment to the terms of the ENL program",
                   "Principal recommender contact information\n\nNote: You must ask your principal (or the one person who can speak to your teaching and professional background, if you are a sitting principal) to complete the online principal recommendation form",
                   "Official university transcripts should be mailed directly to:\n\nJennifer Dees\n107 Carole Sander Hall\nNotre Dame, IN 46556",
                   "(completed online)",
                   "(optional; completed online)",
                   ""]
    
    // pie - Program for Inclusive Education
    let pieTitles = ["1. Online Application", "2. Teacher license", "3. Current Photo", "4. Principal Recommendation", "5. Scholarship Request"]
    let pieDesc = ["",
                   "",
                   "",
                   "",
                   "",
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
        self.programTitleLabel.text = self.programs[self.segmentedControl.selectedSegmentIndex]
        self.tableView.reloadData()
    }
    
    
    
    // table view
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            return tfTitles.count // added dummy row to the end for extra space at the bottom of the table view
        }
        else if (self.segmentedControl.selectedSegmentIndex == 1) {
            return rlpTitles.count // added dummy row to the end for extra space at the bottom of the table view
        }
        else if (self.segmentedControl.selectedSegmentIndex == 2) {
            return enlTitles.count // added dummy row to the end for extra space at the bottom of the table view
        }
        else if (self.segmentedControl.selectedSegmentIndex == 3) {
            return pieTitles.count // added dummy row to the end for extra space at the bottom of the table view
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
        else if (self.segmentedControl.selectedSegmentIndex == 2) {
            cell.descLabel.text = enlDesc[indexPath.section]
            cell.titleLabel.text = enlTitles[indexPath.section]
        }
        else if (self.segmentedControl.selectedSegmentIndex == 3) {
            cell.descLabel.text = pieDesc[indexPath.section]
            cell.titleLabel.text = pieTitles[indexPath.section]
        }
        
        return cell
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        /*
        if (indexPath.row == 1 && self.segmentedControl.selectedSegmentIndex == 3) { // PIE online application link
            if let url = URL(string: "https://nd.qualtrics.com/jfe/form/SV_4Jifwkgc8KEEQBL") {
                UIApplication.shared.open(url, options: [:])
            }
        }
        else if (indexPath.row == 4 && self.segmentedControl.selectedSegmentIndex == 3) { // PIE principal recommendation link
            if let url = URL(string: "https://nd.qualtrics.com/jfe5/form/SV_bayP0ClxcrgtkZD") {
                UIApplication.shared.open(url, options: [:])
            }
        }
 */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
