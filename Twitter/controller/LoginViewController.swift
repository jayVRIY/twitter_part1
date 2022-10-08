//
//  LoginViewController.swift
//  Twitter
//
//  Created by Jay on 2022/10/1.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userIsLogin"){
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    @IBAction func onLoginButton(_ sender: Any) { 
        let myUrl = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myUrl, success: {
            UserDefaults.standard.set(true, forKey: "userIsLogin")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { Error in
            print(Error)
        })
    }
    
}
//
