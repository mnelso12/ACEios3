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
    
    var blogTitles = [String]() // array of blog titles that fill thel table view
    var detailsArr = [String]() // array of detail labels (gray text below the title of the table view cell)
    var blogIdArr = [String]() // this is used to ask jBackend for the blog content
    
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
        cell.detailLabel.text = self.detailsArr[indexPath.row]
        
        return cell
        
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        performSegue(withIdentifier: "pressedCell", sender: nil)

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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

                            let blogDetails = month + "-" + day + "-" + year
                            
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
    
    
    // other stuff //////////////////////////////////////////////////////////////
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! SecondViewController
        destinationVC.blogTitleString = "heyyy from segueeee"
        
        print("PREPARING FOR SEGUE")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

