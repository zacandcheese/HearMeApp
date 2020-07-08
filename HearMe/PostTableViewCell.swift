//
//  PostTableViewCell.swift
//  HearMe
//
//  Created by Zachary Nowak on 6/16/20.
//  Copyright © 2020 howdyprogrammer. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var protestNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var placemarkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func set(post:Post) {
        protestNameLabel.text = post.title
        
        let lat = post.lat
        let long = post.long
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        var place = "Error Occured"
        //placemarkLabel.text = place
        geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
            var placeMark: CLPlacemark!
            placeMark = (placemark?[0])
            place = placeMark.country!
            print("HEREREEEE: " + place)
            
            
            if let addressDict = placeMark.addressDictionary, let coord = placeMark.location?.coordinate {
                let mkPlacemark = MKPlacemark(coordinate: coord, addressDictionary: addressDict as! [String : Any])
                place = LocationSearchTable.parseAddress(selectedItem: mkPlacemark)
                self.placemarkLabel.text = place
            }
        }
        timeLabel.text = post.date
    }
}
