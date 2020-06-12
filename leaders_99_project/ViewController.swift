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
import PKHUD

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
    
    let date: Date = Date()
    let dateFormatter = DateFormatter()
    
    let backgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = backgroundColor
        
        print("Write")
        
        print(currentUserName!)
        print(currentUserEmail!)
        print(currentUserID!)
        
        fromNameInputField.text = currentUserName
        
        databaseReference = Database.database().reference()
        
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        
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
            let sentDate = dateFormatter.string(from: date)
            let messageData = ["toName": toName, "toID": toID, "message": message, "name": fromName, "fromID": fromID, "sentDate": sentDate]
            databaseReference.childByAutoId().setValue(messageData)
            toNameInputField.text = ""
            toIDInputField.text = ""
            messageInputView.text = ""
            print(sentDate)
            
            HUD.flash(.labeledSuccess(title: "Sent", subtitle: ""), delay: 1.0)
            let when = DispatchTime.now()
            DispatchQueue.main.asyncAfter(deadline: when + 2.0) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "HomeViewController")
                
                viewController.modalPresentationStyle = .fullScreen
                viewController.modalTransitionStyle = .crossDissolve
                self.present(viewController, animated: true, completion: nil)
                
            }
        }
    }
    
    @IBAction func pushCloseButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Discard?", message: "All text will be deleted", preferredStyle:  UIAlertController.Style.alert)
                
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("Discard")
            
            self.dismiss(animated: true, completion: nil)
            
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}
