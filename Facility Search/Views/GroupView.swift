//
//  GroupView.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/21/20.
//

import SwiftUI

struct GroupView: View {
    @State var facilityTypes = [facilityGroup]()
    
    var body: some View {
        List(facilityTypes, id: \.id) { item in
            NavigationLink(item.display_name, destination: TypeView(types: item.facility_type, selectedGroup: item.display_name))
                .padding()
                .navigationTitle("Groups")
        }.onAppear(perform: loadData)
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


struct CGroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
