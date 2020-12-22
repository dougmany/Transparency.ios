//
//  ContentView.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/19/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var parameters = facilitySearchParameters()
    
    var body: some View {
        NavigationView {
            Form{
                NavigationLink("Search", destination: self.parameters.facnum == "" ?  AnyView(GroupView()): AnyView(DetailView(selectedFacilityNumber: self.parameters.facnum)))
                Section(header: Text("Facility Number")){
                    TextField("Facility Number", text: $parameters.facnum)
                }
                TextField("Facility Name", text: $parameters.facility)
                //TextField("Street", text: $parameters.Street)
                TextField("City", text: $parameters.city)
                TextField("Zip", text: $parameters.zip)
                Picker(selection: $parameters.county, label: Text("County")) {
                    ForEach(parameters.counties, id: \.self){county in
                        Text(county)
                    }
                }
                Section(){
                    NavigationLink("Search", destination: GroupView())
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
