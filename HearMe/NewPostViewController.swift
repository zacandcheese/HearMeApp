//
//  NewPostViewController.swift
//  HearMe
//
//  Created by Zachary Nowak on 6/16/20.
//  Copyright © 2020 howdyprogrammer. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

import MapKit
import CoreLocation

class NewPostViewController: UIViewController, UITextViewDelegate, MapViewControllerDelegate{

    @IBOutlet weak var protestName: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var currentLocationbutton: UIButton!
    @IBOutlet weak var chooseLocationButton: UIButton!
    @IBOutlet weak var commentSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var locationManager = CLLocationManager()
    var location: CLLocationCoordinate2D? = nil
    var place: CLPlacemark? = nil
    
    func doSomethingWith(data: CLLocationCoordinate2D) {
        location = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //LocationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        // Do any additional setup after loading the view.
        textView.delegate = self
        textView.text = "Place Post Message"
        textView.textColor = UIColor.lightGray
        //textView.becomeFirstResponder()
        
        datePicker.minimumDate = NSDate.init(timeIntervalSinceNow: 0) as Date
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "chooseLocation"){
            let mapVC = segue.destination as! MapViewController
            mapVC.delegate = self
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        func textViewDidEndEditing(_ textView: UITextView){
            if textView.text == "" {
                textView.text = "Place Post Message"
                textView.textColor = UIColor.lightGray
            }
        }
    }


    @IBAction func setCurrentLocation(_ sender: Any) {
        locationManager.requestLocation()
        self.location = locationManager.location?.coordinate
    }
    @IBAction func chooseLocation(_ sender: Any) {
        performSegue(withIdentifier: "chooseLocation", sender: self)
    }
    
    
    
    @IBAction func handlePostButton(_ sender: Any) {
        //guard let userProfile = UserService.currentUserProfile else { return }
        let postRef = FirebaseDatabase.Database.database().reference().child("posts").childByAutoId()
        let userProfile = Auth.auth().currentUser!
        let lat = location!.latitude as Double
        let long = location!.longitude as Double
        let postObject = [
            "author": [
                "uid": userProfile.uid,
                "username": userProfile.displayName
            ],
            "protestname" : protestName.text!,
            "description": textView.text!,
            "timestamp": [".sv":"timestamp"],
            "lat": location!.latitude as Double,
            "long" : location!.longitude as Double,
            "date" : datePicker.date.description,
        ] as [String: Any]
        
        postRef.setValue(postObject, withCompletionBlock: {error, ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print("error")
            }
        })
    
    }
    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension NewPostViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location.coordinate
        /*let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)*/
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}
