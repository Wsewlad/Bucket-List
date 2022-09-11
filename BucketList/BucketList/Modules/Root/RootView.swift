//
//  RootView.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 11.09.2022.
//

import SwiftUI

enum Tabs {
    case map, settings
}

struct RootView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
    @StateObject private var viewModel = RootViewModel()
    
    var body: some View {
        ZStack {
            if !appLockVM.isAppLockEnabled || appLockVM.isAppUnLocked {
                VStack {
                    TabView(selection: $viewModel.selectedTab) {
                        MapView().tabItem {
                            Image(systemName: "map")
                            Text("Map")
                        }
                        .tag(Tabs.map)
                        
                        SettingsView().tabItem {
                            Image(systemName: "slider.horizontal.3")
                            Text("Settings")
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

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
