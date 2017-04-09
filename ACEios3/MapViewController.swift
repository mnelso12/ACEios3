//
//  MapViewController.swift
//  ACEios3
//
//  Created by Madelyn Nelson on 3/5/17.
//  Copyright © 2017 Madelyn Nelson. All rights reserved.
//

import UIKit
import Mapbox
import MapboxStatic

// MGLPointFeature subclass
class MyCustomPointAnnotation: MGLPointAnnotation {
    var isTF: Bool = false
    var isRLP: Bool = false
    var isENL: Bool = false
    var isNDAA: Bool = false
}

class MapViewController: UIViewController, MGLMapViewDelegate {

    @IBOutlet weak var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.01, green: 0.16, blue: 0.40, alpha: 1.0)
        
        mapView.delegate = self
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: 37.09,
                                                 longitude: -95.71),
                          zoomLevel: 2, animated: false)
        
        //mapView = MGLMapView(frame: view.bounds)
        //mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        /*
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 45.52258, longitude: -122.6732)
        point.title = "Voodoo Doughnut"
        point.subtitle = "22 SW 3rd Avenue Portland Oregon, U.S.A."
        mapView.addAnnotation(point)
        */
        
        drawPolyline()
    }
    
    
    func drawPolyline() {
        // Parsing GeoJSON can be CPU intensive, do it on a background thread
        
        DispatchQueue.global(qos: .background).async(execute: {
            
            let jsonPath = Bundle.main.path(forResource: "whereweserve", ofType: "json")
            let url = URL(fileURLWithPath: jsonPath!)
            
            do {
                // Convert the file contents to a shape collection feature object
                let data = try Data(contentsOf: url)
                let shapeCollectionFeature = try MGLShape(data: data, encoding: String.Encoding.utf8.rawValue) as! MGLShapeCollectionFeature
                print("shape collection feature geoJson dictionary", shapeCollectionFeature.geoJSONDictionary())
                
                var i = 0
                let numPoints = shapeCollectionFeature.shapes.count
                
                while i < numPoints {
                    
                    if let polyline = shapeCollectionFeature.shapes[i] as? MGLPointFeature {
                        // Optionally set the title of the polyline, which can be used for:
                        //  - Callout view
                        //  - Object identification
                        
                        

                        
                        // "programs" = [#TF programs, #Remick Leaders, #ENL teachers, # Notre Dame ACE Academies]
                        let programs = polyline.attributes["programs"] as! [Int]
                        //print("#TF:", programs[0], "#Remick leaders:", programs[1], "#ENL teachers", programs[2], "#NDAA", programs[3])
                        var caption:String!

                        // for the number of initiatives displayed in subtitles. I doubt this will ever go above 20 for one location, but feel free to add more if we need to
                        let numberStrings = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen", "twenty"]
                        
                        // count number of initiatives served in this location
                        var numInitiativesServed:Int! = 0
                        for p in programs {
                            if (p > 0) {
                                numInitiativesServed = numInitiativesServed + 1
                            }
                        }
                        
                                                // make caption string
                        let city = polyline.attributes["city"] as! String
                        if (numInitiativesServed > 1) {
                            caption = "ACE has " + numberStrings[numInitiativesServed] + " initiatives serving Catholic schools in " + city
                        }
                        else if (programs[0] >= 1) { // only TF
                            if (programs[0] == 1) { // singular
                                caption = "ACE has " + numberStrings[programs[0]] + " Teaching Fellows community serving Catholic schools in " + city
                            }
                            else {
                                caption = "ACE has " + numberStrings[programs[0]] + " Teaching Fellows communities serving Catholic schools in " + city
                            }
                        }
                        else if (programs[1] >= 1) { // only RLP
                            if (programs[1] == 1) { // singular
                                caption = "ACE has " + numberStrings[programs[1]] + " Remick leader serving Catholic schools in " + city
                            }
                            else { // plural
                                caption = "ACE has " + numberStrings[programs[1]] + " Remick leaders serving Catholic schools in " + city
                            }
                        }
                        else if (programs[2] >= 1) { // only ENL
                            if (programs[2] == 1) { // singular
                                caption = "ACE has " + numberStrings[programs[2]] + " ENL Teacher serving Catholic schools in " + city
                            }
                            else { // plural
                                caption = "ACE has " + numberStrings[programs[2]] + " ENL Teachers serving Catholic schools in " + city
                            }
                                                    }
                        else if (programs[3] >= 1) { // only NDAA
                            if (programs[3] == 1) { // singular
                                caption = "ACE has " + numberStrings[programs[3]] + " Notre Dame ACE Academy located in " + city
                            }
                            else { // plural
                                caption = "ACE has " + numberStrings[programs[3]] + " Notre Dame ACE Academies located in " + city
                            }
                        }
                        else {
                            caption = "Oops!"
                            print("ERROR! Found a marker with no TF, RLP, ENL, or NDAA. Could not write a caption for it.")
                        }

                        
                        var thisAnnotation = MyCustomPointAnnotation()
                        thisAnnotation.coordinate = polyline.coordinate
                        
                        //thisAnnotation.coordinate = CLLocationCoordinate2D(latitude: 43.72305, longitude: 10.396633)
                        
                        // figure out which flag icon to use
                        if (programs[0] > 0) { // TF
                            //polyline.isTF = true
                            thisAnnotation.isTF = true
                        }
                        if (programs[1] > 0) { // RLP
                            //polyline.isRLP = true
                            thisAnnotation.isRLP = true
                        }
                        if (programs[2] > 0) { // ENL
                            //polyline.isENL = true
                            thisAnnotation.isENL = true
                        }
                        if (programs[3] > 0) { // NDAA
                            //polyline.isNDAA = true
                            thisAnnotation.isNDAA = true
                        }
                        
                        
                        thisAnnotation.title = polyline.attributes["title"] as? String
                        thisAnnotation.subtitle = caption
                        
                        polyline.title = polyline.attributes["title"] as? String
                        polyline.subtitle = caption
                    
                        // Add the annotation on the main thread
                        DispatchQueue.main.async(execute: {
                            // Unowned reference to self to prevent retain cycle
                            [unowned self] in
                            //self.mapView.addAnnotation(polyline)
                            self.mapView.addAnnotation(thisAnnotation)
                        })
                    }
                    i += 1
                }
            }
            catch {
                print("GeoJSON parsing failed")
            }
            
        })
        
    }

    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        
        print("in image func")
        var annotationImage = MGLAnnotationImage()
        
            
            var markerImageName = "" // default is no image
            
            // figure out which flag image to use
        
            if let thisAnnotation = annotation as? MyCustomPointAnnotation {
                
                print("this annotation:", thisAnnotation)
                
                if (thisAnnotation.isTF) { // is TF
                    print("this point is tf")
                    if (thisAnnotation.isRLP) { // is RLP
                        
                        if (thisAnnotation.isENL) { // is ENL
                            
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "acetf-rlp-enl-ndaa-flag.png" // TF, RLP, ENL, NDAA
                            }
                            else // is not NDAA
                            {
                                markerImageName = "acetf-rlp-enl-flag.png" // TF, RLP, ENL
                            }
                        }
                        else // is not ENL
                        {
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "acetf-rlp-ndaa-flag.png" // TF, RLP, NDAA
                            }
                            else // is not NDAA
                            {
                                markerImageName = "acetf-rlp-flag.png" // TF, RLP
                            }

                        }
                    }
                    else // is not RLP
                    {
                        if (thisAnnotation.isENL) { // is ENL
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "acetf-enl-ndaa-flag.png" // TF, ENL, NDAA
                            }
                            else // is not NDAA
                            {
                                markerImageName = "acetf-enl-flag.png" // TF, ENL
                            }
                        }
                        else // is not ENL
                        {
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "acetf-ndaa-flag.png" // TF, NDAA
                            }
                            else // is not NDAA
                            {
                                markerImageName = "acetf-flag.png" // TF
                            }
                            
                        }
                    }
                }
                else // is not TF
                {
                    print("this point is not tf")
                    if (thisAnnotation.isRLP) { // is RLP
                        
                        if (thisAnnotation.isENL) { // is ENL
                            
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "rlp-enl-ndaa-flag.png" // RLP, ENL, NDAA
                            }
                            else // is not NDAA
                            {
                                markerImageName = "rlp-enl-flag.png" // RLP, ENL
                            }
                        }
                        else // is not ENL
                        {
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "rlp-ndaa-flag.png" // RLP, NDAA
                            }
                            else // is not NDAA
                            {
                                markerImageName = "rlp-flag.png" // RLP
                            }
                            
                        }
                    }
                    else // is not RLP
                    {
                        if (thisAnnotation.isENL) { // is ENL
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "enl-ndaa-flag.png" // ENL, NDAA
                            }
                            else // is not NDAA
                            {
                                markerImageName = "enl-flag.png" // ENL
                            }
                        }
                        else // is not ENL
                        {
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "ndaa-flag.png" // NDAA
                            }
                            else // is not NDAA
                            {
                                markerImageName = "" // none, return error
                                print("Error! Did not find any initiatives for this location. Could not set marker image")
                            }
                            
                        }
                    }
                }
 
        }

        
            //markerImageName = "rlp-enl-flag.png"
            print("image name:", markerImageName)
            let image = UIImage(named: markerImageName)!
            let smallImage = imageResize(image: image, targetSize: CGSize(width: 60, height: 60))
            annotationImage = MGLAnnotationImage(image: smallImage, reuseIdentifier: markerImageName)
        
        
        return annotationImage
    }
 
 
    
    /*
    // This delegate method is where you tell the map to load a view for a specific annotation based on the willUseImage property of the custom subclass.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        print("in view func")
        
     
        if let castAnnotation = annotation as? MyCustomPointAnnotation {
            if (false) {
                return nil;
            }
        }
 
        
        // Assign a reuse identifier to be used by both of the annotation views, taking advantage of their similarities.
        let reuseIdentifier = "reusableDotView"
        
        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = MGLAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            annotationView?.layer.cornerRadius = (annotationView?.frame.size.width)! / 2
            annotationView?.layer.borderWidth = 4.0
            annotationView?.layer.borderColor = UIColor.white.cgColor
            annotationView!.backgroundColor = UIColor(red:0.03, green:0.80, blue:0.69, alpha:1.0)
        }
        
        return annotationView
    }
 */
    
    
    // for scaling down flag images
    func imageResize(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, leftCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        let infoButton = UIButton(type: .detailDisclosure)
        infoButton.tintColor = UIColor.blue
        return infoButton
    }
    
    func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
        // Hide the callout view.
        mapView.deselectAnnotation(annotation, animated: false)
        
        UIAlertView(title: annotation.title!!, message: "A lovely (if touristy) place.", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK").show()
    }

    
    /*
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        // Set the alpha for all shape annotations to 1 (full opacity)
        return 1
    }
    
    func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
        // Set the line width for polyline annotations
        return 2.0
    }
    
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        // Give our polyline a unique color by checking for its `title` property
        if (annotation.title == "Crema to Council Crest" && annotation is MGLPolyline) {
            // Mapbox cyan
            return UIColor(red: 59/255, green:178/255, blue:208/255, alpha:1)
        }
        else
        {
            return .blue
        }
    }
 */
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
