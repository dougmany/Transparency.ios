//
//  ContentView.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/19/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var parameters = facilitySearchParameters(facilityType: facilityType(id: 0, display_name: "", description: "", facility_name_search_mode: "", street_search_mode: "", city_search_mode: "", zip_search_mode: "", county_search_mode: "", facility_group_id: "", display_order: 0))
    
    var body: some View {
        VStack{
            NavigationView {
                VStack{
                    Link(destination: URL(string: "https://www.cdss.ca.gov")!, label: {Image("Logo")})
                    Text("CDSS Care Facility Search")
                    Form{
                        Section{
                            TextField("Facility Number", text: $parameters.facnum)
                            NavigationLink("Search", destination: self.parameters.facnum == "" ?
                                            AnyView(GroupView(viewModel: FacilityGroupViewModel())):
                                            AnyView(DetailView(viewModel: FacilityDetailViewModel(facilityNumber: self.parameters.facnum)))
                            )
                        }
                        Section{
                            TextField("Facility Name", text: $parameters.facility)
                            //TextField("Street", text: $parameters.Street)
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
                    }
                }
            }
        }.navigationTitle("Groups")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
