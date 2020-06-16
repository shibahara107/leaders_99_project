//
//  MessageViewController.swift
//  leaders_99_project
//
//  Created by Yoshinori Shibahara on 2020/05/31.
//  Copyright © 2020 Yoshinori Shibahara. All rights reserved.
//

import UIKit
import PKHUD

class MessageViewController: UIViewController {
    
    var messageContent: String!
    var fromName: String!
    var fromID: String!
    var toName: String!
    
    @IBOutlet var messageContentView: UITextView!
    @IBOutlet var fromNameLabel: UILabel!
    @IBOutlet var fromIDLabel: UILabel!
    @IBOutlet var toNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.overrideUserInterfaceStyle = .light
        
        messageContentView.text = messageContent
        fromNameLabel.text = fromName
        toNameLabel.text = toName
        fromIDLabel.text = fromID
        
        fromIDLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MessageViewController.fromIDLabelTapped(_sender:)))
        fromIDLabel.addGestureRecognizer(tapGesture)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func fromIDLabelTapped(_sender: UIGestureRecognizer) {
        print("fromIDLabel tapped")
        UIPasteboard.general.string = "\(fromID ?? "")"
        HUD.flash(.label("Copied ID to clipboard"), delay: 0.5)
    }
    
    @IBAction func pushCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
