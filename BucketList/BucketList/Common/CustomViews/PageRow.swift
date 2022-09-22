//
//  PageRow.swift
//  BucketList
//
//  Created by  Vladyslav Fil on 22.09.2022.
//

import SwiftUI

struct PageRow: View {
    let page: Page
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading) {
                Text(page.title)
                    .font(.headline)
                
                Text(page.description)
                    .font(.body)
                    .italic()
            }
        }
        .buttonStyle(.plain)
    }
}
