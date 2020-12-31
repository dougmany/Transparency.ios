//
//  DetailView.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/20/20.
//

import SwiftUI

struct DetailView: View {
    let selectedFacilityNumber: String
    
    @State var selectedFacility = FacilityDetail(CAPACITY: "Capacity", CITY: "City", CONTACT: "Contact", COUNTY: "County", DISTRICTOFFICE: "DO", DOADDRESS: "DO Address", DOCITY: "DO City", DOSTATE: "DO State", DOTELEPHONE: "DO Phone", DOZIPCODE: "O Zip", FACILITYNAME: "Name", FACILITYNUMBER: "Number", FACILITYTYPE: "Type", LASTVISITDATE: "", LICENSEEFFECTIVEDATE: "", LICENSEFIRSTDATE: "", LICENSEENAME: "Lic Name", NBRALLVISITS: "", NBRCMPLTVISITS: "", NBRCMPLTTYPA: "", NBRCMPLTTYPB: "", NBRCMPLTINC: "", NBRCMPLTUNS: "", NBRCMPLTSUB: "", NBRCMPLTUNF: "", NBRINSPVISITS: "", NBRINSPTYPA: "", NBRINSPTYPB: "", NBROTHERVISITS: "", NBROTHERTYPA: "", NBROTHERTYPB: "", STATE: "State", STATUS: "Status", STREETADDRESS: "Street", TELEPHONE: "Phone", VSTDATEALL: "", VSTDATECMPLT: "", VSTDATEINSP: "", VSTDATEOTHER: "", ZIPCODE: "", TOTCMPVISITS: "", TOTSUBALG: "", TOTINCALG: "", TOTUNSALG: "", TOTUNFALG: "", TOTTYPEA: "", TOTTYPEB: "", CMPCOUNT: 0, COMPLAINTARRAY: [complaint(CONTROLNUMBER: "", APPROVEDATE: "", SUBALLEGATIONS: "", INCALLEGATIONS: "", UNSALLEGATIONS: "", UNFALLEGATIONS: "", CITTYPEA: "", CITTYPEB: "", NUMCMPVISITS: "selectedFacility", CMPVISITDATES: "")])
    
    var body: some View {
        ScrollView {
            VStack {
                VStack{
                    Text(selectedFacility.FACILITYNAME)
                    Text(selectedFacility.STATUS)
                    Divider()
                    VStack {
                        Text(selectedFacility.STREETADDRESS)
                        Text("\(selectedFacility.CITY), \(selectedFacility.STATE) \(selectedFacility.ZIPCODE)")
                        Link(selectedFacility.TELEPHONE, destination: URL(string: "tel:\(selectedFacility.telephoneDigits)")!)
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
                        Text(selectedFacility.DOADDRESS)
                        Text("\(selectedFacility.DOCITY), \(selectedFacility.DOSTATE) \(selectedFacility.DOZIPCODE)")
                        Link(selectedFacility.DOTELEPHONE, destination: URL(string: "tel:\(selectedFacility.doTelephoneDigits)")!)
                    }
                }
                Divider()
                ReportsView(selectedFacilityNumber: selectedFacilityNumber).frame(height: 200)
                Divider()
                VisitsView(selectedFacility: selectedFacility)
            }.onAppear(perform: loadData)
            .navigationTitle(selectedFacility.FACILITYNAME)
        }
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
