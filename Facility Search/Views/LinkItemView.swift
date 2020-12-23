//
//  LinkItemView.swift
//  Facility Search
//
//  Created by Doug Meeker on 12/22/20.
//

import SwiftUI

struct LinkItemView: View {
    var name: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
            Text(description).font(.footnote)
        }
    }
}
