//
//  RootViewModel.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 12.09.2022.
//

import Foundation

enum Tabs {
    case map, settings
}

extension RootView {
    @MainActor
    final class RootViewModel: ObservableObject {
        
        @Published var selectedTab: Tabs = .map
        
    }
}
