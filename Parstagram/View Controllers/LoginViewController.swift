//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Shengyuan Lu on 2/7/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "toFeedScreen", sender: nil)
            } else {
                print("ERROR: Invlid username or password")
            }
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        let user = PFUser()
        
        user.username = usernameField.text ?? ""
        user.password = passwordField.text ?? ""
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "toFeedScreen", sender: nil)
            } else {
                print("ERROR: \(error?.localizedDescription ?? "Unknown Error")")
            }
        }
        
    }

}
