//
//  ViewController.swift
//  leaders_99_project
//
//  Created by Yoshinori Shibahara on 2020/05/19.
//  Copyright © 2020 Yoshinori Shibahara. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var nameInputField: UITextField!
    @IBOutlet var messageInputField: UITextField!
    
    var databaseRefrence: DatabaseRefrence!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        databaseRefrence = Database.detabase().refrence()
        
        databaseRefrence.observe(.childAdded, with: { snapshot in
            if let obj = snapshot.value as? [String: AnyObject], let name = obj["name"] as? String, let message = obj["message"] {
            let currentText = self.textView.text
            self.textView.text = (currentText ?? "") + "\n\(name) : \(message)"
            }
        })
    }
    
    @IBAction func tappedSendButton(_ sender: Any) {
     view.endEditing(true)

     if let name = nameInputField.text, let message = messageInputField.text {
         let messageData = ["name": name, "message": message]
        }
    }
    
}
