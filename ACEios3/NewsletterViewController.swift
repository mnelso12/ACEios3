//
//  NewsletterViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/11/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit
import Toast_Swift

class NewsletterViewController: UIViewController {
    
    let apikey = "3009947f4086c85e7b735f4b4222e514-us2"
    let numNewsletterIDsLoaded = "1" // should be one as long as we only care about the first most recent newsletter

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getMostRecentNewsletterID()
        self.webView.backgroundColor = UIColor(patternImage: UIImage(named:"gray-pattern.png")!)
        
        // start loading indicator
        self.view.makeToastActivity(.center)
    }
    
    func getMostRecentNewsletterID() {
        let urlString = "https://us2.api.mailchimp.com/3.0/campaigns?folder_id=4ca937c85c&sort_dir=DESC&count=" + self.numNewsletterIDsLoaded
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
                                self.loadThisNewsletter(id:id)
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

    func loadThisNewsletter(id: String) {
        
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
                        print("HERE",json)
                        
                        let htmlString = json["html"] as! String?
                        
                        self.webView.loadHTMLString(htmlString!, baseURL: nil)
                        self.view.hideToastActivity()
                        
                        //let plainText = json["plain_text"] as! String?
                        //print("newsletter plain text:",plainText)
                        //self.parseJSONforSpiritualReflection(json: plainText!)
                        
                        
                    }catch {
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
        UIApplication.shared.openURL(NSURL(string: "http://ace.us2.list-manage.com/subscribe?u=5999fc41ff424155ced84575a&id=f881afc9ef")! as URL)
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
