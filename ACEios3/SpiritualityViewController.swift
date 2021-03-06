//
//  SpiritualityViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/7/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit
import ImageSlideshow
import Foundation // for network check
import SystemConfiguration // for network check


class SpiritualityViewController: UIViewController {

    //@IBOutlet weak var spiritualityImageView: UIImageView!
    
    let apikey = "3009947f4086c85e7b735f4b4222e514-us2"
    var weeklyRef = " "
    var weeklyRefHTML = " "
    let numReflectionIDsLoaded = "1" // should be one as long as we only care about the first most recent refletion
    var thisWeeksReflectionID = "-1"
    
    @IBOutlet var slideshow: ImageSlideshow!
    
    let localSource = [ImageSource(imageString: "csw2015Families.jpg")!, ImageSource(imageString: "GuidancePrayer.jpg")!, ImageSource(imageString: "communityprayer.jpg")!, ImageSource(imageString: "studentsprayer.jpg")!, ImageSource(imageString: "prayerforinclusion.png")!]
    //let afNetworkingSource = [AFURLSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AFURLSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AFURLSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
    //let alamofireSource = [AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, AlamofireSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
    //let sdWebImageSource = [SDWebImageSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, SDWebImageSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
    //let kingfisherSource = [KingfisherSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1447746249824-4be4e1b76d66?w=1080")!, KingfisherSource(urlString: "https://images.unsplash.com/photo-1463595373836-6e0b0a8ee322?w=1080")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.spiritualityImageView.layer.cornerRadius = 5
        //self.spiritualityImageView.clipsToBounds = true
        
        
        slideshow.backgroundColor = UIColor.white
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.underScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slideshow.pageControl.pageIndicatorTintColor = UIColor.black
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideshow.currentPageChanged = { page in
            print("current page:", page)
 
        }
 
        // try out other sources such as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        slideshow.setImageInputs(localSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slideshow.addGestureRecognizer(recognizer)
    }
    
    func didTap() {
        slideshow.presentFullScreenController(from: self)
    }
    
    func getThisWeeksSpiritualReflectionID() {
        let urlString = "https://us2.api.mailchimp.com/3.0/campaigns?folder_id=4b62ee60ea&sort_dir=DESC&count=" + self.numReflectionIDsLoaded
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
        
        print("this week's spiritual ref ID: ", id)
        
        // TODO examples of RLP newsletters with the wrong formats for this
        //let id = "a826eb9722" // weird new Remick Newsletter
        //let id = "026e83295c" // normal Remick Newsletter
        //let id = "03fc9eea48" // old Remick Newsletter (this one works)
        
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
                            print("look for Spiritual Reflection div:", json)
                            
                            let plainText = json["plain_text"] as! String?
                            self.parseJSONforSpiritualReflection(json: plainText!)

                            
                            //let refHTML = json["html"] as! String?
                            //self.weeklyRefHTML = refHTML!
                            //self.nowSegue()
                            
                            
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
        
        print("parsing JSON for spirituality ref:", json)
        
        var indexInt = 0
        var isPartOfSpiritalReflection = false
        var spiritualReflection = ""
        
        for index in json.characters.indices {

            
            if (json[index] == "S") {
                
                let start = json.index(json.startIndex, offsetBy: indexInt+1)
                let end = json.index(json.startIndex, offsetBy: indexInt+20)
                let range = start..<end

                
                if (json.substring(with: range) == "piritual Reflection") { // check if this is "Spiritual Reflection, if so we will append it to our spiritual reflection string"
                    print("FOUND SPIRITUAL REF!!!")
                    isPartOfSpiritalReflection = true
                }
            }
            else if (json[index] == "P") {
            
                let start = json.index(json.startIndex, offsetBy: indexInt+1)
                let end = json.index(json.startIndex, offsetBy: indexInt+15)
                let range = start..<end

                
                if (json.substring(with: range) == "rayer Calendar") { // check if this is a line break separator thing, we dont want the stuff after this
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
        self.view.makeToastActivity(.center)
        
        // test for network connection
        if (isInternetAvailable() == false) {
            print("NO INTERNET")
            noInternetAlert()
            self.view.hideToastActivity()
        }
        else { // only segue if there is internet
            getThisWeeksSpiritualReflectionID()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in prepare for segue...")
        
        let destinationVC = segue.destination as! SpiritualReflectionViewController
        destinationVC.weeklyRef = self.weeklyRef
        
        self.view.hideToastActivity()
    }

    // network check
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    // no internet alert
    func noInternetAlert() {
        let alert = UIAlertController(title: "No Network Connection", message: "Please connect to the internet and try again.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func spiritualityResourcesPressed(_ sender: Any) {
        if let url = URL(string: "https://ace.nd.edu/resources/spiritual-resources") {
            UIApplication.shared.open(url, options: [:])
        }

    }

  
}
