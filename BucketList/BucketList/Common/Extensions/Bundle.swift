//
//  Bundle.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 11.09.2022.
//

import Foundation

extension Bundle {
    func load<T: Codable>(_ file: String, as type: T.Type = T.self) -> T? {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            print("Failed to locate \(file) in bundle.")
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("Failed to load \(file) from bundle.")
            return nil
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            print("Failed to decode \(file) from bundle.")
            return nil
        }
        
        return loaded
    }
}
