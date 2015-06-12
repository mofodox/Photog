//
//  AuthViewController.swift
//  Photog
//
//  Created by Khairul Akmal on 11/06/2015.
//  Copyright (c) 2015 Khairul Akmal. All rights reserved.
//

import UIKit

enum AuthMode {
    case SignIn
    case SignUp
}

class AuthViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Variables
    
    var authMode: AuthMode = AuthMode.SignUp
    
    @IBOutlet var emailTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // This will push UI to the bottom edge of the navigation bar
        self.edgesForExtendedLayout = UIRectEdge.None
        
        var emailImageView = UIImageView(frame: CGRectMake(0, 0, 50, self.emailTextField!.frame.size.height))
        emailImageView.image = UIImage(named: "EmailIcon")
        emailImageView.contentMode = .Center
        
        self.emailTextField!.leftView = emailImageView
        self.emailTextField!.leftViewMode = .Always
        
        var passwordImageView = UIImageView(frame: CGRectMake(0, 0, 50, self.passwordTextField!.frame.size.height))
        passwordImageView.image = UIImage(named: "PasswordIcon")
        passwordImageView.contentMode = .Center
        
        self.passwordTextField!.leftView = passwordImageView
        self.passwordTextField!.leftViewMode = .Always
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.emailTextField?.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.emailTextField?.resignFirstResponder()
            self.passwordTextField?.becomeFirstResponder()
        }else if textField == self.passwordTextField {
            self.passwordTextField?.resignFirstResponder()
            self.authenticate()
        }
        
        return true
    }
    
    // MARK: Helper Methods
    
    func authenticate() {
        var email = self.emailTextField?.text
        var password = self.passwordTextField?.text
        
        if email?.isEmpty == true || password?.isEmpty == true || email?.isEmailAddress() == false {
            // alert the user
            self.showAlert(titleForAlert: "Oops!", messageForAlert: "Please check your email address and password!")
            
            return
        }
        
        if authMode == .SignIn {
            self.signIn(email: email!, password: password!)
        } else {
            self.signUp(email: email!, password: password!)
        }
    }
    
    func signIn(#email: String, password: String) {
        PFUser.logInWithUsernameInBackground(email, password: password) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                var tabBarController = TabBarController()
                self.navigationController?.pushViewController(tabBarController, animated: true)
                
                println("Sign in success!")
                println("Sign in as \(PFUser.currentUser()?.username)")
            } else {
                self.showAlert(titleForAlert: "Log in failed", messageForAlert: error!.localizedDescription)
                println("Log in failure! (alert the user)")
            }
        }
    }
    
    func signUp(#email: String, password: String) {
        // Create a new PFUser
        var user = PFUser()
        user.username = email
        user.email = email
        user.password = password
        
        user.signUpInBackgroundWithBlock { (succeeded: Bool, error: NSError?) -> Void in
            if error == nil {
                // New user follows him/herself
                self.follow(user, completionHandler: { (error: NSError?) -> () in
                    if error == nil {
                        var tabBarController = TabBarController()
                        self.navigationController?.pushViewController(tabBarController, animated: true)
                    }else {
                        println("Unable for user to follow themself")
                    }
                })
            } else {
                self.showAlert(titleForAlert: "Sign up failed", messageForAlert: error!.localizedDescription)
            }
        }
    }
    
    func follow(user: PFUser!, completionHandler:(error: NSError?) -> Void) {
        var relation = PFUser.currentUser()?.relationForKey("following")
        relation?.addObject(user)
        PFUser.currentUser()?.saveInBackgroundWithBlock({ (success, error) -> Void in
            completionHandler(error: error)
        })
    }
}
