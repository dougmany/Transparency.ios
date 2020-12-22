//
//  ContentView.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/19/20.
//

import SwiftUI

struct ContentView: View {
    @State var facilityTypes = [facilityGroup]()
    
    var body: some View {
        NavigationView {
            List(facilityTypes, id: \.id) { item in
                NavigationLink(item.display_name, destination: TypeView(types: item.facility_type, selectedGroup: item.display_name))
                    .padding()
                    .navigationTitle("Groups")
            }.onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        DataService.shared.fetchFacilityGroups() { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let groups):
                        self.facilityTypes = groups.groups
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
