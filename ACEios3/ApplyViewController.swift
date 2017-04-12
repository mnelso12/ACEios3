//
//  ApplyViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 2/7/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit
import MapboxStatic

class ApplyViewController: UIViewController {

    
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var deadlineScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeStaticMap()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        mapImageView.isUserInteractionEnabled = true
        mapImageView.addGestureRecognizer(tapGestureRecognizer)

    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("map tapped")
        self.performSegue(withIdentifier: "toMapVC", sender: self)
    }

    func makeStaticMap() {
        let options = SnapshotOptions(
            mapIdentifiers: ["bstalcup.029b5e12"],
            centerCoordinate: CLLocationCoordinate2D(latitude: 37.09, longitude: -95.71),
            zoomLevel: 3,
            size: self.mapImageView.bounds.size)
        let snapshot = Snapshot(
            options: options,
            accessToken: "pk.eyJ1IjoiYnN0YWxjdXAiLCJhIjoiU1VNWC1vayJ9.dKT17UcqoGPkcyfBTIEQUA")
        
        mapImageView.image = snapshot.image

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyNowPressed(_ sender: Any) {
        if let url = URL(string: "https://ace.nd.edu/teach/prospective-applicants/how-to-apply") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }

    }

}
