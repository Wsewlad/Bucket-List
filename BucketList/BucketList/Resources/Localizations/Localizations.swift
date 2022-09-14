//
//  Localizations.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 14.09.2022.
//

import Foundation

func LocalizedString(_ key: String) -> String {
    NSLocalizedString(key, comment: key)
}

struct Localizations {
    var root: Root { .init() }
    var settings: Settings { .init() }
    var map: Map { .init() }
}

extension Localizations {
    //MARK: - Root
    struct Root {
        var map: String { LocalizedString("root_map") }
        var settings: String { LocalizedString("root_settings") }
        
//        var : String { LocalizedString("root_") }
    }
    
    
    //MARK: - Settings
    struct Settings {
        var title: String { LocalizedString("settings_title") }
        var appLock: String { LocalizedString("settings_appLock") }
        
//        var : String { LocalizedString("settings_") }
    }
    
    //MARK: - Map
    struct Map {
        var title: String { LocalizedString("map_title") }
        
//        var : String { LocalizedString("map_") }
    }
}
