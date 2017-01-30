//
//  FirstViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 1/20/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var blogNews: UISegmentedControl! // segmented control
    
    var isBlog = true // whether or not table view is blog (vs. is news)

    // blog data arrays
    var blogTitles = [String]() // array of blog titles that fill thel table view
    var detailsArr = [String]() // array of detail labels (gray text below the title of the table view cell)
    var datesArr = [String]() // array of only the blog dates
    var blogIdArr = [String]() // this is used to ask jBackend for the blog content
    
    // news data arrays
    var newsTitles = [String]() // array of news titles that fill thel table view
    var newsDetailsArr = [String]() // array of news detail labels (gray text below the title of the table view cell)
    var newsDatesArr = [String]() // array of only the news article dates
    var newsIdArr = [String]() // this is used to ask jBackend for the news content

    
    var selectedBlogTitle:String!
    var selectedBlogContent:String!
    var selectedBlogDate:String!
    var selectedBlogAuthor:String!
    
    let cellReuseIdentifier = "blogCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // load blogs into table view
        getMostRecentBlogs()
        getMostRecentNews()
    }
    
    // segmented control (blog/news)
    @IBAction func pressedSegmentedControl(_ sender: Any) {
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
            cell.detailLabel.text = self.detailsArr[indexPath.row]
        }
        else {
            cell.blogTitle.text = self.newsTitles[indexPath.row]
            cell.detailLabel.text = self.newsDetailsArr[indexPath.row]
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

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
                        
                        print("printing all news info")
                        print(json)
                        
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
                        
                        print("\n\n\nprinting the info of the news article selected\n")
                        print(json)
                        
                        // title and author
                        self.selectedBlogTitle = json["name"] as! String?
                        //self.selectedBlogAuthor = "madelyn"
                        
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
                                
                                //let data = val["data"] as! [Any]
                                print("AUTHOR:")
                                print(data)
                                
                            }
                            
                            print("element number %i", i)
                            print(element)
                            
                            /*
                            if (i==7) {
                                let val = element.value as! [String:Any]
                                let blogArr = val["data"] as! [Any]
                                for paragraph in blogArr {
                                    let para = paragraph as! [String:Any]
                                    let paragraphVal = para["value"]
                                    blogContent = blogContent + "\n\n" + (paragraphVal as! String)
                                }
                            }
 */
                            
                            
                            i+=1
                        }
                        blogContent = "blahh"
                        
                        self.selectedBlogContent = blogContent
                        
                        //let parsedHTML = self.parseBlogHTML(html: blogContent)
                        
                        //self.blogTextView.text = parsedHTML
                        
                    }catch {
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
                        //self.selectedBlogAuthor = "madelyn"
                        
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
                                
                                //let data = val["data"] as! [Any]
                                print("AUTHOR:")
                                print(data)

                            }
                            
                            print("element number %i", i)
                            print(element)
                            
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
                        
                        self.selectedBlogContent = blogContent
                        
                        //let parsedHTML = self.parseBlogHTML(html: blogContent)
                        
                        //self.blogTextView.text = parsedHTML
                        
                    }catch {
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
        destinationVC.blogTitleString = self.selectedBlogTitle
        destinationVC.blogContentString = self.selectedBlogContent
        destinationVC.blogDateString = self.selectedBlogDate
        destinationVC.blogAuthorString = self.selectedBlogAuthor
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

