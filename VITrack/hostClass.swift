//
//  hostClass.swift
//  VITrack
//
//  Created by Avantika Bhatia on 18/03/17.
//  Copyright © 2017 avantika. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

enum Result {
    case Success(Any), Failure(NSError)
}

class hostClass: NSObject {
    
    func getAllTravellersForUser(callback:@escaping (Result) -> Void)
    {
    
    Alamofire.request("http://demo0578800.mockable.io/getAllTravellers")
                .responseJSON {  response in
                    switch response.result
                    {
                   
                    case .success(_):
                        print("boo")
                        let json = JSON(response.result.value!)
                        let result: Result
                        result = Result.Success(travellersDetails.mapUserData(json: json["contacts"]))
                        callback(result)
                        break
                    case .failure(_):
                        let error = response.result.error!
                        let result : Result = Result.Failure(error as NSError)
                        callback(result)
                        break
                        
                    }
                    guard response.result.error == nil else {
                        print("error")
                        print(response.result.error!)
                        return
                    }
            
        }
    }
}
    
