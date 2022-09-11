//
//  User.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 11.09.2022.
//

import Foundation

struct User: Identifiable {
    struct Id: Hashable {
        let value: Int
    }
    
    let id: Id
    let firstName: String
    let laseName: String
}

extension User: Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.laseName < rhs.laseName
    }
}
