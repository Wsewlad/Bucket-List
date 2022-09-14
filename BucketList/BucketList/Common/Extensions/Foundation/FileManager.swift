//
//  FileManager.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 11.09.2022.
//

import Foundation

extension FileManager {
    static func getDocumentsDirectory() -> URL {
        let paths = Self.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
