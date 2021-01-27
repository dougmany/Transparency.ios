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
                if(viewModel.dissabledWithDate.count > 0){
                    ForEach(viewModel.dissabledWithDate, id: \.self) { denied in
                        Text("\(denied) search is dissabled for this type.")
                    }
                }
                if  list.count == 250 {
                    Text("Your search returned more data than allowed for display (limit 250 facilities).")
                    Text("You may want to add additional criteria to refine your search.")
                }
                List(list, id: \.facilityNumber) { item in
                    NavigationLink(destination: DetailView(viewModel: FacilityDetailViewModel(facilityNumber: item.facilityNumber))) {
                        LinkItemView(name: item.facilityName, description: item.street == "See FAQs" ? item.street: "\(item.street) - \(item.zip)")
                    }
                }.navigationBarTitle(Text("List"))
            }
            else{
                Text("None Found")
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: FacilitySearchViewModel(parameters: facilitySearchParameters(facilityType: FacilityType(id: 0, name: "", description: "", nameSearchMode: .optional, streetSearchMode: .optional, citySearchMode: .optional, zipSearchMode: .optional, countySearchMode: .optional, groupId: "", sortOrder: 0))))
    }
}
