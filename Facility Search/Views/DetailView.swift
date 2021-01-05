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
        case .loaded(let selectedFacility):
            ScrollView {
                VStack {
                    VStack{
                        Text(selectedFacility.FACILITYNAME)
                        Text(selectedFacility.STATUS)
                        Divider()
                        VStack {
                            HStack{
                                Text(selectedFacility.STREETADDRESS)
                                if(selectedFacility.STREETADDRESS != "See FAQs" && selectedFacility.STREETADDRESS != "Unavailable"){
                                    Link(destination: URL(string: selectedFacility.mapLink)!, label: {Image(systemName: "map")})
                                }
                            }
                            Text("\(selectedFacility.CITY), \(selectedFacility.STATE) \(selectedFacility.ZIPCODE)")
                            if(selectedFacility.TELEPHONE != "See FAQs"){
                                Link(selectedFacility.TELEPHONE, destination: URL(string: "tel:\(selectedFacility.telephoneDigits)")!)
                            }
                            else{
                                NavigationLink(selectedFacility.TELEPHONE, destination: FaqView())
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
                            Text(selectedFacility.LICENSEENAME)
                            Text(selectedFacility.FACILITYNUMBER)
                            Text(selectedFacility.CAPACITY)
                            Text(selectedFacility.FACILITYTYPE)
                        }
                    }
                    Divider()
                    VStack {
                        Text("For information about this facility")
                        Text("Contact State Licensing Office")
                        VStack {
                            Text(selectedFacility.DISTRICTOFFICE)
                            HStack{
                                Text(selectedFacility.DOADDRESS)
                                Link(destination: URL(string: selectedFacility.doMapLink)!, label: {Image(systemName: "map")})
                            }
                            Text("\(selectedFacility.DOCITY), \(selectedFacility.DOSTATE) \(selectedFacility.DOZIPCODE)")
                            Link(selectedFacility.DOTELEPHONE, destination: URL(string: "tel:\(selectedFacility.doTelephoneDigits)")!)
                        }
                    }
                    Divider()
                    ReportsView(viewModel: ReportListViewModel(facilityNumber: selectedFacility.FACILITYNUMBER)).frame(height: 200)
                    Divider()
                    VisitsView(selectedFacility: selectedFacility)
                }.navigationTitle(selectedFacility.FACILITYNAME)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: FacilityDetailViewModel(facilityNumber: "111111111"))
    }
}
