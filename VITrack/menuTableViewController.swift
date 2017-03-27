//
//  menuTableViewController.swift
//  VITrack
//
//  Created by Avantika Bhatia on 19/09/16.
//  Copyright © 2016 avantika. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore


class menuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

}
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 1{
            
            GIDSignIn.sharedInstance().signOut()
                let loginManager = LoginManager()
                loginManager.logOut()
           // self.dismiss(animated: true, completion: nil)
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginViewController") as UIViewController
            self.present(viewController, animated: false, completion: nil)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
