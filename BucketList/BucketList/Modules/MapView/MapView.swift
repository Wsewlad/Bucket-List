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
        ZStack {
            Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image.sf(.starCircle)
                            .aspectFit()
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        
                        Text(location.name)
                            .fixedSize()
                    }
                    .onTapGesture {
                        viewModel.selectedPlace = location
                    }
                }
            }
            .navigationTitle(String.localized().map.title)
            .navigationBarTitleDisplayMode(.inline)
            
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        viewModel.addLocation()
                    } label: {
                        Image.sf(.plus)
                            .padding()
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                    }
                    .padding(.trailing)
                }
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) { location in
                viewModel.update(location)
            }
        }
    }
}

//MARK: - Preview
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
