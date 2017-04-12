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
    
    // 15 arrays to hold markers of each category (not 16 because every marker has at least one category)
    var tf_markers = [MyCustomPointAnnotation]()
    var tf_rlp_markers = [MyCustomPointAnnotation]()
    var tf_rlp_enl_markers = [MyCustomPointAnnotation]()
    var tf_rlp_enl_ndaa_markers = [MyCustomPointAnnotation]()
    var tf_rlp_ndaa_markers = [MyCustomPointAnnotation]()
    var tf_enl_ndaa_markers = [MyCustomPointAnnotation]()
    var tf_enl_markers = [MyCustomPointAnnotation]()
    var tf_ndaa_markers = [MyCustomPointAnnotation]()
    var rlp_markers = [MyCustomPointAnnotation]()
    var rlp_enl_markers = [MyCustomPointAnnotation]()
    var rlp_ndaa_markers = [MyCustomPointAnnotation]()
    var rlp_enl_ndaa_markers = [MyCustomPointAnnotation]()
    var enl_markers = [MyCustomPointAnnotation]()
    var enl_ndaa_markers = [MyCustomPointAnnotation]()
    var ndaa_markers = [MyCustomPointAnnotation]()
    
    /*
    var all_markers = [MyCustomPointAnnotation]()
    var not_tf_markers = [MyCustomPointAnnotation]()
    var not_tf_rlp_markers = [MyCustomPointAnnotation]()
    var not_tf_rlp_enl_markers = [MyCustomPointAnnotation]()
    var not_tf_rlp_enl_ndaa_markers = [MyCustomPointAnnotation]()
    var not_tf_rlp_ndaa_markers = [MyCustomPointAnnotation]()
    var not_tf_enl_ndaa_markers = [MyCustomPointAnnotation]()
    var not_tf_enl_markers = [MyCustomPointAnnotation]()
    var not_tf_ndaa_markers = [MyCustomPointAnnotation]()
    var not_rlp_markers = [MyCustomPointAnnotation]()
    var not_rlp_enl_markers = [MyCustomPointAnnotation]()
    var not_rlp_ndaa_markers = [MyCustomPointAnnotation]()
    var not_rlp_enl_ndaa_markers = [MyCustomPointAnnotation]()
    var not_enl_markers = [MyCustomPointAnnotation]()
    var not_enl_ndaa_markers = [MyCustomPointAnnotation]()
    var not_ndaa_markers = [MyCustomPointAnnotation]()
    */

    
    // filter toggles
    var tfOn = true
    var rlpOn = true
    var enlOn = true
    var ndaaOn = true
    
    // toggle filter handlers
    @IBAction func pressedNDAA(_ sender: Any) {
        ndaaOn = !ndaaOn
        clearAllAnnotations()
        drawCorrectAnnotations()
    }
    @IBAction func pressedENL(_ sender: Any) {
        enlOn = !enlOn
        clearAllAnnotations()
        drawCorrectAnnotations()
    }
    @IBAction func pressedRLP(_ sender: Any) {
        rlpOn = !rlpOn
        clearAllAnnotations()
        drawCorrectAnnotations()
    }
    @IBAction func pressedTF(_ sender: Any) {
        tfOn = !tfOn
        clearAllAnnotations()
        drawCorrectAnnotations()
    }

    
    @IBOutlet weak var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.01, green: 0.16, blue: 0.40, alpha: 1.0)
        
        mapView.delegate = self
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: 37.09,
                                                 longitude: -95.71),
                          zoomLevel: 2, animated: false)
        
        drawPolyline()
    }
    
    func clearAllAnnotations() {
        print("clearing all annotations")
        if mapView.annotations != nil {
            mapView.removeAnnotations(mapView.annotations!)
        }
        else {
            print("no markers on map anyway")
        }
    }
    
    func drawCorrectAnnotations() {
        var useTheseMarkers = [MyCustomPointAnnotation]()
        
        /*
        if (tfOn) {
            if (rlpOn) {
                if (enlOn) {
                    if (ndaaOn) {
                        useTheseMarkers = all_markers // TF, RLP, ENL, NDAA
                    }
                    else {
                        useTheseMarkers = not_ndaa_markers // TF, RLP, ENL
                    }
                }
                else {
                    if (ndaaOn) {
                        useTheseMarkers = not_enl_markers // TF, RLP, NDAA
                    }
                    else {
                        useTheseMarkers = not_enl_ndaa_markers // TF, RLP
                    }
                    
                }
            }
            else {
                if (enlOn) {
                    if (ndaaOn) {
                        useTheseMarkers = not_rlp_markers // TF, ENL, NDAA
                    }
                    else {
                        useTheseMarkers = not_rlp_ndaa_markers // TF, ENL
                    }
                }
                else {
                    if (ndaaOn) {
                        useTheseMarkers = not_rlp_enl_markers // TF, NDAA
                    }
                    else {
                        useTheseMarkers = not_rlp_enl_ndaa_markers // TF
                    }
                    
                }
            }
        }
        else {
            if (rlpOn) {
                if (enlOn) {
                    if (ndaaOn) {
                        useTheseMarkers = not_tf_markers // RLP, ENL, NDAA
                    }
                    else {
                        useTheseMarkers = not_tf_ndaa_markers // RLP, ENL
                    }
                }
                else {
                    if (ndaaOn) {
                        useTheseMarkers = not_tf_enl_markers // RLP, NDAA
                    }
                    else {
                        useTheseMarkers = not_tf_enl_ndaa_markers // RLP
                    }
                    
                }
            }
            else {
                if (enlOn) {
                    if (ndaaOn) {
                        useTheseMarkers = not_tf_rlp_markers // ENL, NDAA
                    }
                    else {
                        useTheseMarkers = not_tf_rlp_ndaa_markers // ENL
                    }
                }
                else {
                    if (ndaaOn) {
                        useTheseMarkers = not_tf_rlp_enl_markers // NDAA
                    }
                    else {
                        //useTheseMarkers = all_markers
                        print("no points")
                        return
                    }
                    
                }
            }
        }
        */
        
        if (tfOn) {
            if (rlpOn) {
                if (enlOn) {
                    if (ndaaOn) {
                        useTheseMarkers = tf_markers + rlp_markers + enl_markers + ndaa_markers // TF, RLP, ENL, NDAA
                    }
                    else {
                        useTheseMarkers = tf_markers + rlp_markers + enl_markers // TF, RLP, ENL
                    }
                }
                else {
                    if (ndaaOn) {
                        useTheseMarkers = tf_markers + rlp_markers + ndaa_markers // TF, RLP, NDAA
                    }
                    else {
                        useTheseMarkers = tf_markers + rlp_markers // TF, RLP
                    }
                    
                }
            }
            else {
                if (enlOn) {
                    if (ndaaOn) {
                        useTheseMarkers = tf_markers + enl_markers + ndaa_markers // TF, ENL, NDAA
                    }
                    else {
                        useTheseMarkers = tf_markers + enl_markers // TF, ENL
                    }
                }
                else {
                    if (ndaaOn) {
                        useTheseMarkers = tf_markers + ndaa_markers // TF, NDAA
                    }
                    else {
                        useTheseMarkers = tf_markers // TF
                    }
                    
                }
            }
        }
        else {
            if (rlpOn) {
                if (enlOn) {
                    if (ndaaOn) {
                        useTheseMarkers = rlp_markers + enl_markers + ndaa_markers // RLP, ENL, NDAA
                    }
                    else {
                        useTheseMarkers = rlp_markers + enl_markers // RLP, ENL
                    }
                }
                else {
                    if (ndaaOn) {
                        useTheseMarkers = rlp_markers + ndaa_markers // RLP, NDAA
                    }
                    else {
                        useTheseMarkers = rlp_markers // RLP
                    }
                    
                }
            }
            else {
                if (enlOn) {
                    if (ndaaOn) {
                        useTheseMarkers = enl_markers + ndaa_markers // ENL, NDAA
                    }
                    else {
                        useTheseMarkers = enl_markers // ENL
                    }
                }
                else {
                    if (ndaaOn) {
                        useTheseMarkers = ndaa_markers // NDAA
                    }
                    else {
                        //useTheseMarkers = tf_markers // none
                        print("Error! No filters selected. Not graphing any points.")
                        return
                    }
                    
                }
            }
        }
        
        /*
        if (tfOn) {
            if (rlpOn) {
                if (enlOn) {
                    if (ndaaOn) {
                        useTheseMarkers = tf_rlp_enl_ndaa_markers // TF, RLP, ENL, NDAA
                    }
                    else {
                        useTheseMarkers = tf_rlp_enl_markers // TF, RLP, ENL
                    }
                }
                else {
                    if (ndaaOn) {
                        useTheseMarkers = tf_rlp_ndaa_markers // TF, RLP, NDAA
                    }
                    else {
                        useTheseMarkers = tf_rlp_markers // TF, RLP
                    }

                }
            }
            else {
                if (enlOn) {
                    if (ndaaOn) {
                        useTheseMarkers = tf_enl_ndaa_markers // TF, ENL, NDAA
                    }
                    else {
                        useTheseMarkers = tf_enl_markers // TF, ENL
                    }
                }
                else {
                    if (ndaaOn) {
                        useTheseMarkers = tf_ndaa_markers // TF, NDAA
                    }
                    else {
                        useTheseMarkers = tf_markers // TF
                    }
                    
                }
            }
        }
        else {
            if (rlpOn) {
                if (enlOn) {
                    if (ndaaOn) {
                        useTheseMarkers = rlp_enl_ndaa_markers // RLP, ENL, NDAA
                    }
                    else {
                        useTheseMarkers = rlp_enl_markers // RLP, ENL
                    }
                }
                else {
                    if (ndaaOn) {
                        useTheseMarkers = rlp_ndaa_markers // RLP, NDAA
                    }
                    else {
                        useTheseMarkers = rlp_markers // RLP
                    }
                    
                }
            }
            else {
                if (enlOn) {
                    if (ndaaOn) {
                        useTheseMarkers = enl_ndaa_markers // ENL, NDAA
                    }
                    else {
                        useTheseMarkers = enl_markers // ENL
                    }
                }
                else {
                    if (ndaaOn) {
                        useTheseMarkers = ndaa_markers // NDAA
                    }
                    else {
                        //useTheseMarkers = tf_markers // none
                        print("Error! No filters selected. Not graphing any points.")
                        return
                    }
                    
                }
            }
        }
 */
 
        
        for m in useTheseMarkers {
            // Add the annotation on the main thread
            DispatchQueue.main.async(execute: {
                [unowned self] in
                self.mapView.addAnnotation(m)
            })

        }
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
                        
                        print("polyline info:", polyline)
                        
                        // "programs" = [#TF programs, #Remick Leaders, #ENL teachers, # Notre Dame ACE Academies]
                        let programs = polyline.attributes["programs"] as! [Int]
                        //print("#TF:", programs[0], "#Remick leaders:", programs[1], "#ENL teachers", programs[2], "#NDAA", programs[3])
                        var caption:String!

                        // for the number of initiatives displayed in subtitles. I doubt this will ever go above 20 for one location, but feel free to make this array longer if we need bigger numbers
                        let numberStrings = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen", "twenty"]
                        
                        // count number of initiatives served in this location
                        var numInitiativesServed:Int! = 0
                        for p in programs {
                            if (p > 0) {
                                numInitiativesServed = numInitiativesServed + 1
                            }
                        }
                        
                        // make caption string (aka subtitle)
                        let city = polyline.attributes["city"] as! String
                        if (numInitiativesServed > 1) { // multiple initiatives served in one city
                            caption = "ACE has " + numberStrings[numInitiativesServed] + " initiatives serving Catholic schools in " + city
                        }
                        else if (programs[0] >= 1) { // only TF
                            if (programs[0] == 1) { // singular
                                caption = "ACE has " + numberStrings[programs[0]] + " Teaching Fellows community serving Catholic schools in " + city
                            }
                            else { // plural
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

                        
                        let thisAnnotation = MyCustomPointAnnotation()
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
                        
                        //polyline.title = polyline.attributes["title"] as? String
                        //polyline.subtitle = caption
                    
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
                
                //print("this annotation:", thisAnnotation)
                
                if (thisAnnotation.isTF) { // is TF
                    //print("this point is tf")
                    if (thisAnnotation.isRLP) { // is RLP
                        
                        if (thisAnnotation.isENL) { // is ENL
                            
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "acetf-rlp-enl-ndaa-flag.png" // TF, RLP, ENL, NDAA
                                tf_markers.append(thisAnnotation)
                                rlp_markers.append(thisAnnotation)
                                enl_markers.append(thisAnnotation)
                                ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "acetf-rlp-enl-flag.png" // TF, RLP, ENL
                                tf_markers.append(thisAnnotation)
                                rlp_markers.append(thisAnnotation)
                                enl_markers.append(thisAnnotation)
                            }
                        }
                        else // is not ENL
                        {
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "acetf-rlp-ndaa-flag.png" // TF, RLP, NDAA
                                tf_markers.append(thisAnnotation)
                                rlp_markers.append(thisAnnotation)
                                ndaa_markers.append(thisAnnotation)

                            }
                            else // is not NDAA
                            {
                                markerImageName = "acetf-rlp-flag.png" // TF, RLP
                                tf_markers.append(thisAnnotation)
                                rlp_markers.append(thisAnnotation)
                            }
                            
                        }
                    }
                    else // is not RLP
                    {
                        if (thisAnnotation.isENL) { // is ENL
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "acetf-enl-ndaa-flag.png" // TF, ENL, NDAA
                                tf_markers.append(thisAnnotation)
                                enl_markers.append(thisAnnotation)
                                ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "acetf-enl-flag.png" // TF, ENL
                                tf_markers.append(thisAnnotation)
                                enl_markers.append(thisAnnotation)
                            }
                        }
                        else // is not ENL
                        {
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "acetf-ndaa-flag.png" // TF, NDAA
                                tf_markers.append(thisAnnotation)
                                ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "acetf-flag.png" // TF
                                tf_markers.append(thisAnnotation)
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
                                rlp_markers.append(thisAnnotation)
                                enl_markers.append(thisAnnotation)
                                ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "rlp-enl-flag.png" // RLP, ENL
                                rlp_markers.append(thisAnnotation)
                                enl_markers.append(thisAnnotation)
                            }
                        }
                        else // is not ENL
                        {
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "rlp-ndaa-flag.png" // RLP, NDAA
                                rlp_markers.append(thisAnnotation)
                                ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "rlp-flag.png" // RLP
                                rlp_markers.append(thisAnnotation)
                            }
                            
                        }
                    }
                    else // is not RLP
                    {
                        if (thisAnnotation.isENL) { // is ENL
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "enl-ndaa-flag.png" // ENL, NDAA
                                enl_markers.append(thisAnnotation)
                                ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "enl-flag.png" // ENL
                                enl_markers.append(thisAnnotation)
                            }
                        }
                        else // is not ENL
                        {
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "ndaa-flag.png" // NDAA
                                ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "" // none, return error
                                print("Error! Did not find any initiatives for this location. Could not set marker image")
                            }
                            
                        }
                    }
                }
                
                /*
                if (thisAnnotation.isTF) { // is TF
                    //print("this point is tf")
                    if (thisAnnotation.isRLP) { // is RLP
                        
                        if (thisAnnotation.isENL) { // is ENL
                            
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "acetf-rlp-enl-ndaa-flag.png" // TF, RLP, ENL, NDAA
                                tf_rlp_enl_ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "acetf-rlp-enl-flag.png" // TF, RLP, ENL
                                tf_rlp_enl_markers.append(thisAnnotation)
                            }
                        }
                        else // is not ENL
                        {
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "acetf-rlp-ndaa-flag.png" // TF, RLP, NDAA
                                tf_rlp_ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "acetf-rlp-flag.png" // TF, RLP
                                tf_rlp_markers.append(thisAnnotation)
                            }

                        }
                    }
                    else // is not RLP
                    {
                        if (thisAnnotation.isENL) { // is ENL
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "acetf-enl-ndaa-flag.png" // TF, ENL, NDAA
                                tf_enl_ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "acetf-enl-flag.png" // TF, ENL
                                tf_enl_markers.append(thisAnnotation)
                            }
                        }
                        else // is not ENL
                        {
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "acetf-ndaa-flag.png" // TF, NDAA
                                tf_ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "acetf-flag.png" // TF
                                tf_markers.append(thisAnnotation)
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
                                rlp_enl_ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "rlp-enl-flag.png" // RLP, ENL
                                rlp_enl_markers.append(thisAnnotation)
                            }
                        }
                        else // is not ENL
                        {
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "rlp-ndaa-flag.png" // RLP, NDAA
                                rlp_ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "rlp-flag.png" // RLP
                                rlp_markers.append(thisAnnotation)
                            }
                            
                        }
                    }
                    else // is not RLP
                    {
                        if (thisAnnotation.isENL) { // is ENL
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "enl-ndaa-flag.png" // ENL, NDAA
                                enl_ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "enl-flag.png" // ENL
                                enl_markers.append(thisAnnotation)
                            }
                        }
                        else // is not ENL
                        {
                            if (thisAnnotation.isNDAA) { // is NDAA
                                markerImageName = "ndaa-flag.png" // NDAA
                                ndaa_markers.append(thisAnnotation)
                            }
                            else // is not NDAA
                            {
                                markerImageName = "" // none, return error
                                print("Error! Did not find any initiatives for this location. Could not set marker image")
                            }
                            
                        }
                    }
                }
 */
 
        }

            //print("image name:", markerImageName)
            let image = UIImage(named: markerImageName)!
            let smallImage = imageResize(image: image, targetSize: CGSize(width: 60, height: 60))
            annotationImage = MGLAnnotationImage(image: smallImage, reuseIdentifier: markerImageName)
        
        
        return annotationImage
    }
 
 
    
    
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
        
        var message = " "
        var title = " "
        
        if annotation is MyCustomPointAnnotation {
            print("annotation:", annotation)
            message = annotation.subtitle!!
            title = annotation.title!!
        }
        
        // do alert view
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Done", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
            print("You pressed OK")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
