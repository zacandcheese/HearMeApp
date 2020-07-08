//
//  ResetViewController.swift
//  HearMe
//
//  Created by Zachary Nowak on 6/15/20.
//  Copyright © 2020 howdyprogrammer. All rights reserved.
//

import UIKit

class ResetViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var reset: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleTextField(email)
        Utilities.styleFilledButton(reset)
    }
    
    @IBAction func closeReset(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
