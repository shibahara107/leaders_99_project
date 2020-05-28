//
//  CustomTableViewCell.swift
//  leaders_99_project
//
//  Created by Yoshinori Shibahara on 2020/05/28.
//  Copyright © 2020 Yoshinori Shibahara. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CustomTableViewCell: UITableViewCell {
    
    var databaseRefrence: DatabaseReference!
    
    let currentUserID = Auth.auth().currentUser?.uid
    let currentUserEmail = Auth.auth().currentUser?.email
    let currentUserName = Auth.auth().currentUser?.displayName
    
    @IBOutlet var toNameLabel: UILabel!
    @IBOutlet var fromNameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var sentDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        databaseRefrence = Database.database().reference()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
