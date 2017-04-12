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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.webView.loadHTMLString(self.htmlString, baseURL: nil)
        self.webView.backgroundColor = UIColor(patternImage: UIImage(named:"gray-pattern.png")!)
        
        
        print("view width:", self.view.frame.width)
        
        
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func positionImageView() {
        // set image width to screen width
        //let screenSize: CGRect = UIScreen.main.bounds
        //self.imageView.frame = CGRect(x: 0, y: -50, width: screenSize.width, height: 200)
    }
    
    func positionLabels() {
        //let screenSize: CGRect = UIScreen.main.bounds
        //self.blogTitle.frame = CGRect(x: 20, y: 180, width: screenSize.width - 40, height: 80)
    }


    func setImage(urlStr: String) {
        /*
        if (urlStr == "" || urlStr == " ") {
            //imageView.image = UIImage(named: "ace_logo_color_PNG.png")
        }
        else {
            //let url = URL(string: urlStr)
        
            //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            //if let data = try? Data(contentsOf: url!){
                //imageView.image = UIImage(data: data)
            //}
        }
 */
        
    }
    
    func parseBlogHTML(html: String) -> String {
        
        return html
    }


}

