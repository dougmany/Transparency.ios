//
//  TypeView.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/20/20.
//

import SwiftUI

struct TypeView: View {
    let types: [facilityType]
    let selectedGroup: String
    
    var body: some View {
        List(types, id: \.id) { item in
            NavigationLink(destination: ListView(selectedType: item.id, selectedName: item.display_name)) {
                LinkItemView(name: item.display_name, description: item.description)
            }                
        }.navigationTitle(selectedGroup)
    }
}


struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView(types: [facilityType](), selectedGroup: "Types")
    }
}