//
//  LinksViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/11/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class LinksViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellReuseIdentifier = "socialMediaCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //self.collectionView.backgroundColor = UIColor(patternImage: UIImage(named:"gray-pattern.png")!)
        
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath) as! SocialMediaCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let greenColor = UIColor(red: 0.0, green: 0.52, blue: 0.247, alpha: 1.0)
        //let blueColor = UIColor(red: 0.0, green: 0.411, blue: 0.667, alpha: 1.0)
        
        if (indexPath.row == 0) {
            cell.imageView.setFAIconWithName(icon: .FAFacebook, textColor: greenColor)
        }
        else if (indexPath.row == 1) {
            cell.imageView.setFAIconWithName(icon: .FATwitter, textColor: greenColor)
        }
        else if (indexPath.row == 2) {
            cell.imageView.setFAIconWithName(icon: .FALinkedin, textColor: greenColor)
        }
        else if (indexPath.row == 3) {
            cell.imageView.setFAIconWithName(icon: .FAPinterest, textColor: greenColor)
        }
        else if (indexPath.row == 4) {
            cell.imageView.setFAIconWithName(icon: .FAInstagram, textColor: greenColor)
        }
        else if (indexPath.row == 5) {
            cell.imageView.setFAIconWithName(icon: .FAVimeo, textColor: greenColor)
        }
        else if (indexPath.row == 6) {
            cell.imageView.setFAIconWithName(icon: .FAYoutubePlay, textColor: greenColor)
        }
        else if (indexPath.row == 7) {
            cell.imageView.setFAIconWithName(icon: .FAEnvelope, textColor: greenColor)
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        var url = " "
        if (indexPath.row == 0) { // facebook
            url = "https://www.facebook.com/AllianceforCatholicEducation"
        }
        else if (indexPath.row == 1) { // twitter
            url = "https://twitter.com/aceatnd"
        }
        else if (indexPath.row == 2) { // linkedin
            url = "https://www.linkedin.com/groups/3774382/profile"
        }
        else if (indexPath.row == 3) { // pinterest
            url = "https://www.pinterest.com/aceatnd/"
        }
        else if (indexPath.row == 4) { // instagram
            url = "https://www.instagram.com/aceatnd/"
        }
        else if (indexPath.row == 5) { // vimeo
            url = "https://vimeo.com/aceatnd/"
        }
        else if (indexPath.row == 6) { // youtube
            url = "https://www.youtube.com/user/ACEatND"
        }
        else if (indexPath.row == 7) { // email
            let email = "ace.1@nd.edu"
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url)
            }
            return
        }
        
        if let url = URL(string: url) {
            UIApplication.shared.open(url, options: [:])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nominateLeaderPressed(_ sender: Any) {
        if let url = URL(string: "https://nd.qualtrics.com/jfe/form/SV_5tCq3aDJR0jfzmt") {
            UIApplication.shared.open(url, options: [:])
        }
    }

    @IBAction func pressedJobBoard(_ sender: Any) {
        if let url = URL(string: "https://ace.nd.edu/job-board") {
            UIApplication.shared.open(url, options: [:])
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
