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
    
//    @IBOutlet var textView: UITextView!
    @IBOutlet var fromNameInputField: UITextField!
    @IBOutlet var messageInputView: UITextView!
    
    @IBOutlet var toIDInputField: UITextField!
    @IBOutlet var toNameInputField: UITextField!
    
    var databaseReference: DatabaseReference!
    
    let currentUserID = Auth.auth().currentUser?.uid
    let currentUserEmail = Auth.auth().currentUser?.email
    let currentUserName = Auth.auth().currentUser?.displayName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("Write")
        
        print(currentUserName!)
        print(currentUserEmail!)
        print(currentUserID!)
        
        fromNameInputField.text = currentUserName
        
        databaseReference = Database.database().reference()
        
//        databaseReference.observe(.childAdded, with: { snapshot in
//            if let obj = snapshot.value as? [String: AnyObject], let toName = obj["toName"] as? String, let toID = obj["toID"] as? String, let fromName = obj["fromName"] as? String, let message = obj["message"] {
//                let currentText = self.textView.text
//                if toID == self.currentUserID {
//                    self.textView.text = (currentText ?? "") + "\(fromName) : \(message)"
//                }
//            }
//        })
        
    }
    
    @IBAction func tappedSendButton(_ sender: Any) {
        view.endEditing(true)
        if let toName = toNameInputField.text, let toID = toIDInputField.text, let fromID = currentUserID, let fromName = fromNameInputField.text, let message = messageInputView.text {
            let messageData = ["toName": toName, "toID": toID, "message": message, "name": fromName, "fromID": fromID]
            databaseReference.childByAutoId().setValue(messageData)
            toNameInputField.text = ""
            toIDInputField.text = ""
            messageInputView.text = ""
        }
    }
    
}
