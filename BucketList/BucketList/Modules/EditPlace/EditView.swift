//
//  EditView.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 15.09.2022.
//

import SwiftUI

struct EditView: View {
    @StateObject private var viewModel = EditViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var onSave: (Location) -> Void
    var location: Location
    
    @State var name: String
    @State var description: String
    
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
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
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
                await viewModel.fetchNearbyPlaces(location)
            }
        }
    }
    
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: .example, onSave: { _ in })
    }
}
