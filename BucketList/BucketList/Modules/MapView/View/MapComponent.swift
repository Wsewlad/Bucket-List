//
//  MapView.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 11.09.2022.
//

import SwiftUI
import MapKit

struct MapComponent: View {
    struct Props {
        let mapRegion: Binding<MKCoordinateRegion>
        let locations: [Location]
        let addLocationAction: () -> Void
        let update: (Location) -> Void
    }
    
    let props: Props
    
    init(props: Props) {
        self.props = props
    }
    
    @State var selectedPlace: Location?
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: props.mapRegion, annotationItems: props.locations) { location in
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
                        selectedPlace = location
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
                    
                    Button(action: props.addLocationAction) {
                        Image.sf(.plus)
                            .padding()
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                    }
                    .padding(.trailing)
                    .padding(.bottom)
                }
            }
        }
        .sheet(item: $selectedPlace) { place in
            EditView(location: place) { location in
                props.update(location)
            }
        }
    }
}

//MARK: - Preview
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapComponent(
            props: .init(
                mapRegion: .constant(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
                        span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
                    )
                ),
                locations: [.example],
                addLocationAction: {},
                update: { _ in }
            )
        )
    }
}
