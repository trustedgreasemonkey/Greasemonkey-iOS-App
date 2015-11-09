//
//  LoginViewController.swift
//  In-Due-Time
//
//  Created by david on 11/4/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate
{
    let validator = Validator()
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var imgHasBeenAnimated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PFUser.currentUser() != nil
        {
            let user = PFUser.currentUser()
            let username = String(user).componentsSeparatedByString("=")[1]
            let formatted1 = username.componentsSeparatedByString(";")[0]
            let formatted2 = formatted1.componentsSeparatedByString("\"")[1]
            print(formatted2)
            
            usernameTextField.text = formatted2
        }

        if imgHasBeenAnimated == false
        {
            animate()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        if usernameTextField.text! == ""
        {
            usernameTextField.becomeFirstResponder()
        }
        else if passwordTextField.text! == ""
        {
            passwordTextField.becomeFirstResponder()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userCanSignIn() -> Bool
    {
        var rc = false
        let username = usernameTextField.text!
        if passwordTextField.text != "" && validator.isValidEmail(username)
        {
            rc = true
        }
        if validator.isValidEmail(username) == false
        {
            usernameTextField.text = ""
            usernameTextField.placeholder = "Please enter a valid email"
            rc = false
        }
        
        return rc
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        var rc = false
        if usernameTextField.text != ""
        {
            rc = true
            usernameTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        if usernameTextField.text != "" && passwordTextField.text != ""
        {
            login()
            rc = true
        }
        
        return rc
    }
    
    @IBAction func loginTapped(sender: UIButton)
    {
        login()
    }
    
    func login()
    {
        let password = passwordTextField.text!
        let username = usernameTextField.text!
        
        PFUser.logInWithUsernameInBackground(username, password: password)
            {
                (user: PFUser?, error: NSError?) -> Void in
                if error == nil
                {
                    print("login successful")
//                    self.navigationController?.performSegueWithIdentifier("ShowLandingSegue", sender: self)
                    self.performSegueWithIdentifier("unwindSegue", sender: self)
                }
                else
                {
                    print(error?.localizedDescription)
                    self.passwordTextField.text = ""
                    self.passwordTextField.placeholder = "Invalid password"
                }
        }
    }
    
    func animate()
    {
        UIView.animateWithDuration(0.5, delay: 0.0, options: [], animations:
            {
                var img = self.logoImage.frame
                img.origin.x += 600
                
                self.logoImage.frame = img
            }, completion: nil)
    }
}
