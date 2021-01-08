//
//  FacilitySearch3App.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/19/20.
//

import SwiftUI

@main
struct FacilitySearch3App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(parameters: facilitySearchParameters(facilityType: FacilityType(id: 0, name: "", description: "", nameSearchMode: .optional, streetSearchMode: .optional, citySearchMode: .optional, zipSearchMode: .optional, countySearchMode: .optional, groupId: "", sortOrder: 0 )))
        }
    }
}
