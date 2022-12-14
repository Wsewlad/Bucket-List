//
//  SettingsView.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 12.09.2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Toggle(isOn: $appLockVM.isAppLockEnabled) {
                        Text(String.localized().settings.appLock)
                    }
                    .onChange(of: appLockVM.isAppLockEnabled) { value in
                        appLockVM.appLockStateChange(appLockState: value)
                    }
                }
            }
            .navigationTitle(String.localized().settings.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
