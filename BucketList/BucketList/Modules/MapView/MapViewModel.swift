//
//  MapViewModel.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 11.09.2022.
//

import SwiftUI
import MapKit

extension MapView {
    @MainActor
    final class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
        )
        
        @Published var locations = [Location]()
        
        func addNewLocation() {
            let newLocation = Location(
                id: .init(value: Int.random(in: 0...100)),
                name: "New Location",
                description: "",
                latitude: mapRegion.center.latitude,
                longitude: mapRegion.center.longitude
            )
            locations.append(newLocation)
        }
        
        init() {
            locations = [.example]
        }
    }
}
