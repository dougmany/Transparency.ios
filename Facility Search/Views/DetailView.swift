//
//  DetailView.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/20/20.
//

import SwiftUI

struct DetailView: View {

    @ObservedObject var viewModel : FacilityDetailViewModel
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.load)
        case .loading:
            Text("Loading...")
        case .failed(let error):
            Text("An error occured...\(error.localizedDescription)")
        case .loaded(let selectedFacilityRoot):
            let selectedFacility = selectedFacilityRoot.FacilityDetail
            ScrollView {
                VStack {
                    VStack{
                        Text(selectedFacility.facilityName)
                        Text(selectedFacility.status)
                        if(selectedFacility.firstLicensedDate == "" && selectedFacility.status == "Licensed"){
                            Text("No date on file")
                        }
                        else if(selectedFacility.firstLicensedDate == "" && selectedFacility.status == "Pending"){
                            Text("Not licensed yet.")
                        }
                        else{
                            Text(selectedFacility.firstLicensedDate)
                        }
                        if(selectedFacilityRoot.TSO.ActionType != ""){
                            Text("\(selectedFacilityRoot.TSO.ActionType): \(selectedFacilityRoot.TSO.PleadingDate)")
                                .foregroundColor(.red)
                        }
                        NavigationLink("Subscribe", destination: SubscribeView(facilityNumber: selectedFacility.facilityNumber, facilityName: selectedFacility.facilityName))
                        Divider()
                        VStack {
                                if(selectedFacility.street != "See FAQs" && selectedFacility.street != "Unavailable"){
                                    HStack{
                                        Text(selectedFacility.street)
                                        Button(action: {
                                            let url = URL(string:  selectedFacility.mapLink)!
                                            UIApplication.shared.open( url)
                                        }) {Image(systemName: "map")}
                                    }
                                    Text("\(selectedFacility.city), \(selectedFacility.state) \(selectedFacility.zip)")
                                }
                                else{
                                    NavigationLink(selectedFacility.street, destination: FaqView())
                                }
                            if(selectedFacility.phone != "See FAQs"){
                                Button(action: {
                                    let url = URL(string: "tel:\(selectedFacility.phoneDigits)")!
                                    UIApplication.shared.open( url)
                                }) {Text(selectedFacility.phone)}
                            }
                            else{
                                NavigationLink(selectedFacility.phone, destination: FaqView())
                            }
                        }
                    }
                    Divider()
                    HStack {
                        VStack(alignment: .trailing) {
                            Text("Licensee Name:")
                            Text("Facililty Number:")
                            Text("Capacity:")
                            Text("Facillity Type:")
                        }
                        VStack(alignment: .leading) {
                            Text(selectedFacility.licenseeName)
                            Text(selectedFacility.facilityNumber)
                            Text(selectedFacility.capacity)
                            Text(selectedFacility.facilityType)
                        }
                    }
                    Divider()
                    VStack {
                        Text("For information about this facility")
                        Text("Contact State Licensing Office")
                        VStack {
                            Text(selectedFacility.districtOffice)
                            HStack{
                                Text(selectedFacility.doAddress)
                                Button(action: {
                                    let url = URL(string:  selectedFacility.doMapLink)!
                                    UIApplication.shared.open( url)
                                }) {Image(systemName: "map")}
                            }
                            Text("\(selectedFacility.doCity), \(selectedFacility.doState) \(selectedFacility.doZip)")
                            Button(action: {
                                let url = URL(string: "tel:\(selectedFacility.doPhoneDigits)")!
                                UIApplication.shared.open( url)
                            }) {Text(selectedFacility.doPhone)}
                        }
                    }
                    Divider()
                    VisitsView(selectedFacility: selectedFacility)
                    Divider()
                    ReportListView(viewModel: ReportListViewModel(facilityNumber: selectedFacility.facilityNumber)).frame(height: 200)
                    
                }
            }.navigationBarTitle(Text("Detail"))
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: FacilityDetailViewModel(facilityNumber: "111111111"))
    }
}

