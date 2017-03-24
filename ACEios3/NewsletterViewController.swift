//
//  NewsletterViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/11/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit
import Toast_Swift
import Foundation // for network check
import SystemConfiguration // for network check

class NewsletterViewController: UIViewController {
    
    let apikey = "3009947f4086c85e7b735f4b4222e514-us2"
    let numNewsletterIDsLoaded = "1" // should be 1 as long as we only care about the first most recent newsletter

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test for network connection
        if (isInternetAvailable() == false) {
            print("NO INTERNET")
            noInternetAlert()
        }
        else {
            // start loading indicator
            self.view.makeToastActivity(.center)
        }

        // Do any additional setup after loading the view.
        self.getMostRecentNewsletterID()
        self.webView.backgroundColor = UIColor(patternImage: UIImage(named:"gray-pattern.png")!)

    }
    
    // pressed "okay" in no internet alert view
    func pressedOkay() {
        while(true) {
            print("waiting for internet...")
            if (isInternetAvailable() == true) {
                print("GOT INTERNET!")
                self.getMostRecentNewsletterID()
                self.view.makeToastActivity(.center) // keep the loading sign until the newsletter appears on the screen
                break
            }
        }
    }
    
    func getMostRecentNewsletterID() {
        let urlString = "https://us2.api.mailchimp.com/3.0/campaigns?folder_id=4ca937c85c&sort_dir=DESC&count=" + self.numNewsletterIDsLoaded
        let url = URL(string: urlString)
        let param = "apikey " + self.apikey
        let request = NSMutableURLRequest(url: url!)
        var id = "" // this week's id, will be returned at end
        
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
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
                        print(json)
                        
                        var objIndex = 0
                        for obj in json {
                            
                            if (objIndex == 1) {
                                print(obj.value)
                                let array = (obj.value as! NSArray).mutableCopy() as! NSMutableArray
                                let thing = array[0] as! [String:AnyObject]
                                id = thing["id"] as! String
                                self.loadThisNewsletter(id:id)
                            }
                            objIndex += 1
                        }
                        
                        
                    } catch {
                        print("Error IN SPIRITUALITY with Json: \(error)")
                    }
                }
                print("ending dispatch queue IN SPIRITUALITY")
                // now segue!
            }
        }
        task.resume()
    }

    func loadThisNewsletter(id: String) {
        print("attempting to load newsletter")
        
        
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
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
                        print("HERE",json)
                        
                        let htmlString = json["html"] as! String?
                        
                        self.webView.loadHTMLString(htmlString!, baseURL: nil)
                        self.view.hideToastActivity()

                    } catch {
                        print("Error with Json: \(error)")
                    }
                }
                print("ending dispatch queue ")
            }
        }
        task.resume()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpForNewsletter(_ sender: Any) {
        if let url = URL(string: "http://ace.us2.list-manage.com/subscribe?u=5999fc41ff424155ced84575a&id=f881afc9ef") {
            UIApplication.shared.open(url, options: [:])
        }
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
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { action in self.pressedOkay() }))
        self.present(alert, animated: true, completion: nil)
    }


}
