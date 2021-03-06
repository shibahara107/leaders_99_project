//
//  SignUpViewController.swift
//  leaders_99_project
//
//  Created by Yoshinori Shibahara on 2020/05/20.
//  Copyright © 2020 Yoshinori Shibahara. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import PKHUD

class SignUpViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    
    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var backgroundImageView: UIImageView!
    
    let backgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.overrideUserInterfaceStyle = .light
//        view.backgroundColor = backgroundColor
        
        backgroundImageView.image = UIImage(named: delegate.backgroundImageString)
        
        print("Sign Up")
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        passTextField.isSecureTextEntry = true
        
        self.hideKeyboardWhenTappedAround()
        
//        let namePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.nameTextField.frame.height))
//        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.emailTextField.frame.height))
//        let passPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.passTextField.frame.height))
//
//        nameTextField.layer.borderWidth = 0.3
//        nameTextField.layer.cornerRadius = 20.0
//        nameTextField.leftView = namePaddingView
//        nameTextField.leftViewMode = UITextField.ViewMode.always
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
    
    @IBAction func pushSignUpButton(_ sender: Any) {
        if let name = nameTextField.text,
            let email = emailTextField.text,
            let password = passTextField.text {
            if name.isEmpty {
                print("name is empty")
                nameTextField.layer.borderColor = UIColor.red.cgColor
                return
            }
            if email.isEmpty {
                print("email is empty")
                emailTextField.layer.borderColor = UIColor.red.cgColor
                return
            }
            if password.isEmpty {
                print("password is empty")
                passTextField.layer.borderColor = UIColor.red.cgColor
                return
            }
            nameTextField.layer.borderColor = UIColor.black.cgColor
            emailTextField.layer.borderColor = UIColor.black.cgColor
            passTextField.layer.borderColor = UIColor.black.cgColor
            
            //ユーザー作成
            Auth.auth().createUser(withEmail: email, password: password) {
                user, error in
                if let error = error {
                    print("error")
                    print(error)
                    return
                }
                //ユーザーネームを設定
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = name
                    changeRequest.commitChanges() {
                        error in
                        if let error = error {
                            
                            HUD.flash(.labeledError(title: "Error", subtitle: "Try again"), delay: 1.0)
                            print("error")
                            print(error)
                            return
                        }
                        
                        HUD.flash(.labeledSuccess(title: "Success", subtitle: "Welcome"), delay: 1.0)
                        print("success")
                        let currentUserID = Auth.auth().currentUser?.uid
                        let currentUserEmail = Auth.auth().currentUser?.email
                        print("Signed Up")
                        print(currentUserEmail!)
                        print(currentUserID!)
                        
                        let when = DispatchTime.now()
                        DispatchQueue.main.asyncAfter(deadline: when + 2.0) {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let viewController = storyboard.instantiateViewController(identifier: "HomeViewController")
                            
                            viewController.modalPresentationStyle = .fullScreen
                            viewController.modalTransitionStyle = .crossDissolve
                            self.present(viewController, animated: true, completion: nil)
                        }
                    }
                } else {
                    print("Error: could not sign up")
                }
            }
            
        }
    }
    
    @IBAction func pushCloseButton(_ sender: Any) {
        print("Already have an account")
        self.dismiss(animated: true, completion: nil)
    }
    
}
