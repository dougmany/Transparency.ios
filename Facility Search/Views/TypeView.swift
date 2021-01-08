//
//  TypeView.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/20/20.
//

import SwiftUI

struct TypeView: View {
    let types: [FacilityType]
    
    var body: some View {
        List(types, id: \.id) { item in
            NavigationLink(destination: ListView( viewModel: FacilitySearchViewModel(parameters: facilitySearchParameters(facilityType: item)))) {
                LinkItemView(name: item.name, description: item.description)
            }                
        }.navigationTitle("Type")
    }
}


struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView(types: [FacilityType]())
    }
}
