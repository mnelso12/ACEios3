//
//  SpiritualityViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/7/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class SpiritualityViewController: UIViewController {

    @IBOutlet weak var spiritualityImageView: UIImageView!
    
    let apikey = "3009947f4086c85e7b735f4b4222e514-us2"
    var weeklyRef = " "
    let numReflectionIDsLoaded = "1" // should be one as long as we only care about the first most recent refletion
    var thisWeeksReflectionID = "-1"
    
    var activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge) // loading icon
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.spiritualityImageView.layer.cornerRadius = 5
        self.spiritualityImageView.clipsToBounds = true
        
        self.styleLoadingIcon()
    }
    
    
    func styleLoadingIcon() {
        // is already declared as class variable
        activityView.center = self.view.center
        activityView.color = UIColor.black
        activityView.backgroundColor = UIColor.white
    }
    
    func getThisWeeksSpiritualReflectionID() {
        let urlString = "https://us2.api.mailchimp.com/3.0/campaigns?folder_id=be2244f13f&sort_dir=DESC&count=" + self.numReflectionIDsLoaded
        let url = URL(string: urlString)
        let param = "apikey " + self.apikey
        let request = NSMutableURLRequest(url: url!)
        var id = "" // this weeks id, will be returned at end
        
        request.setValue(param, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            DispatchQueue.main.async(){
                
                guard let data = data, error == nil else { return }
                
                
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                if (statusCode == 200) {
                    print("Everyone is fine IN SPIRITUAL REFLECTION, file downloaded successfully.")
                    do{
                        
                        let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
                        print(json)
                        
                        var objIndex = 0
                        for obj in json {
                            
                            if (objIndex == 1) {
                                print(obj.value)
                                let array = (obj.value as! NSArray).mutableCopy() as! NSMutableArray
                                let thing = array[0] as! [String:AnyObject]
                                id = thing["id"] as! String
                                self.loadWeeklySpiritualReflection(id:id)
                            }
                            objIndex += 1
                        }
                        
                        
                    }catch {
                        print("Error IN SPIRITUALITY with Json: \(error)")
                    }
                }
                print("ending dispatch queue IN SPIRITUALITY")
                // now segue!
            }
        }
        task.resume()
    }

    func loadWeeklySpiritualReflection(id: String) {
        
        if (id == "-1") {
            print("Error! Could not load spiritualReflection because didn't find the ID yet")
            return
        }
        
        let urlString = "https://us2.api.mailchimp.com/3.0/campaigns/" + id + "/content"
        let url = URL(string: urlString)
        let param = "apikey " + self.apikey
        let request = NSMutableURLRequest(url: url!)
        
        request.setValue(param, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let session = URLSession.shared
        
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
                
                DispatchQueue.main.async(){
                    
                    guard let data = data, error == nil else { return }
                    
                    
                    let httpResponse = response as! HTTPURLResponse
                    let statusCode = httpResponse.statusCode
                    
                    if (statusCode == 200) {
                        print("Everyone is fine, file downloaded successfully.")
                        do{
                            
                            let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
                            //print(json)
                            
                            let plainText = json["plain_text"] as! String?
                            self.parseJSONforSpiritualReflection(json: plainText!)
                            
                            
                        }catch {
                            print("Error with Json: \(error)")
                        }
                    }
                    print("ending dispatch queue ")
                }
            }
            task.resume()
        }
    
    func parseJSONforSpiritualReflection(json:String) {
        
        var indexInt = 0
        var isPartOfSpiritalReflection = false
        var spiritualReflection = ""
        
        for index in json.characters.indices {

            
            if (json[index] == "S") {
                
                let start = json.index(json.startIndex, offsetBy: indexInt+1)
                let end = json.index(json.startIndex, offsetBy: indexInt+20)
                let range = start..<end

                
                if (json.substring(with: range) == "piritual Reflection") { // check if this is "Spiritual Reflection, if so we will append it to our spiritual reflection string"
                    isPartOfSpiritalReflection = true
                }
                            }
            else if (json[index] == "=") {
                
                let start = json.index(json.startIndex, offsetBy: indexInt+1)
                let end = json.index(json.startIndex, offsetBy: indexInt+11)
                let range = start..<end

                
                if (json.substring(with: range) == "==========") { // check if this is a line break separator thing, we dont want the stuff after this
                    isPartOfSpiritalReflection = false
                }

            }

            
            if (isPartOfSpiritalReflection == true) {
                spiritualReflection.append(json[index])
            }
            
            indexInt += 1
        }

        self.weeklyRef = spiritualReflection
        
        // segue to spiritual reflection view controller
        nowSegue()

    }

    func nowSegue() {
        performSegue(withIdentifier: "viewSpiritualReflection", sender: self)
    }
    
    
    @IBAction func weeklySpiritualReflectionPressed(_ sender: Any) {
        activityView.startAnimating()
        self.view.addSubview(activityView)
        
        getThisWeeksSpiritualReflectionID()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in prepare for segue...")
        
        let destinationVC = segue.destination as! SpiritualReflectionViewController
        destinationVC.weeklyRef = self.weeklyRef
        
        self.activityView.removeFromSuperview()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func spiritualityResourcesPressed(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "https://ace.nd.edu/resources/spiritual-resources")! as URL)

    }

  
}
