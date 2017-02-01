//
//  secondOptionViewController.swift
//  VITrack
//
//  Created by Avantika Bhatia on 20/09/16.
//  Copyright © 2016 avantika. All rights reserved.
//

import UIKit

class secondOptionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate  {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var selectFilterButton: UIButton!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var mySwitch: UISwitch!
  
    var from : [String] = ["VIT","VIT","Chennai"]
    var to : [String] = ["Chennai","Bangalore","VIT"]
    var date: [String] = ["01-01-17","02-01-17","03-01-17"]
    
    var fromCopy : [String]=[]
    var toCopy : [String] = []
    var dateCopy : [String] = []
    
    var mySource : String = "Chennai"
    var myDestination : String = "VIT"
    var myDate : String = "02-01-17"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func selectFilterPressed(_ sender: AnyObject) {
        
        let actionSheet = UIActionSheet(title: "Choose Filter", delegate: self, cancelButtonTitle:nil, destructiveButtonTitle: nil)
            actionSheet.addButton(withTitle: "Source and Destination")
         actionSheet.addButton(withTitle: "Time")
         actionSheet.addButton(withTitle: "Train/Flight")
          actionSheet.addButton(withTitle: "None")
        actionSheet.cancelButtonIndex = actionSheet.addButton(withTitle: "Cancel")
        actionSheet.show(in: self.view)

        
        
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        
        if buttonIndex == actionSheet.cancelButtonIndex
        {
            print ("Cancel")
        }
        else
           if(buttonIndex == 0)
        {
            
         selectFilterButton.titleLabel?.text = "Location"
            if(self.mySwitch.isOn == false) {
            fromCopy = []
            toCopy = []
            dateCopy = []
            for i in 0...self.from.count-1
            {
                if(self.from[i] == self.mySource && self.to[i] == self.myDestination) {
                    self.fromCopy.append(self.from[i])
                    self.toCopy.append(self.to[i])
                    self.dateCopy.append(self.date[i])
                }
            }
                self.myTable.reloadData()
            }
            else
            {
                for i in 0...self.fromCopy.count-1
                {
                    if(self.fromCopy[i] != self.mySource && self.toCopy[i] != self.myDestination) {
                        fromCopy.remove(at: i)
                        toCopy.remove(at: i)
                        dateCopy.remove(at: i)

}
                }
                self.myTable.reloadData()
                
                }
        }
        else
        if(buttonIndex == 1)
        {
             selectFilterButton.titleLabel?.text = "Time"
        }
        else
        if(buttonIndex == 2)
        {
             selectFilterButton.titleLabel?.text = "PNR"
        }
        else
        if(buttonIndex == 3)
        {
             selectFilterButton.titleLabel?.text = "Choose Option"
            if(mySwitch.isOn)
            {
              //   fromCopy = from
               // toCopy = to
               // dateCopy = date
                showSameDate()
                
            }
            self.myTable.reloadData()
        }
    
    }
    @IBAction func switchClicked(_ sender: AnyObject) {
        
        if mySwitch.isOn {
          showSameDate()
      
           }
       myTable.reloadData()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if(selectFilterButton.titleLabel?.text == "Location" || mySwitch.isOn){
            return fromCopy.count
        }
        else
        {
            return from.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelcell", for: indexPath) as! trackDetails
       
        if(selectFilterButton.titleLabel?.text == "Location" || mySwitch.isOn) {
            cell.fromLabel.text = fromCopy[indexPath.row]
            cell.toLabel.text = toCopy[indexPath.row]
            cell.dateLabel.text = dateCopy[indexPath.row]
       
        }
            
        else
        {
            cell.fromLabel.text = from[indexPath.row]
            cell.toLabel.text = to[indexPath.row]
            cell.dateLabel.text = date[indexPath.row]        }
        
        return cell
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
