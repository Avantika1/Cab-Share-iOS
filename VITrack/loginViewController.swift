//
//  loginViewController.swift
//  VITrack
//
//  Created by Avantika Bhatia on 31/01/17.
//  Copyright © 2017 avantika. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin
import FacebookCore


class loginViewController: UIViewController, GIDSignInUIDelegate {
    
    //var user : UserDetails!
    var name : String!
    
    @IBAction func skipLogin(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RevealViewController") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }

 
    @IBAction func fbLogin(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn([ ReadPermission.publicProfile ], viewController: self) { result in
            self.loginManagerDidComplete(result)
        }
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        //myActivityIndicator.stopAnimating()
    }
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func loginManagerDidComplete(_ result: LoginResult) {
        switch result {
        case .cancelled:
            print(123)
        case .failed(let error):
            print(error)
        case .success(let grantedPermissions, _, _):
            let params = ["fields" : "first_name,last_name,email,name,gender,picture.type(normal)"]
            let graphRequest = GraphRequest(graphPath: "me", parameters: params)
            graphRequest.start {
                (urlResponse, requestResult) in
                
                switch requestResult {
                case .failed(let error):
                    print("error in graph request:", error)
                    break
                case .success(let graphResponse):
                    if let responseDictionary = graphResponse.dictionaryValue {
                        print(responseDictionary)
                        self.name = responseDictionary["name"] as! String!
                        print(self.name)
                       //print(responseDictionary["name"])
                       // print(responseDictionary["email"])
                        let vc : SWRevealViewController = self.storyboard?.instantiateViewController(withIdentifier: "RevealViewController") as! SWRevealViewController
                       // let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RevealViewController") as UIViewController
                        self.present(vc, animated: false, completion: nil)
                    
                    }
                }
            }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         GIDSignIn.sharedInstance().uiDelegate = self
        if let accessToken = AccessToken.current {
            // User is logged in, use 'accessToken' here.
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RevealViewController") as UIViewController
            
            
            self.present(viewController, animated: false, completion: nil)
        }
        
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
