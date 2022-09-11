//
//  RootViewModel.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 12.09.2022.
//

import Foundation

extension RootView {
    @MainActor
    final class RootViewModel: ObservableObject {
        @Published var selectedTab: Tabs = .map
    }
}
