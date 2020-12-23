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
            NavigationLink(destination: DetailView(selectedFacilityNumber: item.FACILITYNUMBER)) {
                LinkItemView(name: item.FACILITYNAME, description: item.STREETADDRESS)
            }
        }.onAppear(perform: loadData)
        .navigationTitle(selectedName)
    }
    
    func loadData() {
        let parameters = facilitySearchParameters()
        parameters.facType = "\(self.selectedType)"
        
        DataService.shared.fetchFacilityList(parameters: parameters) { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let data):
                        if data.count == 0 {
                            list = [facilitySearch(COUNTY: "", FACILITYNAME: "None Found", FACILITYNUMBER: "",STATUS: "", STREETADDRESS:"", TELEPHONE:"", ZIPCODE: "")]
                        } else {
                            self.list = data
                            self.list.sort { $0.FACILITYNAME < $1.FACILITYNAME }
                        }
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