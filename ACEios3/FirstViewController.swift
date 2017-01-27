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
    
    var blogTitles = [String]()
    
    let cellReuseIdentifier = "blogCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // load blogs into table view
        getMostRecentBlogs()

    }
    
    
    
    
    // table view //////////////////////////////////////////////////////
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogTitles.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! BlogTableViewCell
        
        cell.blogTitle.text = self.blogTitles[indexPath.row]
        
        return cell
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
    
    
    // blog content //////////////////////////////////////////////////////
    
    func parseBlogHTML(html: String) -> String {
        return html
    }

    
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
                        
                        
                        // json content
                        var blogContent:String! = ""
                        
                        let elements = json["items"] as! [AnyObject]
                        var i=0
                        
                        for element in elements {
                            print("\n\n")
                            print(element)
                            
                            let blogName = element["name"] as! String
                            self.blogTitles.append(blogName)
                            print(self.blogTitles)
                            
                            
                                /*
                                let val = element.value as! [String:Any]
                                let blogArr = val["data"] as! [Any]
                                for paragraph in blogArr {
                                    let para = paragraph as! [String:Any]
                                    let paragraphVal = para["value"]
                                    blogContent = blogContent + "\n\n" + (paragraphVal as! String)
                                }
 */
                            
                            
                            i+=1
                        }
                        
                        
                        let parsedHTML = self.parseBlogHTML(html: blogContent)
                        
                        print(parsedHTML)
                        //self.blogTextView.text = parsedHTML
                        
                        
                    }catch {
                        print("Error with Json: \(error)")
                    }
                }
                
            }
        }
        task.resume()
        self.tableView.reloadData() // update table view with blog data
        
        
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

