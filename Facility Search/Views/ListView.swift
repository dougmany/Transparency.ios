//
//  ListVew.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/20/20.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: FacilitySearchViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.load)
        case .loading:
            Text("Loading...")
        case .failed(let error):
            if let apiError = error as? ApiError {
                switch apiError {
                case .badRequest:
                    ExactNameView()
                }
            }
            else{
                Text("An error occured...\(error.localizedDescription)")
            }
        case .loaded(let list):
            if(list.count > 0){
                List(list, id: \.FACILITYNUMBER) { item in
                    NavigationLink(destination: DetailView(viewModel: FacilityDetailViewModel(facilityNumber: item.FACILITYNUMBER))) {
                        LinkItemView(name: item.FACILITYNAME, description: "\(item.STREETADDRESS) - \(item.ZIPCODE)")
                    }
                }.navigationTitle("List")
            }
            else{
                Text("None Found")
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: FacilitySearchViewModel(parameters: facilitySearchParameters(facilityType: facilityType(id: 0, display_name: "", description: "", facility_name_search_mode: "", street_search_mode: "", city_search_mode: "", zip_search_mode: "", county_search_mode: "", facility_group_id: "", display_order: 0))))
    }
}
