//
//  EditView.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 15.09.2022.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    var location: Location
    
    @State var name: String
    @State var description: String
    
    @State var loadingState: LoadingState = .loading
    @State var pages = [Page]()
    
    @StateObject private var viewModel = EditViewModel()
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        self.location = location
        self._name = .init(initialValue: location.name)
        self._description = .init(initialValue: location.description)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Nearby...") {
                    switch loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    func fetchNearbyPlaces() async {
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

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: .example, onSave: { _ in })
    }
}
