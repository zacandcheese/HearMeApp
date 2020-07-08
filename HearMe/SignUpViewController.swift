//
//  SignUpViewController.swift
//  HearMe
//
//  Created by Zachary Nowak on 6/15/20.
//  Copyright © 2020 howdyprogrammer. All rights reserved.
//
import Foundation
import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var SignUp: UIButton!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.styleFilledButton(SignUp)
        Utilities.styleTextField(userName)
        Utilities.styleTextField(email)
        Utilities.styleTextField(passWord)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let homeVC = presentingViewController as? ViewController {
            DispatchQueue.main.async {
                homeVC.viewDidLoad()
            }
        }
    }
    func setContinueButton(enabled: Bool) {
        if enabled {
            continueButton.alpha = 1.0
            continueButton.isEnabled = true
        }
        else {
            continueButton.alpha = 0.5
            continueButton.isEnabled = false
        }
    }
    
    @IBAction func handleSignUp(_ sender: Any) {
  
        guard let username = self.userName.text else { return }
        guard let email = self.email.text else { return }
        guard let pass = self.passWord.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if error == nil && user != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges {
                    error in
                    if error == nil {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    @IBAction func closeSignUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToLogin(_ sender: Any) {
            let sU = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
    Utilities.presentHidingBehindScreenSnapshot(viewController: sU, completion: nil)
    //Utilities.switchScreen(viewController: sU)    }
    }
}
