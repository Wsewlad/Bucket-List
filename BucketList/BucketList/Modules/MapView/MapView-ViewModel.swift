//
//  MapView-ViewModel.swift
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
        @Published private(set) var locations = [Location]()
        @Published var selectedPlace: Location? = nil
        
        init() {
            locations = [.example]
        }
        
        func addLocation() {
            let newLocation = Location(
                id: .init(value: Int.random(in: 0...100)),
                name: "New Location",
                description: "",
                latitude: mapRegion.center.latitude,
                longitude: mapRegion.center.longitude
            )
            locations.append(newLocation)
        }
        
        func update(_ location: Location) {
            if let index = locations.firstIndex { $0.id == location.id } {
                locations[index] = location
            }
        }
        
    }
}
