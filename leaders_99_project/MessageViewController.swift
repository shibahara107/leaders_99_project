//
//  MessageViewController.swift
//  leaders_99_project
//
//  Created by Yoshinori Shibahara on 2020/05/31.
//  Copyright © 2020 Yoshinori Shibahara. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    var messageContent: String!
    var fromName: String!
    var toName: String!
    
    @IBOutlet var messageContentLabel: UILabel!
    @IBOutlet var fromNameLabel: UILabel!
    @IBOutlet var toNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        messageContentLabel.text = messageContent
        fromNameLabel.text = fromName
        toNameLabel.text = toName
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func pushCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
