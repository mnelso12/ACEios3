//
//  SecondViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 1/20/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    
    var htmlString: String!
    
    @IBOutlet weak var webView: UIWebView!
    
    //var blogTitleString:String! = "Blog Title"
    //var blogContentString:String! = "Blog Content"
    //var blogDateString:String! = "1-1-17"
    //var blogAuthorString:String! = "Author"
    //var imgUrlString:String! = "blahhh"
    
    //@IBOutlet weak var scrollView: UIScrollView!
    
    //@IBOutlet weak var imageView: UIImageView!
    //@IBOutlet weak var blogTitle: UILabel!
    //@IBOutlet weak var authorLabel: UILabel!
    //@IBOutlet weak var dateLabel: UILabel!
    //@IBOutlet weak var blogTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.webView.loadHTMLString(self.htmlString, baseURL: nil)
        self.webView.backgroundColor = UIColor(patternImage: UIImage(named:"gray-pattern.png")!)
        
        
        //self.blogTextView.delegate = self
        //self.scrollView.delegate = self
        //self.blogTextView.textContainerInset = UIEdgeInsetsMake(0, 15, 15, 65);
        
        //self.blogTextView.backgroundColor = UIColor.red
        //self.scrollView.backgroundColor = UIColor.yellow
        
        //self.blogTextView.textContainerInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        // 5s: 320, 65
        // 6s: 375, 15
        // 7: 375, 15
        // 6 plus: 414, none
        
        
        print("view width:", self.view.frame.width)
        
        //self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+self.blogTextView.frame.height)
        
        // update ui elements with strings passed from home view controller
        /*
        self.blogTitle.text = self.blogTitleString
        self.blogTextView.text = self.blogContentString
        self.dateLabel.text = self.blogDateString
        self.authorLabel.text = self.blogAuthorString
        
        self.blogTitle.font = UIFont(name: "GaramondPremrPro", size: 30)
        self.dateLabel.font = UIFont(name: "GalaxiePolaris-Medium", size: 15)
        self.authorLabel.font = UIFont(name: "GalaxiePolaris-Medium", size: 15)
        self.blogTextView.font = UIFont(name: "GalaxiePolaris-Medium", size: 15)
        
        
        setImage(urlStr: self.imgUrlString)
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.01, green: 0.16, blue: 0.40, alpha: 1.0)
        */
    }
    
    // disables horizontal scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
        else if scrollView.contentOffset.x<0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    // need this for textView to work with the scrollView
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        self.positionImageView()
        self.positionLabels()
        
        //let contentSize = self.blogTextView.sizeThatFits(self.self.blogTextView.bounds.size)
        //var frame = self.blogTextView.frame
        //frame.size.height = contentSize.height
        
        //frame.size.width = self.scrollView.frame.width-20 // added this
        
        //self.blogTextView.frame = frame
        
        //let aspectRatioTextViewConstraint = NSLayoutConstraint(item: self.blogTextView, attribute: .height, relatedBy: .equal, toItem: self.blogTextView, attribute: .width, multiplier: self.blogTextView.bounds.height/blogTextView.bounds.width, constant: 1)
        //self.blogTextView.addConstraint(aspectRatioTextViewConstraint)
        
        // sets scrollView height to fit textView and stuff. Math could be better here TODO
        //self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+self.blogTextView.frame.height)
        //self.scrollView.contentSize = CGSize(width: self.view.frame.width, height:self.blogTextView.frame.height + 200)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func positionImageView() {
        // set image width to screen width
        let screenSize: CGRect = UIScreen.main.bounds
        //self.imageView.frame = CGRect(x: 0, y: -50, width: screenSize.width, height: 200)
    }
    
    func positionLabels() {
        let screenSize: CGRect = UIScreen.main.bounds
        //self.blogTitle.frame = CGRect(x: 20, y: 180, width: screenSize.width - 40, height: 80)
    }


    func setImage(urlStr: String) {
        if (urlStr == "" || urlStr == " ") {
            //imageView.image = UIImage(named: "ace_logo_color_PNG.png")
        }
        else {
            let url = URL(string: urlStr)
        
            //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            if let data = try? Data(contentsOf: url!){
                //imageView.image = UIImage(data: data)
            }
        }
        
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
    
    
    
    /*
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
                    //self.blogContent.text = parsedHTML
                    
                }catch {
                    print("Error with Json: \(error)")
                }
            }
            
            }
        }
        task.resume()
    
        
    }
 */

}

