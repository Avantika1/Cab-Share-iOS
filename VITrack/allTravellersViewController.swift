//
//  allTravellersViewController.swift
//  VITrack
//
//  Created by Avantika Bhatia on 31/01/17.
//  Copyright © 2017 avantika. All rights reserved.
//

import UIKit

class allTravellersViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var dateTimeLabel: UIButton!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet var sameDateTableView: UITableView!
    @IBOutlet var homeView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var myCustomView: UIView!
    @IBOutlet var allTravellersTableView: UITableView!
    @IBOutlet var sameFlightTableView: UITableView!
    var check: String!
    var selectedDate : String!
    var flag: Int = 0
    
    var from : [String] = ["VIT","VIT","Chennai"]
    var to : [String] = ["Chennai","Bangalore","VIT"]
    var date: [String] = ["01-01-2017","02-01-2017","03-01-2017"]
    var PNR : [String] = ["123","NA","456"]
    
    var fromCopy: [String] = []
     var toCopy: [String] = []
     var dateCopy: [String] = []
    
    var myDate : String = "02-01-2017"
    var myPNR : String = "123"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.myCustomView.isHidden = true
        self.segmentedControl.selectedSegmentIndex = 1
        self.homeView.frame = CGRect(x: 0 , y: 0, width: self.mainView.frame.width, height: self.mainView.frame.height)
        self.mainView.addSubview(self.homeView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentedControl(_ sender: Any) {
        
        if (sender as AnyObject).selectedSegmentIndex == 1{
           
            UIView.animate(withDuration: 0.5, animations: {
                self.homeView.frame = CGRect(x:0 , y:0, width: self.mainView.frame.width, height: self.mainView.frame.height)
                self.homeView.isHidden = false
                self.sameDateTableView.isHidden = true
                self.sameFlightTableView.isHidden = true
                self.mainView.addSubview(self.homeView)
            })
            
        }
        else
             if (sender as AnyObject).selectedSegmentIndex == 0
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.sameDateTableView.frame = CGRect(x:0 , y:0, width: self.mainView.frame.width, height:self.mainView.frame.height)
             self.homeView.isHidden = true
             self.sameDateTableView.isHidden = false
             self.sameFlightTableView.isHidden = true
             self.mainView.addSubview(self.sameDateTableView)
                self.showSameDate()
             })
            
        }
             else
                if (sender as AnyObject).selectedSegmentIndex == 2
                {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.sameFlightTableView.frame = CGRect(x:0 , y:0, width: self.mainView.frame.width, height:self.mainView.frame.height)
                        self.homeView.isHidden = true
                        self.sameDateTableView.isHidden = true
                        self.sameFlightTableView.isHidden = false
                        self.mainView.addSubview(self.sameFlightTableView)
                        self.showSamePNR()
                    })
                    
        }


    }
    
    func showSameDate()
    {
        dateCopy = []
        fromCopy = []
        toCopy = []
        for i in 0...self.date.count-1
        {
            if(self.date[i] == myDate)
            {
                dateCopy.append(self.date[i])
                fromCopy.append(self.from[i])
                toCopy.append(self.to[i])
            }
        }
        
    }
    func showSamePNR()
    {
        dateCopy = []
        fromCopy = []
        toCopy = []
        for i in 0...self.from.count-1
        {
            if(self.PNR[i] == self.myPNR)
            {
                dateCopy.append(self.date[i])
                fromCopy.append(self.from[i])
                toCopy.append(self.to[i])
            }
        }
        
    }
    
    func showSpecificDateTimeLocation()
    {
        dateCopy = []
        fromCopy = []
        toCopy = []
       
        
    }
    
    @IBAction func selectDateTimePressed(_ sender: Any) {
        
       self.myCustomView.isHidden = false
    }
    @IBAction func datePickerPressed(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.string(from: datePicker.date)
        let index = strDate.index(strDate.startIndex, offsetBy: 10)
        selectedDate = strDate.substring(to: index)
        dateTimeLabel.setTitle(strDate, for: UIControlState())

    }
        @IBAction func doneButtonPressed(_ sender: Any) {
            self.myCustomView.isHidden = true
    }

    
    
    @IBAction func fromPressed(_ sender: Any) {
        
        let optionMenu = UIAlertController(title: "Source", message: "Choose Option", preferredStyle: .actionSheet)
        
        
        let option1 = UIAlertAction(title: "Chennai", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.fromButton.setTitle("Chennai", for: UIControlState())
            self.check = "Chennai"
           
        })
        let option2 = UIAlertAction(title: "Bangalore", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.fromButton.setTitle("Bangalore", for: UIControlState())
            self.check = "Bangalore"
           
        })
        let option3 = UIAlertAction(title: "VIT", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.fromButton.setTitle("VIT", for: UIControlState())
            self.check = "VIT"
           
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
           
            
        })
        
        
        optionMenu.addAction(option1)
        optionMenu.addAction(option2)
        optionMenu.addAction(option3)
        optionMenu.addAction(cancelAction)
        
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func toPressed(_ sender: Any) {
        let optionMenu = UIAlertController(title: "Destination", message: "Choose Option", preferredStyle: .actionSheet)
        
        
        let option1 = UIAlertAction(title: "Chennai", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.toButton.setTitle("Chennai", for: UIControlState())
            self.check = "Chennai"
                   })
        let option2 = UIAlertAction(title: "Bangalore", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.toButton.setTitle("Bangalore", for: UIControlState())
            self.check = "Bangalore"
                   })
        let option3 = UIAlertAction(title: "VIT", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.toButton.setTitle("VIT", for: UIControlState())
            self.check = "VIT"
           
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        if fromButton.titleLabel!.text != "Chennai" {
            optionMenu.addAction(option1)
        }
        if fromButton.titleLabel!.text != "Bangalore"{
            optionMenu.addAction(option2)}
        if fromButton.titleLabel!.text != "VIT"{
            optionMenu.addAction(option3)
        }
        optionMenu.addAction(cancelAction)
        
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        
        dateCopy = []
        fromCopy = []
        toCopy = []
       
        for i in 0...self.from.count-1
        {
            if(selectedDate == self.date[i] && toButton.titleLabel?.text == self.from[i] && fromButton.titleLabel?.text == self.to[i])
            {
                dateCopy.append(self.date[i])
                fromCopy.append(self.from[i])
                toCopy.append(self.to[i])
            }
        }
         flag = 1
        allTravellersTableView.reloadData()
        
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        
        dateCopy = date
        toCopy = to
        fromCopy = from
        flag = 0
        allTravellersTableView.reloadData()
        fromButton.titleLabel?.text = "From"
        toButton.titleLabel?.text = "To"
        dateTimeLabel.titleLabel?.text = "Select Date and Time"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension allTravellersViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == sameDateTableView || tableView == sameFlightTableView || flag == 1)
        {
            return fromCopy.count
        }
        else
        {
            return from.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == self.sameDateTableView || tableView == self.sameFlightTableView || flag == 1{
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelcell", for: indexPath) as! trackDetails
            
            cell.fromLabel.text = fromCopy[indexPath.row]
            cell.toLabel.text = toCopy[indexPath.row]
            cell.dateLabel.text = dateCopy[indexPath.row]
        
        
        return cell
        }
    
        else
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "travelcell", for: indexPath) as! trackDetails
            
            cell.fromLabel.text = from[indexPath.row]
            cell.toLabel.text = to[indexPath.row]
            cell.dateLabel.text = date[indexPath.row]
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 200
    }


    
}
