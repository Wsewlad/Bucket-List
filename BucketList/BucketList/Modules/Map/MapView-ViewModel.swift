//
//  MapView-ViewModel.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 11.09.2022.
//

import SwiftUI
import MapKit

extension MapContainer {
    @MainActor
    final class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
        )
        @Published private(set) var locations: [Location]
        
        private let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print(String.localized().errors.unableToSaveData)
            }
        }
        
        func addLocation() {
            let newLocation = Location(
                id: .init(value: Int.random(in: 0...100)),
                name: String.localized().map.locationDefaultName,
                description: "",
                latitude: mapRegion.center.latitude,
                longitude: mapRegion.center.longitude
            )
            locations.append(newLocation)
            save()
        }
        
        func update(_ location: Location) {
            if let index = locations.firstIndex(where: { $0.id == location.id }) {
                locations[index] = location
                save()
            }
        }
    }
}
