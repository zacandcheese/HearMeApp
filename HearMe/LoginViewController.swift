//
//  LoginViewController.swift
//  HearMe
//
//  Created by Zachary Nowak on 6/15/20.
//  Copyright © 2020 howdyprogrammer. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        Utilities.styleTextField(email)
        Utilities.styleTextField(passWord)
        Utilities.styleFilledButton(login)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let homeVC = presentingViewController as? ViewController {
            DispatchQueue.main.async {
                homeVC.viewDidLoad()
            }
        }    }
    @IBAction func closeLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func handleSignIn(_ sender: Any) {
        guard let email = self.email.text else { return }
        guard let pass = self.passWord.text else { return }
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if error == nil && user != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
        
    }
    
    @IBAction func transferSignUp(_ sender: Any) {
        let sU = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
        Utilities.presentHidingBehindScreenSnapshot(viewController: sU, completion: nil)
        //Utilities.switchScreen(viewController: sU)
    }
}

