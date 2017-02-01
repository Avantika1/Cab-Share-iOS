//
//  fourthOptionMenuViewController.swift
//  VITrack
//
//  Created by Avantika Bhatia on 23/01/17.
//  Copyright © 2017 avantika. All rights reserved.
//

import UIKit

class fourthOptionMenuViewController: UIViewController, UITextFieldDelegate{
@IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var nametf: UITextField!
    @IBOutlet weak var phonetf: UITextField!
    @IBOutlet weak var pickUptf: UITextField!
    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var numberOfTravellerstf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nametf.delegate = self
        phonetf.delegate = self
        pickUptf.delegate = self
        emailtf.delegate = self
        numberOfTravellerstf.delegate = self
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
