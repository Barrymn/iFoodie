//
//  restaurantMapViewController.swift
//  iFoodie
//
//  Created by Barry on 2016-03-22.
//  Copyright © 2016 Ning Ma. All rights reserved.
//

import UIKit
import MapKit

class restaurantMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    var restaurant:Restaurant!
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        // Reuse the annotation if possible
        var annotationView:MKPinAnnotationView? =
        mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        leftIconView.image = UIImage(data: restaurant.image!)
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        return annotationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self

        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks, error in
            if error != nil {
                print(error)
                return
            }
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    // Display the annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
