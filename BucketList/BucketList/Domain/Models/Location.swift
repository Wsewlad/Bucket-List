//
//  Location.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 11.09.2022.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable {
    struct Id: Hashable, Codable {
        let value: Int
    }
    
    let id: Id
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}

//MARK: - Example
extension Location {
    static let example = Location(
        id: .init(value: 1),
        name: "Buckingham Palace",
        description: "Where Queen Elizabet lives with her dorgis",
        latitude: 51.501,
        longitude: -0.141
    )
}
