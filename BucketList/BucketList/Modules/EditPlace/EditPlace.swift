//
//  EditView.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 15.09.2022.
//

import SwiftUI

struct EditPlace: View {
    @StateObject private var viewModel = EditPlaceModel()
    
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
                inputFieldsSectionView
                
                placesSectionView
            }
            .navigationTitle(String.localized().editPlace.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(String.localized().common.save, action: onSaveProxy)
            }
            .task {
                await viewModel.fetchNearbyPlaces(location)
            }
        }
    }
}

//MARK: - Input Fields Section
private extension EditPlace {
    var inputFieldsSectionView: some View {
        Section {
            TextField(String.localized().editPlace.namePlaceholder, text: $name)
            TextField(String.localized().editPlace.descriptionPlaceholder, text: $description)
        }
    }
}

//MARK: - Places Section
private extension EditPlace {
    var placesSectionView: some View {
        Section(String.localized().editPlace.placesTitle) {
            switch viewModel.loadingState {
            case .loading:
                Text(String.localized().common.loading)
            case .loaded:
                ForEach(viewModel.pages, id: \.pageid) { page in
                    PageRow(page: page, action: { choose(page) })
                }
            case .failed:
                Text(String.localized().common.tryLater)
            }
        }
    }
}

//MARK: - Functions
private extension EditPlace {
    func choose(_ place: Page) {
        name = place.title
        description = place.description
    }
    
    func onSaveProxy() {
        var newLocation = location
        newLocation.name = name
        newLocation.description = description
        
        onSave(newLocation)
        dismiss()
    }
}

//MARK: - Previwer
struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditPlace(location: .example, onSave: { _ in })
    }
}
