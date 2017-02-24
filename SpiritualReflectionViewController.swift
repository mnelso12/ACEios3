//
//  SpiritualReflectionViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/15/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class SpiritualReflectionViewController: UIViewController {

    var weeklyRef:String! = ""
    
    //@IBOutlet weak var textView: UITextView!
    
    var textView: UITextView!
    //var reflectionText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundImage(imageNamed: "basilica.jpg")
        setTextViewFrame()
    }
    
    func setTextViewFrame() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width;
        let screenHeight = screenSize.height;
        
        let bottomBarHeight = self.tabBarController?.tabBar.frame.size.height
        let topBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        let textView : UITextView = UITextView(frame : CGRect(x:20, y: 20+topBarHeight!, width:        (screenWidth-40), height: (screenHeight-40-bottomBarHeight!-topBarHeight!) ))
        
        textView.text = self.weeklyRef
        textView.font = UIFont(name: "GalaxiePolaris-Medium", size: 15)
        textView.layer.cornerRadius = 5
        textView.layer.opacity = 0.85
        
        self.view.addSubview( textView )
    }
    
    func setBackgroundImage(imageNamed:String) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "basilica.jpg")?.draw(in: self.view.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: image)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
