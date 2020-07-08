//
//  ViewController.swift
//  HearMe
//
//  Created by Zachary Nowak on 6/15/20.
//  Copyright © 2020 howdyprogrammer. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var addPage: UIButton!
    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var SignUp: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var name = ""
    var reasonProtest = ""
    var lat = 0
    var long = 0
    var time = ""
    var selectedPost : Post? = nil
    
    var posts = [Post]()
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.backgroundColor = UIColor.black
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "postCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        observePosts()
        
        let user = Auth.auth().currentUser
        if user != nil {
            Login.isHidden = true
            SignUp.isHidden = true
            addPage.isHidden = false
            logOut.isHidden = false
        }
        else {
            Login.isHidden = false
            SignUp.isHidden = false
            addPage.isHidden = true
            logOut.isHidden = true
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PostViewController{
            vc.NAME = self.name
            vc.DESCRIPT = self.reasonProtest
            vc.DATE = (self.time)
            vc.POST = self.selectedPost
        }
    }
    
    
    func observePosts(){
        let postsRef = FirebaseDatabase.Database.database().reference().child("posts")
        postsRef.observe(.value, with: { (snapshot) in
            var tempPosts = [Post]()
            for child in snapshot.children {
                let childSnapshot = child as? DataSnapshot
                let theKey = childSnapshot!.key as? String
                let dict = childSnapshot?.value as! NSDictionary?
                let author = dict!["author"] as! NSDictionary?
                let username = author!["username"] as? String
                let uid = author!["uid"] as? String
                let description = dict!["description"] as? String
                let title = dict!["protestname"] as? String
                let lat = dict!["lat"] as? Double
                let long = dict!["long"] as? Double
                let timestamp = dict!["timestamp"] as? Double
                let date = dict!["date"] as? String
                let userProfile = UserProfile(uid: uid!, username: username!)
                let post = Post(id: theKey!, author: userProfile, title: title!, description: description!, lat: lat!, long: long!, date: date!)
                tempPosts.append(post)
            }
            self.posts = tempPosts
            self.tableView.reloadData()
        })
    }
    
    @IBAction func transitionToMap(_ sender: Any) {
        self.performSegue(withIdentifier: "toMap", sender: self)
    }
    
    
    @IBAction func loggingOut(_ sender: Any) {
        try! Auth.auth().signOut()
        viewDidLoad()
    }
    @IBAction func goToLogin(_ sender: Any) {
        performSegue(withIdentifier: "LoginTransfer", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        cell.set(post: posts[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.name = posts[indexPath.row].title
        self.reasonProtest = posts[indexPath.row].description
        self.time = (posts[indexPath.row].date)
        self.selectedPost = posts[indexPath.row]
        
        performSegue(withIdentifier: "presentPost", sender: self)
    }
}

