//
//  HomeViewController.swift
//  leaders_99_project
//
//  Created by Yoshinori Shibahara on 2020/05/27.
//  Copyright © 2020 Yoshinori Shibahara. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import PKHUD

class HomeViewController: UIViewController {
    
    var databaseReference: DatabaseReference!
    
    let currentUserID = Auth.auth().currentUser?.uid
    let currentUserEmail = Auth.auth().currentUser?.email
    let currentUserName = Auth.auth().currentUser?.displayName
    
    @IBOutlet var writeButton: UIButton!
    @IBOutlet var inboxButton: UIButton!
    
    @IBOutlet var currentUserNameLabel: UILabel!
    @IBOutlet var currentUserEmailLabel: UILabel!
    @IBOutlet var currentUserIDLabel: UILabel!
    
    let backgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = backgroundColor
        
        print("Home")
        
        print(currentUserName!)
        print(currentUserEmail!)
        print(currentUserID!)
        
        databaseReference = Database.database().reference()
        
        currentUserNameLabel.text = "userName: \(currentUserName ?? "")"
        currentUserEmailLabel.text = "userEmail: \(currentUserEmail ?? "")"
        currentUserIDLabel.text = "userID: \(currentUserID ?? "")"
        
        currentUserNameLabel.isHidden = true
        currentUserEmailLabel.isHidden = true
        currentUserIDLabel.isHidden = true
        
    }
    
    @IBAction func writeButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let writeViewController = storyboard.instantiateViewController(identifier: "WriteViewController")
        writeViewController.modalPresentationStyle = .fullScreen
        writeViewController.modalTransitionStyle = .crossDissolve
        self.present(writeViewController, animated: true, completion: nil)
    }
    
    @IBAction func inboxButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let inboxViewController = storyboard.instantiateViewController(identifier: "InboxViewController")
        inboxViewController.modalPresentationStyle = .fullScreen
        inboxViewController.modalTransitionStyle = .crossDissolve
        self.present(inboxViewController, animated: true, completion: nil)
    }
    
    @IBAction func userIDButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = "\(currentUserID ?? "")"
        HUD.flash(.label("Copied ID to clipboard"), delay: 0.5)
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
