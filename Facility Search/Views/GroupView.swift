//
//  GroupView.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/21/20.
//

import SwiftUI

struct GroupView: View {
    @ObservedObject var viewModel: FacilityGroupViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.load)
        case .loading:
            Text("Loading...")
        case .failed(let error):
            Text("An error occured...\(error.localizedDescription)")
        case .loaded(let facilityTypes):
            List(facilityTypes, id: \.id) { item in
                NavigationLink(item.name, destination: TypeView(types: item.types.sorted { $0.sortOrder < $1.sortOrder }))
                    .padding()
                    .navigationBarTitle(Text("Groups"))
            }
        }
    }
}

struct CGroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(viewModel: FacilityGroupViewModel())
    }
}

