//
//  String.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 14.09.2022.
//

import Foundation

extension String {
    static func localized() -> Localizations { Localizations() }
}

extension String {
    func format(parameters: CVarArg...) -> String {
        return String(format: self, arguments: parameters)
    }
}
