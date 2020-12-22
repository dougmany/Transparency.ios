//
//  ListVew.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/20/20.
//

import SwiftUI

struct ListView: View {
    var selectedType: Int
    var selectedName: String
    
    @State var list = [facilitySearch]()
    
    var body: some View {
        List(list, id: \.FACILITYNUMBER) { item in
            NavigationLink(item.FACILITYNAME, destination: Text(item.FACILITYNAME))
                .padding()
                .navigationTitle(selectedName)
        }.onAppear(perform: loadData)
    }

    func loadData() {
        let parameters = facilitySearchParameters(facType: "\(self.selectedType)", facility: "", Street: "", city: "", zip: "", county: "", facnum: "")
        
        DataService.shared.fetchFacilityList(parameters: parameters) { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let data):
                        list = data
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(selectedType: 0, selectedName: "Test")
    }
}
