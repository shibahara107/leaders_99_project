//
//  LogInViewController.swift
//  leaders_99_project
//
//  Created by Yoshinori Shibahara on 2020/05/20.
//  Copyright © 2020 Yoshinori Shibahara. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuth
import PKHUD

class LogInViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    
    let backgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
        self.overrideUserInterfaceStyle = .light
//        view.backgroundColor = backgroundColor
        
        print("Log In")
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
//        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.emailTextField.frame.height))
//        let passPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.passTextField.frame.height))
//
//        emailTextField.layer.borderWidth = 0.3
//        emailTextField.layer.cornerRadius = 20.0
//        emailTextField.leftView = emailPaddingView
//        emailTextField.leftViewMode = UITextField.ViewMode.always
//
//        passTextField.layer.borderWidth = 0.3
//        passTextField.layer.cornerRadius = 20.0
//        passTextField.leftView = passPaddingView
//        passTextField.leftViewMode = UITextField.ViewMode.always
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func pushLogInButton(_ sender: Any) {
        if let email = emailTextField.text,
            let password = passTextField.text {
            if email.isEmpty {
                emailTextField.layer.borderColor = UIColor.red.cgColor
                return
            }
            if password.isEmpty {
                passTextField.layer.borderColor = UIColor.red.cgColor
                return
            }
            emailTextField.layer.borderColor = UIColor.black.cgColor
            passTextField.layer.borderColor = UIColor.black.cgColor
            
            //ログイン
            Auth.auth().signIn(withEmail: email, password:  password) {
                user, error in
                if let error = error {
                    HUD.flash(.labeledError(title: "Error", subtitle: "Try again"), delay: 1.0)
                    print(error)
                    return
                } else {
                    HUD.flash(.labeledSuccess(title: "Success", subtitle: "Welcome"), delay: 1.0)
                    print("success")
                    let currentUserID = Auth.auth().currentUser?.uid
                    let currentUserEmail = Auth.auth().currentUser?.email
                    print("Logged In")
                    print(currentUserEmail!)
                    print(currentUserID!)
                    
                    let when = DispatchTime.now()
                    DispatchQueue.main.asyncAfter(deadline: when + 2.0) {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = storyboard.instantiateViewController(identifier: "HomeViewController")
                        
                        viewController.modalPresentationStyle = .fullScreen
                        viewController.modalTransitionStyle = .crossDissolve
                        self.present(viewController, animated: true, completion: nil)
                        
//                        self.present((self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController), animated: true, completion: nil)
                    }
                    
                }
            }
        }
    }
    
    @IBAction func pushCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
