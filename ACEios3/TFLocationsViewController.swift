//
//  TFLocationsViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/13/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class TFLocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseIdentifier = "locationCell"
    
    var selectedCellIndex = -1
    
    let locations = ["Atlanta, GA", "Austin, TX", "Baton Rouge, LA", "Biloxi, MS", "Brownsville, TX", "Chicago, IL", "Corpus Christi, TX", "Dallas, TX", "Denver, CO", "Fort Worth, TX", "Indianapolis, IN", "Jacksonville, FL", "LA (East), CA", "LA (South Central), CA", "Memphis, TN", "Mission, TX", "Mobile, AL", "New Orleans, LA", "New York, NY", "Oakland, CA", "Oklahoma City, OK", "Peoria, IL", "Phoenix, AZ", "Richmond, VA", "Sacramento, CA", "San Antonio, TX", "San Jose, CA", "Santa Ana, CA", "St. Petersburg, FL", "Tampa, FL", "Tucson, AZ", "Tulsa, OK", "Washington, D.C."]
    
    let numTeachers = ["4", "5", "6", "6", "6", "6", "5", "10", "5", "5", "6", "4", "5", "5", "6", "4", "5", "7", "4", "5", "6", "4", "4", "5", "6", "7", "5", "5", "8", "4", "8", "3", "6"]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 60
        //self.tableView.estimatedRowHeight = 250
        //self.tableView.rowHeight = UITableViewAutomaticDimension;
        let tempImageView = UIImageView(image: UIImage(named: "gray-pattern.png"))
        tempImageView.frame = self.tableView.frame
        self.tableView.backgroundView = tempImageView;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! LocationTableViewCell
        
        cell.cityLabel.text = self.locations[indexPath.row]
        cell.numberOfTeachers.text = "Teachers: " + self.numTeachers[indexPath.row]
        cell.numberOfSchoolsServed.text = "Schools served: 4"
        cell.establishedDate.text = "Est. 1995"
        cell.diocese.text = "Serves Diocese of Biloxi"
        
        
        return cell
        
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        if (self.selectedCellIndex == indexPath.row) {
            self.selectedCellIndex = -1
        }
        else
        {
            self.selectedCellIndex = indexPath.row
        }
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (self.selectedCellIndex == indexPath.row) {
            return 250
        }
        else {
            return 60
        }
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
