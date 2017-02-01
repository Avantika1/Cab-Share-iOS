//
//  locationDetails.swift
//  VITrack
//
//  Created by Avantika Bhatia on 28/07/16.
//  Copyright © 2016 avantika. All rights reserved.
//

import Foundation

import MapKit

class locationDetails: NSObject, MKAnnotation {
    
    var latitude: Double
    var longitude:Double
    var title : String?
    var subtitle: String?
    var image : UIImage!
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
}

