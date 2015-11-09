//
//  ServiceDetailViewController.swift
//  Greasemonkey
//
//  Created by david on 11/7/15.
//  Copyright © 2015 Greasemonkey. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ServiceDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()

    @IBOutlet weak var findmeBUtton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        configureLocationManager()
        
        assignTapToView1()

        profileView.hidden = true
        // Do any additional setup after loading the view.
    }

    func configureLocationManager()
    {
        let locAuthStatus = CLLocationManager.authorizationStatus()
        
        if locAuthStatus != CLAuthorizationStatus.Denied && locAuthStatus != CLAuthorizationStatus.Restricted
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            
            if locAuthStatus == CLAuthorizationStatus.NotDetermined
            {
                locationManager.requestWhenInUseAuthorization()
            }
            else
            {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print(error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        geocoder.reverseGeocodeLocation(location!, completionHandler: {(placemark: [CLPlacemark]?, error: NSError?) -> Void in
            
            if error != nil
            {
                print(error?.localizedDescription)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            else
            {
                self.locationManager.stopUpdatingLocation()
                
                print("reverse geocode success")
                
                self.updateMapView(placemark!)
            }
            
        })
    }
    
    func updateMapView(placemarks: [CLPlacemark])
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        print("success")
        
        let placemark = placemarks[0]
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = (placemark.location?.coordinate)!
        annotation.title = "You"
        let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 15000, 15000)
        
        self.mapView.setRegion(region, animated: true)
        
        let fakeAnnotation1 = MKPointAnnotation()
        let fakeAnnotation2 = MKPointAnnotation()
        
        fakeAnnotation1.title = "Mechanic"
        fakeAnnotation2.title = "Mechanic"
        
        //28.5961° N, 81.3467° W
        
        fakeAnnotation1.coordinate = CLLocationCoordinate2DMake(28.5961, -81.3467)
        
        //28.6147216
        //Eatonville Longitude
        //-81.3806249
        fakeAnnotation2.coordinate = CLLocationCoordinate2DMake(28.614216, -81.3806249)
        
        let annotations = [annotation, fakeAnnotation1, fakeAnnotation2]
        
        self.mapView.addAnnotations(annotations)
        self.mapView.selectAnnotation(annotation, animated: true)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    private var selectedAnnotationView: MKAnnotationView?
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let _ = annotation as? MKUserLocation {
            return nil
        }
        let ident = "MyAnnotation"
        let pin = mapView.dequeueReusableAnnotationViewWithIdentifier(ident) as? MKPinAnnotationView ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: ident)
        pin.animatesDrop = true
        pin.canShowCallout = true
        pin.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "annotationTapped:"))
        pin.rightCalloutAccessoryView = UIButton(type: .InfoDark)
        return pin
    }
    
    // This will get called before didDeselectAnnotationView below
    func annotationTapped(tapGesture: UITapGestureRecognizer) {
        if let annotationView = tapGesture.view as? MKAnnotationView {
            
            if annotationView === self.selectedAnnotationView {
                // same as last time
            } else {
                // different annotation view
            }
            
            self.selectedAnnotationView = annotationView
            
            print("annotationTapped")
            animate()
            // any other logic for handling annotation view tap
        }
    }
    
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        if view === self.selectedAnnotationView {
            
            // The user did not select another annotation view
            // (e.g. they tapped the map)            
            
            self.selectedAnnotationView = nil
        }
    }
    
    func animate()
    {
        self.profileView.hidden = !self.profileView.hidden
//        UIView.animateWithDuration(0.5, delay: 0.0, options: [], animations:
//            {
////                var img = self.profileView.frame
////                img.origin.y += img.size.height + 600
//                self.profileView.frame.origin.y = 600
//                
////                self.profileView.frame = img
//            }, completion: nil)
    }
    
    @IBAction func callPhone(sender: UIButton)
    {
        callNumber("5555555555")
    }
    
    private func callNumber(phoneNumber:String)
    {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)")
        {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL))
            {
                application.openURL(phoneCallURL);
            }
        }
    }
    
    func assignTapToView1()
    {
        let tap = UITapGestureRecognizer(target: self, action: Selector("profileViewTapped"))
        //  tap.delegate = self
        profileView.addGestureRecognizer(tap)
//        self.view.addSubview()
    }
    
    func profileViewTapped()
    {
        print("prof view tapped")
        performSegueWithIdentifier("showDetailedProfileSegue", sender: self)
    }
    
    @IBAction func findmeButton(sender: UIButton)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.locationManager.startUpdatingLocation()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
