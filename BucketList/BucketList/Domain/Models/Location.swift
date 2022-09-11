//
//  Location.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 11.09.2022.
//

import Foundation
import MapKit

struct Location: Identifiable {
    struct Id: Hashable {
        let value: Int
    }
    
    let id: Id
    let name: String
    let coordinate: CLLocationCoordinate2D
}
