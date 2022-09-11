//
//  MapView.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 11.09.2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    Text(location.name)
                        .padding(5)
                        .background(
                            Circle()
                                .fill(Color.white)
                        )
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
