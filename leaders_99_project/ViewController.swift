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
    
    var databaseReference: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Inbox")
        
        let currentUserID = Auth.auth().currentUser?.uid
        let currentUserEmail = Auth.auth().currentUser?.email
        let currentUserName = Auth.auth().currentUser?.displayName
        print(currentUserName!)
        print(currentUserEmail!)
        print(currentUserID!)
        
        nameInputField.text = currentUserName
        
        databaseReference = Database.database().reference()
        
        databaseReference.observe(.childAdded, with: { snapshot in
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
        databaseReference.childByAutoId().setValue(messageData)
        messageInputField.text = ""
        }
    }
    
}
