//
//  TableViewController.swift
//  leaders_99_project
//
//  Created by Yoshinori Shibahara on 2020/05/23.
//  Copyright © 2020 Yoshinori Shibahara. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TableViewController: UITableViewController {
    
    var databaseReference: DatabaseReference!
    
    let currentUserID = Auth.auth().currentUser?.uid
    let currentUserEmail = Auth.auth().currentUser?.email
    let currentUserName = Auth.auth().currentUser?.displayName
    
    var messageArray = [Any]()
    
    let date: Date = Date()
    let dateFormatter = DateFormatter()
    var currentDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        
        print("TableView")
        print(currentUserName!)
        print(currentUserEmail!)
        print(currentUserID!)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        databaseReference = Database.database().reference()
        
        if Auth.auth().currentUser != nil {
            databaseReference.observe(.childAdded, with: { snapshot in
                if let obj = snapshot.value as? [String: AnyObject],let toID = obj["toID"] as? String, let name = obj["name"] as? String, let message = obj["message"] {
                    if toID == self.currentUserID {
                        let messageContent = snapshot.value as! [String: AnyObject]
                        print(messageContent)
                        self.messageArray.insert(messageContent, at: 0)
                        print(self.messageArray.count)
                        print(self.messageArray)
                        self.tableView.reloadData()
                    }
                }
            })
        }
        
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        self.tableView.register(UINib(nibName: "SecondCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondCustom")
        
        tableView.reloadData()
        
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        currentDate = dateFormatter.string(from: date)
        
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        let messageContent = messageArray[indexPath.row] as! [String: AnyObject]
        
        //        let sentDate = messageContent["sentDate"] as? String
        //
        //        print("sentDate:", sentDate)
        //
        //        if sentDate != nil {
        //            if Int(currentDate)! - Int(sentDate!)! >= 2 {
        //                print("time interval:", Int(currentDate)! - Int(sentDate!)!)
        //                print("should be hidden:", indexPath)
        //
        //                let cell2 = tableView.dequeueReusableCell(withIdentifier: "SecondCustom", for: indexPath) as! SecondCustomTableViewCell
        //
        //                return cell2
        //            }
        //        }
        
        cell.messageLabel.text = messageContent["message"] as? String
        
        let fromName = messageContent["name"] as? String
        cell.fromNameLabel.text = (fromName ?? "")
        
        let toName = messageContent["toName"] as? String
        cell.toNameLabel.text = (toName ?? "")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let messageContent = messageArray[indexPath.row] as! [String: AnyObject]
        let sentDate = messageContent["sentDate"] as? String
        
        if sentDate != nil {
            if Int(currentDate)! - Int(sentDate!)! <= 20000 {
                return 0
            } else {
                return 100
            }
        }
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell at: ", indexPath.row)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let messageViewController = storyboard.instantiateViewController(identifier: "MessageViewController") as! MessageViewController
        
        let messageContent = messageArray[indexPath.row] as! [String: AnyObject]
        let message = messageContent["message"] as? String
        let fromName = messageContent["name"] as? String
        let fromID = messageContent["fromID"] as? String
        let toName = messageContent["toName"] as? String
        
        messageViewController.messageContent = message
        messageViewController.fromName = fromName
        messageViewController.fromID = fromID
        messageViewController.toName = toName
        
        print(messageArray[indexPath.row] as! [String: AnyObject])
        
        messageViewController.modalPresentationStyle = .fullScreen
        messageViewController.modalTransitionStyle = .crossDissolve
        self.present(messageViewController, animated: true, completion: nil)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
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
