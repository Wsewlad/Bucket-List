//
//  BucketListApp.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 11.09.2022.
//

import SwiftUI

@main
struct BucketListApp: App {
    @StateObject var appLockVM = AppLockViewModel()
    @Environment(\.scenePhase) var scenePhase
    
    @State var blurRadius: CGFloat = 0
    
    init() {
        configureNavBar()
        configureTabBar()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appLockVM)
                .blur(radius: blurRadius)
                .onChange(of: scenePhase, perform: { value in
                    switch value {
                    case .active :
                        blurRadius = 0
                    case .background:
                        appLockVM.isAppUnLocked = false
                    case .inactive:
                        blurRadius = 5
                    @unknown default:
                        print("unknown")
                    }
                })
        }
    }
}

//MARK: - configureNavBar
private extension BucketListApp {
    func configureNavBar() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
}

//MARK: - configureTabBar
private extension BucketListApp {
    func configureTabBar() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = UIColor.gray
        UITabBar.appearance().isTranslucent = true
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
    }
}
