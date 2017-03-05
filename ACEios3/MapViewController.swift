//
//  MapViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 3/5/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit
import Mapbox
import MapboxGeocoder

class MapViewController: UIViewController, MGLMapViewDelegate {

    @IBOutlet weak var mapView: MGLMapView!
    let geocoder = Geocoder.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.navigationController?.navigationBar.tintColor = UIColor(red: 0.01, green: 0.16, blue: 0.40, alpha: 1.0)
        
        mapView.delegate = self
        
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 45.52258, longitude: -122.6732)
        point.title = "Voodoo Doughnut"
        point.subtitle = "22 SW 3rd Avenue Portland Oregon, U.S.A."
        mapView.addAnnotation(point)
    
    }

    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always try to show a callout when an annotation is tapped.
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
