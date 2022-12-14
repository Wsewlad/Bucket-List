//
//  Image.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 15.09.2022.
//

import SwiftUI

extension Image {
    
    
    //        static var : Image { .init("") }
}

//MARK: - SF Symbols
extension Image {
    enum Symbol: String {
        case map
        case sliderHorizontal3 = "slider.horizontal.3"
        case starCircle = "star.circle"
        case plus
    }
    
    static func sf(_ name: Symbol) -> Self {
        .init(systemName: name.rawValue)
    }
}

extension Image {
    var template: Self {
        self.renderingMode(.template)
    }
    
    func aspectFit() -> some View {
        self.resizable().aspectRatio(contentMode: .fit)
    }
    
    func aspectFill()  -> some View {
        self.resizable().aspectRatio(contentMode: .fill)
    }
}
