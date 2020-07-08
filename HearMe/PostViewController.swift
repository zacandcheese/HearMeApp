//
//  PostViewController.swift
//  HearMe
//
//  Created by Zachary Nowak on 6/16/20.
//  Copyright © 2020 howdyprogrammer. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import Firebase


class PostViewController: UIViewController, UITableViewDelegate{

    @IBOutlet weak var nameOfProtest: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var textVeiw: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var NAME : String = ""
    var DATE : String = ""
    var DESCRIPT : String = ""
    var POST : Post? = nil
    var COMMENTS : [Comment] = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameOfProtest.text = NAME
        date.text = self.DATE
        textVeiw.text = self.DESCRIPT
        
        //Updating MapView
        let lat = POST!.lat
        let long = POST!.long
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let viewRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.001,longitudeDelta: 0.001))
        
        mapView.setRegion(viewRegion, animated: true)
        
        //Adding Pin of Spot (maybe directions)
        let point = MKPointAnnotation()
        point.title = "Spot of Protest"
        point.coordinate = location
        mapView.addAnnotation(point)
        
        //Generate Comments
        let cellNib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "postCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        observePosts()
    }
    
    func observePosts(){
        let postsRef = FirebaseDatabase.Database.database().reference().child("posts/\(String(describing: POST!.id))/comments")
        print("\(POST!.id)")
        print(postsRef)
        postsRef.observe(.value, with: { (snapshot) in
            var tempComments = [Comment]()
            for child in snapshot.children {
                let childSnapshot = child as? DataSnapshot
                let dict = childSnapshot?.value as! NSDictionary?
                let username = dict!["username"] as? String
                let timestamp = dict!["timestamp"] as? Double
                let content = dict!["content"] as? String
                let post = Comment(userName: username!, comment: content!, timestamp: timestamp!)
                tempComments.append(post)
            }
            self.COMMENTS = tempComments
            self.tableView.reloadData()
        })
    }
    
    @IBAction func newComment(_ sender: Any) {
        var popUpWindow: PopUpWindow!
        popUpWindow = PopUpWindow(post: POST!)
        self.present(popUpWindow, animated: true, completion: nil)
    }
    @IBAction func handleDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return COMMENTS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! CommentTableViewCell
        cell.set(comment: COMMENTS[indexPath.row])
        return cell
    }
    
    
}
