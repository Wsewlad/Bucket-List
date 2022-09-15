//
//  MapContainer.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 16.09.2022.
//

import SwiftUI

struct MapContainer: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        MapComponent(
            props: .init(
                mapRegion: $viewModel.mapRegion,
                locations: viewModel.locations,
                addLocationAction: { viewModel.addLocation() },
                update: { viewModel.update($0) }
            )
        )
    }
}
