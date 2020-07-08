//
//  PopUpWindow.swift
//  HearMe
//
//  Created by Zachary Nowak on 6/29/20.
//  Copyright © 2020 howdyprogrammer. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase


private class PopUpWindowView: UIView {
    let popupView = UIView(frame: CGRect.zero)
    let popupText = UITextView(frame: CGRect.zero)
    let popupButton = UIButton(frame: CGRect.zero)
    
    let BorderWidth: CGFloat = 2.0
    
    
    init(){
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        //Popup Background
        popupView.backgroundColor = UIColor.blue
        popupView.layer.borderWidth = BorderWidth
        popupView.layer.masksToBounds = true
        popupView.layer.borderColor = UIColor.white.cgColor
        
        //Popup Text
        popupText.textColor = UIColor.black
        popupText.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        popupText.textAlignment = .left
        
        //Popup Button
        popupButton.setTitleColor(UIColor.white, for: .normal)
        popupButton.titleLabel?.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        popupButton.backgroundColor = UIColor.blue
        
        popupView.addSubview(popupText)
        popupView.addSubview(popupButton)
        addSubview(popupView)
        
        
        
        //Constraints
        popupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupView.widthAnchor.constraint(equalToConstant: 293),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        popupText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupText.heightAnchor.constraint(equalToConstant: 167),
            popupText.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 8),
            popupText.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -8),
            popupText.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 8),
            popupText.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -8)
        ])
        
        popupButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupButton.heightAnchor.constraint(equalToConstant: 44),
            popupButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 8),
            popupButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor,
            constant: -8),
            popupButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -8)
        ])
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class PopUpWindow: UIViewController {
    private let popUpWindowView = PopUpWindowView()
    
    var post : Post? = nil
    
    init(post : Post){
        super.init(nibName: nil, bundle: nil)
        self.post = post
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        
        popUpWindowView.popupButton.setTitle("DONE", for: .normal)
        popUpWindowView.popupButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        view = popUpWindowView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissView(){
        let postRef = FirebaseDatabase.Database.database().reference().child("posts/\(post!.id)/comments").childByAutoId()
        let userProfile = Auth.auth().currentUser!
        let postObject = [
            "uid": userProfile.uid,
            "username": userProfile.displayName,
            "content": popUpWindowView.popupText.text!,
            "timestamp": [".sv":"timestamp"],
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
}
