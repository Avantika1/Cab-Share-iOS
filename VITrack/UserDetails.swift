//
//  UserDetails.swift
//  VITrack
//
//  Created by Avantika Bhatia on 06/02/17.
//  Copyright © 2017 avantika. All rights reserved.
//

import Foundation
import SwiftyJSON



struct travellersDetails {
    
    var source : String?
    var destination : String?
    var name : String?
    var email : String?
    var contactNo : String?
    var time : String?
    var pnr : String?
    var id : String?
    var date : String?
    
    
    
   static func mapUserData(json : JSON) -> [travellersDetails] {
        var userArray = [travellersDetails]()
    
   
        for item : JSON in json["contacts"].array! {
            let user = travellersDetails(source: item["source"].stringValue, destination : item["destination"].stringValue, name: item["name"].stringValue,email: item["email"].stringValue, contactNo: item["contactNo"].stringValue,time: item["pnr"].stringValue,pnr: item["pnr"].stringValue,id: item["id"].stringValue,date: item["date"].stringValue)
            userArray.append(user)
        }
        return userArray
    }

    
   /* static func mapTripData(json:JSON) -> [travellersDetails]
    {
        var tripArr = [travellersDetails]()
        
        
        if let componentArray = json.array {
            for items:JSON in componentArray
            {
                print("tripArr")
                let from = items["source"].stringValue
                let to = items["destination"].stringValue
                let time1 = items["time"].stringValue
                let id1 = items["id"].stringValue
                let pnr1 = items["pnr"].stringValue
                let date1 = items["date"].stringValue
                let email1 = items["email"].stringValue
                let contact1 = items["contactNo"].stringValue
                let name1 = items["name"].stringValue
                
                let trip = travellersDetails(source: from, destination: to, name:name1,email:email1, contactNo:contact1, time : time1,pnr: pnr1,id : id1,date: date1)
                print(trip)
                tripArr.append(trip)
            }
        }
        
        
        
        //print(tripArr)
        return tripArr
    }*/

    
}

