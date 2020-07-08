//
//  Helper.swift
//  HearMe
//
//  Created by Zachary Nowak on 6/12/20.
//  Copyright © 2020 howdyprogrammer. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    static func styleTextField(_ textfield: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
    }
    static func styleFilledButton(_ button: UIButton) {
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha:1)
        button.layer.cornerRadius = 15.0 //25
        button.tintColor = UIColor.white
    }
    static func styleHollowButton(_ button: UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    static func switchScreen(viewController: UIViewController) {
        UIApplication.shared.keyWindow!.rootViewController = viewController
        UIApplication.shared.keyWindow!.makeKeyAndVisible()
        
    }
    static func presentHidingBehindScreenSnapshot(viewController: UIViewController, completion: (()-> (Void))? ) {
        if let screenSnapshot = UIApplication.shared.keyWindow?.snapshotView(afterScreenUpdates: false),
            let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.view.addSubview(screenSnapshot)
            rootViewController.view.bringSubviewToFront(screenSnapshot)
            rootViewController.dismiss(animated: false, completion: {
                rootViewController.present(viewController, animated: false, completion: {
                    screenSnapshot.removeFromSuperview()
                    if let existingCompletion = completion {
                        existingCompletion()
                    }
                })
            })
        }
    }}
