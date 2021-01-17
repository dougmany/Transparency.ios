//
//  ContentView.swift
//  Facility Search
//
//  Created by Doug Meeker on 1/15/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView(parameters: facilitySearchParameters(facilityType: FacilityType(id: 0, name: "", description: "", nameSearchMode: .optional, streetSearchMode: .optional, citySearchMode: .optional, zipSearchMode: .optional, countySearchMode: .optional, groupId: "", sortOrder: 0 )))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
