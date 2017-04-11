//
//  TFLocationsViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/13/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class TFLocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var tappedImageView:UIImageView!
    
    let cellReuseIdentifier = "locationCell"
    
    var selectedCellIndex = -1
    
    let locations = ["Atlanta, GA", "Austin, TX", "Baton Rouge, LA", "Biloxi, MS", "Brownsville, TX", "Chicago, IL", "Corpus Christi, TX", "Dallas, TX", "Denver, CO", "Fort Worth, TX", "Indianapolis, IN", "Jacksonville, FL", "LA (East), CA", "LA (South Central), CA", "Memphis, TN", "Mission, TX", "Mobile, AL", "New Orleans, LA", "New York, NY", "Oakland, CA", "Oklahoma City, OK", "Peoria, IL", "Philadelphia, PA", "Phoenix, AZ", "Richmond, VA", "Sacramento, CA", "San Antonio, TX", "San Jose, CA", "Santa Ana, CA", "St. Petersburg, FL", "Stockton, CA", "Tampa, FL", "Tucson, AZ", "Tulsa, OK", "Washington, D.C."]
    
    let estDates = ["1998", "2000", "1994", "1995", "1997", "2013", "1996", "1997", "2005", "1996", "2015", "1994", "2000", "2000", "1999", "1998", "1994", "2007", "2016", "2011", "1994", "2015", "2017", "2000", "2010", "2010", "2003", "2015", "2013", "1997", "2017", "2014", "2001", "1996", "2006"]

    let numTeachers = ["4", "5", "6", "6", "6", "6", "5", "10", "5", "5", "6", "4", "5", "5", "6", "4", "5", "7", "4", "5", "6", "4", "4","4", "5", "6", "7", "5", "5", "8", "4", "4", "8", "3", "6"]
    
    let numSchools = ["3", "4", "3", "4", "3", "5", "3", "6", "5", "4", "4", "4", "2", "3", "3", "4", "3", "7", "4", "5", "4", "2", "3", "3", "2", "4", "6", "3", "5", "4", "4", "2", "6", "3", "5"]
    

    let diocese = ["Archdiocese of Atlanta", "Diocese of Austin", "Diocese of Baton Rouge", "Diocese of Biloxi", "Diocese of Brownsville", "Archdiocese of Chicago", "Diocese of Corpus Cristi", "Diocese of Dallas", "Archdiocese of Denver", "Diocese of Fort Worth", "Archdiocese of Indianapolis", "Diocese of St. Augustine", "Archdiocese of Los Angeles", "Archdiocese of Los Angeles", "Diocese of Memphis", "Diocese of Brownsville", "Archdiocese of Mobile", "Archdiocese of New Orleans", "Archdiocese of New York", "Diocese of Oakland", "Archdiocese of Oklahoma City", "Diocese of Peoria", "Archdiocese of Philadelphia", "Diocese of Phoenix", "Diocese of Richmond", "Diocese of Sacramento", "Archdiocese of San Antonio", "Diocese of San Jose", "Diocese of Orange", "Diocese of St. Petersburg", "Diocese of Stockton", "Diocese of St. Petersburg", "Diocese of Tucson", "Diocese of Tulsa", "Archdiocese of Washington D.C."]
    
   let images = ["atlanta.jpg", "austin.jpg", "batonrouge.jpg", "biloxi.jpg", "brownsville.jpg", "chicago.jpg", "corpuschristi.jpg", "dallas.jpg", "denver.jpg", "fortworth.jpg", "indianapolis.jpg", "jacksonville.jpg", "losangeleseast.jpg", "losangelessouthcentral.jpg", "memphis.jpg", "mission.jpg", "mobile.jpg", "neworleans.jpg", "newyork.jpg", "oakland.jpg", "oklahomacity.jpg", "peoria.jpg", "ace-logo.jpg", "phoenix.jpg", "richmond.jpg", "sacramento.jpg", "sanantonio.jpg", "sanjose.jpg", "santaana.jpg", "stpetersburg.jpg", "ace-logo.jpg", "tampa.jpg", "tucson.jpg", "tulsa.jpg", "washingtondc.jpg"]
    
    
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
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.01, green: 0.16, blue: 0.40, alpha: 1.0)
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
        cell.numberOfSchoolsServed.text = "Schools served: " + self.numSchools[indexPath.row]
        cell.establishedDate.text = "Est. " + self.estDates[indexPath.row]
        cell.diocese.text = "Serves " + self.diocese[indexPath.row]
        
        /*
        cell.locationImageView.contentMode = UIViewContentMode.center;
        
        if (cell.locationImageView.bounds.size.width > ((UIImage*)imagesArray[i]).size.width && cell.locationImageView.bounds.size.height > ((UIImage*)imagesArray[i]).size.height) {
            cell.locationImageView.contentMode = UIViewContentMode.scaleAspectFit;
        }
        */
        
        let imageName =  "communityPhotos/" + self.images[indexPath.row]
        cell.locationImageView.contentMode = UIViewContentMode.scaleAspectFit
        cell.locationImageView.image = UIImage(named: imageName)
        //cell.locationImageView.isUserInteractionEnabled = true
        //cell.locationImageView.isMultipleTouchEnabled = true
        //cell.locationImageView.addGestureRecognizer(
        //    UITapGestureRecognizer.init(target: self, action: #selector(TFLocationsViewController.didTapImageView(_:))
        //    )
        //)
        
        cell.seeOnlineButton.tag = indexPath.row
        
        if (self.selectedCellIndex == indexPath.row) {
            cell.seeOnlineButton.isHidden = true
            cell.expandedView.isHidden = false
        }
        
        return cell
        
    }
    /*
    // make image full screen when tapped
    func didTapImageView(_ sender: UITapGestureRecognizer) {
        print("tapped", sender)
        let selectedCell = sender as! LocationTableViewCell
        let imageView = selectedCell.locationImageView
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        imageView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
    }
 */
    
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
            return 240
        }
        else {
            return 60
        }
    }

}
