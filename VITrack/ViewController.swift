//
//  ViewController.swift
//  VITrack
//
//  Created by Avantika Bhatia on 24/07/16.
//  Copyright © 2016 avantika. All rights reserved.
//

import UIKit
import MapKit
import MessageUI

class ViewController: UIViewController , UITextFieldDelegate , MKMapViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBOutlet weak var menuButton: UIBarButtonItem!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var destinationButton: UIButton!
    @IBOutlet weak var sourceButton: UIButton!
    @IBOutlet weak var dateTimeButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet var homeView: UIView!
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var myCustomView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    var check : String!
    var polyLine : MKPolyline!
    var annotation1 : MKAnnotation!
    var annotation2 : MKAnnotation!
    var barButton : UIBarButtonItem!
    
    
    var location : locationDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
       self.homeView.frame = CGRect(x: 0 , y: 0, width: self.mainView.frame.width, height: self.mainView.frame.height)
        self.myCustomView.isHidden = true
        self.mainView.addSubview(self.homeView)
        self.emailTextField.delegate = self
        self.mapView.delegate = self
 
        barButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(addTrack))
         self.navigationItem.rightBarButtonItem = barButton
        barButton.isEnabled = false
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTrack(_ sender : UIBarButtonItem)
    {
        
        sourceButton.titleLabel!.text = "Source"
        destinationButton.titleLabel!.text = "Destination"
        sourceButton.isHidden = false
        destinationButton.isHidden = false
        dateTimeButton.isHidden = false
        emailTextField.isHidden = false
        confirmButton.isHidden = false
       mapView.frame =  CGRect(x: 0 , y: 0, width: self.mainView.frame.width, height: 210)
        mapView.removeAnnotation(annotation1)
        mapView.removeAnnotation(annotation2)
        mapView.remove(polyLine)
        barButton.isEnabled = false
        
    }

    @IBAction func showDateTime(_ sender: AnyObject) {
        
      myCustomView.isHidden = false
    
    }
  
    @IBAction func selectDate(_ sender: AnyObject) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.string(from: datePicker.date)
        dateTimeButton.setTitle(strDate, for: UIControlState())
        
    }

    @IBAction func doneButtonClicked(_ sender: AnyObject) {
        myCustomView.isHidden = true
    }
    @IBAction func showSource(_ sender: AnyObject) {
        
        if let anno = annotation1 {
            mapView.removeAnnotation(anno)}
        
        
        let optionMenu = UIAlertController(title: "Source", message: "Choose Option", preferredStyle: .actionSheet)
        
        
        let option1 = UIAlertAction(title: "Chennai", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
         self.sourceButton.setTitle("Chennai", for: UIControlState())
            self.check = "Chennai"
              self.annotation1 = self.getMapAnnotations(0)
            self.mapView.addAnnotation(self.annotation1)
        })
        let option2 = UIAlertAction(title: "Bangalore", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
         self.sourceButton.setTitle("Bangalore", for: UIControlState())
            self.check = "Bangalore"
            self.annotation1 = self.getMapAnnotations(0)
            self.mapView.addAnnotation(self.annotation1)
        })
        let option3 = UIAlertAction(title: "VIT", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
             self.sourceButton.setTitle("VIT", for: UIControlState())
            self.check = "VIT"
            self.annotation1 = self.getMapAnnotations(0)
            self.mapView.addAnnotation(self.annotation1)
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            if let anno = self.annotation1 {
            self.mapView.addAnnotation(anno)
            }
    
        })
        
        
        optionMenu.addAction(option1)
        optionMenu.addAction(option2)
        optionMenu.addAction(option3)
        optionMenu.addAction(cancelAction)
        
      
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    

   
    @IBAction func showDestination(_ sender: AnyObject) {
        
        if let anno = annotation2 {
            mapView.removeAnnotation(anno)}
        
        let optionMenu = UIAlertController(title: "Destination", message: "Choose Option", preferredStyle: .actionSheet)
        
        
        let option1 = UIAlertAction(title: "Chennai", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.destinationButton.setTitle("Chennai", for: UIControlState())
            self.check = "Chennai"
            self.annotation2 = self.getMapAnnotations(0)
            self.mapView.addAnnotation(self.annotation2)
        })
        let option2 = UIAlertAction(title: "Bangalore", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.destinationButton.setTitle("Bangalore", for: UIControlState())
            self.check = "Bangalore"
            self.annotation2 = self.getMapAnnotations(0)
            self.mapView.addAnnotation(self.annotation2)
        })
        let option3 = UIAlertAction(title: "VIT", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.destinationButton.setTitle("VIT", for: UIControlState())
            self.check = "VIT"
            self.annotation2 = self.getMapAnnotations(0)
            self.mapView.addAnnotation(self.annotation2)
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
            if let anno = self.annotation2 {
                self.mapView.addAnnotation(anno)
            }

        })
        
        if sourceButton.titleLabel!.text != "Chennai" {
        optionMenu.addAction(option1)
        }
        if sourceButton.titleLabel!.text != "Bangalore"{
            optionMenu.addAction(option2)}
        if sourceButton.titleLabel!.text != "VIT"{
        optionMenu.addAction(option3)
        }
        optionMenu.addAction(cancelAction)
        
        
        self.present(optionMenu, animated: true, completion: nil)

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.homeView.endEditing(true)
        return false
    }
    
    
    func getMapAnnotations(_ flag : Int) -> locationDetails {
       
        var points: NSArray?
        if let path = Bundle.main.path(forResource: "locations", ofType: "plist") {
            points = NSArray(contentsOfFile: path)
        }
        
        if let items = points {
            
            for index in 0...items.count-1
            {
                if flag == 0 && self.check == (items[index] as AnyObject).value(forKey: "title") as? String{
                let lattitude = (items[index] as AnyObject).value(forKey: "lat") as! Double
                let longitude = (items[index] as AnyObject).value(forKey: "long")as! Double
                location = locationDetails(latitude: lattitude, longitude: longitude)
                    location.title = (items[index] as AnyObject).value(forKey: "title") as? String}
                
                if flag == 1 && self.check == (items[index] as AnyObject).value(forKey: "title") as? String{
                    let lattitude = (items[index] as AnyObject).value(forKey: "lat") as! Double
                    let longitude = (items[index] as AnyObject).value(forKey: "long")as! Double
                    location = locationDetails(latitude: lattitude, longitude: longitude)
                    location.title = (items[index] as AnyObject).value(forKey: "title") as? String}
                
                
            }
            
        }
        return location
    }
    
    

    
    @IBAction func confirmPressed(_ sender: AnyObject) {
        
        if(sourceButton.titleLabel!.text == destinationButton.titleLabel!.text)
            
        {
            
            let alertController = UIAlertController(title: "Alert", message: "Source and Destination must not be the same", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else
        {
            //zoomToRegion()

            mapView.frame =  CGRect(x: 0 , y: 0, width: self.mainView.frame.width, height: self.mainView.frame.height)
            sourceButton.isHidden = true
            destinationButton.isHidden = true
            dateTimeButton.isHidden = true
            emailTextField.isHidden = true
            confirmButton.isHidden = true
            check = sourceButton.titleLabel!.text
            let sourceAnnotation = getMapAnnotations(0)
            check = destinationButton.titleLabel!.text
            let destinationAnnotation = getMapAnnotations(1)
            var pointsCoordinates: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
            pointsCoordinates.append(sourceAnnotation.coordinate)
            pointsCoordinates.append(destinationAnnotation.coordinate)
            
            polyLine = MKPolyline(coordinates: &pointsCoordinates, count: pointsCoordinates.count)
            mapView.add(polyLine)
            barButton.isEnabled = true
        }
    }
    
    func mapView(_ mapView: MKMapView!, rendererFor overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.black
            polylineRenderer.lineWidth = 2
            return polylineRenderer
        }
        
        return nil
    }

}

// MARK:- Table view Delegate and datasource methods

/*extension ViewController : UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
     {
         let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! trackDetails
        
        return cell
    }
    
   func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }

    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["avantikabhatia1@gmail.com"])
        mailComposerVC.setSubject("Request to share a track")
        mailComposerVC.setMessageBody("The details of my travel are as follows:", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
}*/


