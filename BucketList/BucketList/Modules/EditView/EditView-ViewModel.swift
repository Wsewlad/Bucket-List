//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 15.09.2022.
//

import Foundation

extension EditView {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @MainActor
    final class EditViewModel: ObservableObject {
        @Published var loadingState: LoadingState = .loading
        @Published var pages = [Page]()
        
        
    }
}
