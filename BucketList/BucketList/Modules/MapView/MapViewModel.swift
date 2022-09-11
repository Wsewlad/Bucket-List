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
            center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
        
        var locations = [
            Location(id: .init(value: 1), name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.301, longitude: -0.141)),
            Location(id: .init(value: 2), name: "Toear of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
        ]
    }
}
