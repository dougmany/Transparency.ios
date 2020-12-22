//
//  DetailView.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/20/20.
//

import SwiftUI

struct DetailView: View {
    let selectedFacilityNumber: String
    
    @State var selectedFacility: FacilityDetail
    
    var body: some View {
        VStack {
            Text(selectedFacility.FACILITYNAME)
            Text(selectedFacility.STATUS)
            Group {
                Text(selectedFacility.STREETADDRESS)
                Text(selectedFacility.CITY)
                Text(selectedFacility.LICENSEENAME)
            }
            HStack {
                VStack {
                    Text("Phone:")
                    Text("Facililty Number:")
                    Text("Capacity:")
                    Text("Facillity Type:")
                }
                VStack {
                    Text(selectedFacility.STREETADDRESS)
                    Text(selectedFacility.CITY)
                    Text(selectedFacility.CAPACITY)
                    Text(selectedFacility.LICENSEENAME)
                }
            }
            Text("State Licensing Office Contact Information")
            HStack{
                VStack{
                    Text("Address:")
                    Text("")
                    Text("Phone:")
                }
                VStack{
                    Text(selectedFacility.DOADDRESS)
                    Text(selectedFacility.DOCITY)
                    Text(selectedFacility.DOTELEPHONE)
                }
            }
            
                    .padding()
                    .navigationTitle(selectedFacility.FACILITYNAME)
                
        }.onAppear(perform: loadData)
    }

    func loadData() {
        DataService.shared.fetchFacilityDetail(facilityNumber: selectedFacilityNumber) { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let data):
                        selectedFacility = data
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedFacilityNumber: "111111111", selectedFacility: FacilityDetail(CAPACITY: "Capacity", CITY: "City", CONTACT: "Contact", COUNTY: "County", DISTRICTOFFICE: "DO", DOADDRESS: "DO Address", DOCITY: "DO City", DOSTATE: "DO State", DOTELEPHONE: "DO Phone", DOZIPCODE: "O Zip", FACILITYNAME: "Name", FACILITYNUMBER: "Number", FACILITYTYPE: "Type", LASTVISITDATE: "", LICENSEEFFECTIVEDATE: "", LICENSEFIRSTDATE: "", LICENSEENAME: "Lic Name", NBRALLVISITS: "", NBRCMPLTVISITS: "", NBRCMPLTTYPA: "", NBRCMPLTTYPB: "", NBRCMPLTINC: "", NBRCMPLTUNS: "", NBRCMPLTSUB: "", NBRCMPLTUNF: "", NBRINSPVISITS: "", NBRINSPTYPA: "", NBRINSPTYPB: "", NBROTHERVISITS: "", NBROTHERTYPA: "", NBROTHERTYPB: "", STATE: "State", STATUS: "Status", STREETADDRESS: "Street", TELEPHONE: "Phone", VSTDATEALL: "", VSTDATECMPLT: "", VSTDATEINSP: "", VSTDATEOTHER: "", ZIPCODE: "", TOTCMPVISITS: "", TOTSUBALG: "", TOTINCALG: "", TOTUNSALG: "", TOTUNFALG: "", TOTTYPEA: "", TOTTYPEB: "", CMPCOUNT: 0, COMPLAINTARRAY: [complaint(CONTROLNUMBER: "", APPROVEDATE: "", SUBALLEGATIONS: "", INCALLEGATIONS: "", UNSALLEGATIONS: "", UNFALLEGATIONS: "", CITTYPEA: "", CITTYPEB: "", NUMCMPVISITS: "selectedFacility", CMPVISITDATES: "")]))
    }
}
