//
//  ContentView.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/19/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var parameters: facilitySearchParameters
    
    var body: some View {
        NavigationView {
            VStack{
                Button(action: {
                    let url = URL(string: "https://www.cdss.ca.gov")!
                    UIApplication.shared.open( url)
                }) {  Image("Logo") .padding(.top, 20)  }
                Text("CDSS Care Facility Search")
                Form{
                    Section{
                        TextField("Facility Number", text: $parameters.facnum)
                        NavigationLink("Search", destination: self.parameters.facnum == "" ?
                                        AnyView(GroupView(viewModel: FacilityGroupViewModel())):
                                        AnyView(DetailView(viewModel: FacilityDetailViewModel(facilityNumber: self.parameters.facnum)))
                        ).disabled(parameters.facnum != "" && parameters.facnum.count != 9)
                    }
                    Section{
                        TextField("Facility Name", text: $parameters.facility)
                        TextField("Street", text: $parameters.street)
                        TextField("City", text: $parameters.city)
                        TextField("Zip", text: $parameters.zip)
                        Picker(selection: $parameters.county, label: Text("County")) {
                            ForEach(parameters.counties, id: \.self){county in
                                Text(county)
                            }
                        }
                        NavigationLink("Search", destination: GroupView(viewModel: FacilityGroupViewModel()))
                    }
                    Section{
                        NavigationLink("FAQs", destination: FaqView())
                        NavigationLink("Glossary", destination: GlossaryView())
                    }
                }.navigationBarTitle(Text("Home"))
            }
            .navigationBarTitle("Care Facility Search")
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(parameters: facilitySearchParameters(facilityType: FacilityType(id: 0, name: "", description: "", nameSearchMode: .optional, streetSearchMode: .optional, citySearchMode: .optional, zipSearchMode: .optional, countySearchMode: .optional, groupId: "", sortOrder: 0)))
    }
}
