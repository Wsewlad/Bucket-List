//
//  EditPlace-ViewModel.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 15.09.2022.
//

import Foundation

extension EditPlace {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @MainActor
    final class EditPlaceModel: ObservableObject {
        @Published var loadingState: LoadingState = .loading
        @Published var pages = [Page]()
        
        func fetchNearbyPlaces(_ location: Location) async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                // we got some data back!
                let items = try JSONDecoder().decode(Result.self, from: data)

                // success – convert the array values to our pages array
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                // if we're still here it means the request failed somehow
                print(error)
                loadingState = .failed
            }
        }
    }
}
