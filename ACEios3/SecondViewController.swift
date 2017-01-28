//
//  SecondViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 1/20/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController, UITextViewDelegate {
    
    var blogTitleString:String! = "Blog Title"
    var blogContentString:String! = "Blog Content"
    var blogDateString:String! = "1-1-17"
    var blogAuthorString:String! = "Author"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var blogTitle: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var blogTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.blogTextView.delegate = self
        
        // update ui elements with strings passed from home view controller
        self.blogTitle.text = self.blogTitleString
        self.blogTextView.text = self.blogContentString
        self.dateLabel.text = self.blogDateString
        self.authorLabel.text = self.blogAuthorString
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func parseBlogHTML(html: String) -> String {
        /*
        let middle = html.index(html.startIndex, offsetBy: html.characters.count / 2)
        
        for index in html.characters.indices {
            
            // to traverse to half the length of string
            if index == middle { break }  // s, t, r
            
            print(html[index])  // s, t, r, i, n, g
            
            if (html[index] == "<") {
                
            }
        }
        */
        
        return html
    }
    
    func getBlog() {
        let url = URL(string: "http://devace2.cloudaccess.net/index.php/endpoint?action=get&module=zoo&resource=items&app=8&id=7512")
        

        
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            
            DispatchQueue.main.async(){
            
            guard let data = data, error == nil else { return }
            
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
                    
                    print(json)
                    
                    // title and author
                    //self.blogTitle.text = json["name"] as! String?
                    //self.authorLabel.text = "author here"
                    
                    
                    // blog content
                    var blogContent:String! = ""
                    
                    let elements = json["elements"] as! [String:Any]
                    var i=0
                    for element in elements {
                        if (i==7) {
                            let val = element.value as! [String:Any]
                            let blogArr = val["data"] as! [Any]
                            for paragraph in blogArr {
                                let para = paragraph as! [String:Any]
                                let paragraphVal = para["value"]
                                blogContent = blogContent + "\n\n" + (paragraphVal as! String)
                            }
                        }
                        
                        
                        i+=1
                    }
                    
                    
                    let parsedHTML = self.parseBlogHTML(html: blogContent)
                    
                    //self.blogTextView.text = parsedHTML
                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
            
            }
        }
        task.resume()
    
        
    }

}

