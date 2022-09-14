//
//  RootView.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 11.09.2022.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
    @StateObject private var viewModel = RootViewModel()
    
    var body: some View {
        ZStack {
            if isUnlocked {
                VStack {
                    TabView(selection: $viewModel.selectedTab) {
                        MapView().tabItem {
                            Image(systemName: "map")
                            Text(String.localized().root.map)
                        }
                        .tag(Tabs.map)
                        
                        SettingsView().tabItem {
                            Image(systemName: "slider.horizontal.3")
                            Text(String.localized().root.settings)
                        }
                        .tag(Tabs.settings)
                    }
                    .accentColor(.black)
                }
            } else {
                AppLockView()
            }
        }
        .transition(.opacity)
        .onAppear {
            if appLockVM.isAppLockEnabled {
                appLockVM.appLockValidation()
            }
        }
    }
}

//MARK: - Computed Properties
private extension RootView {
    var isUnlocked: Bool {
        !appLockVM.isAppLockEnabled || appLockVM.isAppUnLocked
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
