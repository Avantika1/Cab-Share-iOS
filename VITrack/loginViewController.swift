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


class loginViewController: UIViewController{
    
 /*   struct MyProfileRequest: GraphRequestProtocol {
        struct Response: GraphResponseProtocol {
            init(rawResponse: Any?) {
                // Decode JSON from rawResponse into other properties here.
            }
        }
        
        var graphPath = "/me"
        var parameters: [String : Any]? = ["fields": "id, name"]
        var accessToken = AccessToken.current
        var httpMethod: GraphRequestHTTPMethod = .GET
        var apiVersion: GraphAPIVersion = .defaultVersion
    }*/
    
    @IBAction func fbLogin(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn([ ReadPermission.publicProfile ], viewController: self) { result in
            self.loginManagerDidComplete(result)
        }
    }
    
    func loginManagerDidComplete(_ result: LoginResult) {
        print(1111111)
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
                        
                        print(responseDictionary["name"])
                        print(responseDictionary["email"])
                        
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RevealViewController") as UIViewController
                        self.present(viewController, animated: false, completion: nil)
                        
                    }
                }
            }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
