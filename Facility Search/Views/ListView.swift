//
//  ListVew.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/20/20.
//

import SwiftUI

struct ListView: View {
    var selectedName: String
    
    @ObservedObject var viewModel: FacilitySearchViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.load)
        case .loading:
            Text("Loading...")
        case .failed(let error):
            Text("An error occured...\(error.localizedDescription)")
        case .loaded(let list):
            List(list, id: \.FACILITYNUMBER) { item in
                NavigationLink(destination: DetailView(viewModel: FacilityDetailViewModel(facilityNumber: item.FACILITYNUMBER))) {
                    LinkItemView(name: item.FACILITYNAME, description: "\(item.STREETADDRESS) - \(item.ZIPCODE)")
                }
            }.navigationTitle(selectedName)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(selectedName: "Test", viewModel: FacilitySearchViewModel(parameters: facilitySearchParameters(facilityType: "")))
    }
}
