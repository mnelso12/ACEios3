//
//  FirstViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 1/20/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit
import Font_Awesome_Swift // for icons
import Toast_Swift // for activity view(s), aka the spinning loading symbol that pops up
import Foundation // for network check
import SystemConfiguration // for network check

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var blogNews: UISegmentedControl! // segmented control
    
    var htmlString = " " // html string that is sent to the blog/news view controller called SecondViewController.swift
    
    var isBlog = true // whether or not table view is blog (vs. is news)

    // blog data arrays
    var blogTitles = [String]() // array of blog titles that fill the table view
    var detailsArr = [String]() // array of detail labels (gray text below the title of the table view cell)
    var datesArr = [String]() // array of only the blog dates
    var blogIdArr = [String]() // this is used to ask jBackend for the blog content
    
    // news data arrays
    var newsTitles = [String]() // array of news titles that fill thel table view
    var newsDetailsArr = [String]() // array of news detail labels (gray text below the title of the table view cell)
    var newsDatesArr = [String]() // array of only the news article dates
    var newsIdArr = [String]() // this is used to ask jBackend for the news content
    var blogIsReady = false
    var newsIsReady = false

    
    var selectedBlogTitle:String!
    var selectedBlogContent:String!
    var selectedBlogDate:String!
    var selectedBlogAuthor:String!
    var selectedImgUrl:String!
    
    let cellReuseIdentifier = "blogCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test for network connection
        if (isInternetAvailable() == false) {
            print("NO INTERNET")
            noInternetAlert()
        }
        
        blogNews.isEnabled = false // enabled when blogs and news are loaded
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // start loading indicator while blogs and news are loading
        self.view.makeToastActivity(.center)
        
        // load blogs into table view
        getMostRecentBlogs()
        getMostRecentNews()
        
        setTabBarIcons()
        
        let tempImageView = UIImageView(image: UIImage(named: "bluePattern.png"))
        tempImageView.frame = self.tableView.frame
        self.tableView.backgroundView = tempImageView;
        self.tableView.tableFooterView = UIView() // this gets rid of the annoying cell separator lines that appear in the table view before the cells are populated with data

    }
    
    // pressed "okay" in no internet alert view
    func pressedOkay() {
        while(true) {
            print("waiting for internet...")
            if (isInternetAvailable() == true) {
                print("GOT INTERNET!")
                
                // load blogs into table view
                getMostRecentBlogs()
                getMostRecentNews()
                
                break
            }
        }
    }
    
    func setTabBarIcons() {
        tabBarController?.tabBar.items?.first?.setFAIcon(icon: .FAHome)
        tabBarController?.tabBar.items?[1].setFAIcon(icon: .FAHeart)
        tabBarController?.tabBar.items?[2].setFAIcon(icon: .FANewspaperO)
        tabBarController?.tabBar.items?[3].setFAIcon(icon: .FAGlobe)
        tabBarController?.tabBar.items?[4].setFAIcon(icon: .FAUsers)

    }
    
    // segmented control (blog/news)
    @IBAction func pressedSegmentedControl(_ sender: Any) {
        
        if (self.blogIsReady == false && blogNews.selectedSegmentIndex == 0) {
            return // blogs not loaded yet
        }
        else if (self.newsIsReady == false && blogNews.selectedSegmentIndex == 1) {
            return // news not loaded yet
        }
        
        if blogNews.selectedSegmentIndex == 0
        {
            print("is blog")
            self.isBlog = true
            
        }
        else {
            print("is news")
            self.isBlog = false
        }
        tableView.reloadData()
    }
    
    func makeDatePretty(oldDate: String) -> String {
        // make "12-1-2016" into "Dec 1, 2016"
        
        var newDate = ""
        var dateArr = oldDate.characters.split(whereSeparator: { $0 == "-" })
            .map(String.init)
        
        let monArr = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        let monthNum = Int(dateArr[0])!
        
        newDate.append(monArr[monthNum-1])
        newDate.append(" ")
        newDate.append(dateArr[1])
        newDate.append(", ")
        newDate.append(dateArr[2])
        
        return newDate
    }
    
    
    // table view //////////////////////////////////////////////////////
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogTitles.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! BlogTableViewCell
        
        if (self.isBlog == true) {
            cell.blogTitle.text = self.blogTitles[indexPath.row]
            cell.detailLabel.text = makeDatePretty(oldDate: self.detailsArr[indexPath.row])
        }
        else {
            cell.blogTitle.text = self.newsTitles[indexPath.row]
            cell.detailLabel.text = makeDatePretty(oldDate: self.newsDetailsArr[indexPath.row])
        }
        
        return cell
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        if (self.isBlog) {
            getBlog(blogID: self.blogIdArr[indexPath.row])
            self.selectedBlogDate = self.datesArr[indexPath.row]
        }
        else {
            getNews(newsID: self.newsIdArr[indexPath.row])
            self.selectedBlogDate = self.newsDatesArr[indexPath.row]
        }
        
        // start loading indicator
        self.view.makeToastActivity(.center)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    // parse the html stuff to get rid of tags and to find the img url source
    func parseBlogHTML(html: String) -> String {
        var returnStr = " "
        var isWidgetkit = false
        var indexInt = 0

         for index in html.characters.indices {
            if (html[index] == "[") { // could be start of "[widgetkit id=...]"
                let start = html.index(html.startIndex, offsetBy: indexInt+1)
                let end = html.index(html.startIndex, offsetBy: indexInt+10)
                let range = start..<end
                if (html.substring(with: range) == "widgetkit") { // check if this is "widgetkit"
                    isWidgetkit = true
                }
            }
            else if ((html[index] == "]") && (isWidgetkit == true)) { // end of "[widgetkit id=...]"
                isWidgetkit = false
            }
            else if (isWidgetkit == false) { // just normal html
                returnStr.append(html[index])
            }
            indexInt += 1
         }
        return returnStr
    }


    
    // news content //////////////////////////////////////////////////////
    
    func getMostRecentNews() {
        let url = URL(string: "http://devace2.cloudaccess.net/index.php/endpoint?action=get&module=zoo&app=4&resource=items&category=asdf&limit=10")
        
        
        
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            
            DispatchQueue.main.async(){
                
                guard let data = data, error == nil else { return }
                
                
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                if (statusCode == 200) {
                    print("Everyone is fine, file downloaded successfully.")
                    do{
                        
                        let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
                        
                        // json content
                        let elements = json["items"] as! [AnyObject]
                        
                        for element in elements {
                            // remember this blog ID
                            let blogID = element["id"] as! String
                            self.newsIdArr.append(blogID)
                            
                            // remember this blog name
                            let blogName = element["name"] as! String
                            self.newsTitles.append(blogName)
                            
                            // remember this blog date
                            let creationTime = element["created"] as! String
                            let creationDate = creationTime.components(separatedBy: " ")
                            let creationDateArr = creationDate[0].components(separatedBy: "-")
                            let month = creationDateArr[1]
                            let day = creationDateArr[2]
                            let year = creationDateArr[0]
                            
                            let blogDate = month + "-" + day + "-" + year
                            
                            let blogDetails = blogDate // change this?
                            
                            self.newsDatesArr.append(blogDate)
                            self.newsDetailsArr.append(blogDetails)
                            
                        }
                        
                        self.tableView.reloadData() // update table view with blog data
                        self.newsIsReady = true
                        self.blogNews.isEnabled = true // now enable blog/news switch because theres content in both
                        self.view.hideToastActivity()
                        
                    }catch {
                        print("Error with Json: \(error)")
                    }
                    
                }
                
            }
        }
        task.resume()
    }
    
    
    // get all info from a particular news article given its id - this function is called when news cell is selected
    func getNews(newsID: String) {
        let urlString = "http://devace2.cloudaccess.net/index.php/endpoint?action=get&module=zoo&resource=items&app=8&id=" + newsID
        let url = URL(string: urlString)
        
        
        
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            
            DispatchQueue.main.async(){
                
                guard let data = data, error == nil else { return }
                
                
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                if (statusCode == 200) {
                    print("Everyone is fine, file downloaded successfully.")
                    do{
                        
                        let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
                        
                        // title and author
                        self.selectedBlogTitle = json["name"] as! String?
                        
                        // blog content
                        var blogContent:String! = ""
                        
                        let elements = json["elements"] as! [String:Any]
                        var i=0
                        
                        for element in elements {
                            
                            if (i==4) {
                                let val = element.value as! [String:Any]
                                var j = 0
                                for thing in val {
                                    if (j==1) {
                                        print(thing.1)
                                        let data = thing.1 as! [Any]
                                        
                                        for blob in data {
                                            let entry = blob as! [String:Any]
                                            let authorString = entry["value"] as! String
                                            self.selectedBlogAuthor = authorString
                                        }
                                    }
                                    j += 1
                                }
                                
                            }
                            
                            if (i==11) {
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
                        
                        let blogContentWithStyle = "<style>img{max-width: 97%; height: auto; text-align: center; margin: 30px; box-shadow: 1px 1px 1px 0px #202020}body {font-family:'GalaxiePolaris-Medium'; padding: 10px;} #stuff{text-align:center;} h1 {font-family:'GaramondPremrPro'; color: #000066;} h4 {font-family:'GalaxiePolaris-Medium'; color:gray; text-align: left;} iframe {width:100%;}</style><h1><div id='stuff'>" + self.selectedBlogTitle + "</h1>" + (blogContent as String) + "</div>"
                        
                        self.htmlString = self.parseBlogHTML(html:blogContentWithStyle) // gets rid of widgetkit tags
                        
                    } catch {
                        print("Error with Json: \(error)")
                    }
                }
                print("ending dispatch queue")
                self.nowSegue()
            }
        }
        task.resume()
    }

    
    
    
    // blog content //////////////////////////////////////////////////////
 
    func getMostRecentBlogs() {
        
        
        let url = URL(string: "http://devace2.cloudaccess.net/index.php/endpoint?action=get&module=zoo&app=8&resource=items&category=blog&limit=10")
        
        
        
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            
            DispatchQueue.main.async(){
                
                guard let data = data, error == nil else { return }
                
                
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                if (statusCode == 200) {
                    print("Everyone is fine, file downloaded successfully.")
                    do{
                        
                        let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
                        
                        print("printing all blog info")
                        print(json)
                        
                        // json content
                        
                        let elements = json["items"] as! [AnyObject]
                        
                        for element in elements {
                            // remember this blog ID
                            let blogID = element["id"] as! String
                            self.blogIdArr.append(blogID)
                            
                            // remember this blog name
                            let blogName = element["name"] as! String
                            self.blogTitles.append(blogName)
                    
                            // remember this blog date
                            let creationTime = element["created"] as! String
                            let creationDate = creationTime.components(separatedBy: " ")
                            let creationDateArr = creationDate[0].components(separatedBy: "-")
                            let month = creationDateArr[1]
                            let day = creationDateArr[2]
                            let year = creationDateArr[0]

                            let blogDate = month + "-" + day + "-" + year
                            
                            let blogDetails = blogDate // change this?
                            
                            self.datesArr.append(blogDate)
                            self.detailsArr.append(blogDetails)
                            
                        }
                        
                        self.tableView.reloadData() // update table view with blog data
                        self.blogIsReady = true
                        
                        
                    }catch {
                        print("Error with Json: \(error)")
                    }

                }
                
            }
        }
        task.resume()
    }
    
    
    // get all info from a particular blog given its id - this function is called when blog cell is selected
    func getBlog(blogID: String) {
        let urlString = "http://devace2.cloudaccess.net/index.php/endpoint?action=get&module=zoo&resource=items&app=8&id=" + blogID
        let url = URL(string: urlString)
        
        
        
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            
            DispatchQueue.main.async(){
                
                guard let data = data, error == nil else { return }
                
                
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                if (statusCode == 200) {
                    print("Everyone is fine, file downloaded successfully.")
                    do{
                        
                        let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:Any]
                        
                        print("\n\n\nprinting the info of the blog selected\n")
                        print(json)
                        
                        // title and author
                        self.selectedBlogTitle = json["name"] as! String?
                        
                        // blog content
                        var blogContent:String! = ""
                        
                        let elements = json["elements"] as! [String:Any]
                        var i=0
                        
                        for element in elements {
                            
                            if (i==4) {
                                let val = element.value as! [String:Any]
                                var j = 0
                                for thing in val {
                                    if (j==1) {
                                        print(thing.1)
                                        let data = thing.1 as! [Any]
                                        
                                        for blob in data {
                                            let entry = blob as! [String:Any]
                                            let authorString = entry["value"] as! String
                                            self.selectedBlogAuthor = authorString
                                        }
                                    }
                                    j += 1
                                }
                            }

                            
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
                        
                        
                        let blogContentWithStyle = "<style>img{max-width: 97%; height: auto; text-align: center; margin: 30px; box-shadow: 1px 1px 1px 0px #202020}body {font-family:'GalaxiePolaris-Medium'; padding: 10px;} #stuff{text-align:center;} h1 {font-family:'GaramondPremrPro'; color: #000066;} h4 {font-family:'GalaxiePolaris-Medium'; color:gray; text-align: left;} iframe {width:100%;}</style><h1><div id='stuff'>" + self.selectedBlogTitle + "</h1><h4>" + self.selectedBlogAuthor + "</h4>" + (blogContent as String) + "</div>"
                        
                        self.htmlString = self.parseBlogHTML(html:blogContentWithStyle) // gets rid of widgetkit tags
                        
                    } catch {
                        print("Error with Json: \(error)")
                    }
                }
                print("ending dispatch queue")
                self.nowSegue()
            }
        }
        task.resume()
    }

    
    func nowSegue() {
        performSegue(withIdentifier: "pressedCell", sender: self)
    }
    
    // other stuff //////////////////////////////////////////////////////////////
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in prepare for segue...")

        let destinationVC = segue.destination as! SecondViewController
        destinationVC.htmlString = self.htmlString

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
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { action in self.pressedOkay() }))
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

