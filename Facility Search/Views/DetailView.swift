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
    
    @State var reportList = [ReportInfo(CONTROLNUMBER: "", FACILITYNUMBER: "", REPORTDATE: "", REPORTTITLE: "", REPORTTYPE: "", REPORTPAGE: "")]
    
    var body: some View {
        VStack {
            Text(selectedFacility.FACILITYNAME)
            Text(selectedFacility.STATUS)
            Divider()
            VStack {
                Text(selectedFacility.STREETADDRESS)
                Text("\(selectedFacility.CITY), \(selectedFacility.STATE) \(selectedFacility.ZIPCODE)")
                Text(selectedFacility.LICENSEENAME)
            }
            Divider()
            HStack {
                VStack(alignment: .trailing) {
                    Text("Phone:")
                    Text("Facililty Number:")
                    Text("Capacity:")
                    Text("Facillity Type:")
                }
                VStack(alignment: .leading) {
                    Text(selectedFacility.TELEPHONE)
                    Text(selectedFacility.FACILITYNUMBER)
                    Text(selectedFacility.CAPACITY)
                    Text(selectedFacility.FACILITYTYPE)
                }
            }
            Divider()
            VStack {
                Text("State Licensing Office Contact Information:")
                HStack{
                    VStack(alignment: .trailing){
                        Text("Address:")
                        Text("")
                        Text("Phone:")
                    }
                    VStack(alignment: .leading){
                        Text(selectedFacility.DOADDRESS)
                        Text(selectedFacility.DOCITY)
                        Text(selectedFacility.DOTELEPHONE)
                    }
                }
            }
            Divider()
            VStack{
                Text("Reports")
                let reports = reportList.enumerated().map({ $0 })
                List(reports, id: \.element.REPORTDATE) { index, report in
                    NavigationLink("\(report.REPORTTYPE) - \(report.REPORTDATE)", destination: ReportView(selectedFacilityNumber: selectedFacility.FACILITYNUMBER, selectedIndex: "\(index)" ))
                }
            }
        }.onAppear(perform: loadData)
        .navigationTitle(selectedFacility.FACILITYNAME)
    
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
        
        DataService.shared.fetchFacilityReportList(facilityNumber: selectedFacilityNumber) { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let data):
                        reportList = data
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedFacilityNumber: "111111111", selectedFacility: FacilityDetail(CAPACITY: "Capacity", CITY: "City", CONTACT: "Contact", COUNTY: "County", DISTRICTOFFICE: "DO", DOADDRESS: "DO Address", DOCITY: "DO City", DOSTATE: "DO State", DOTELEPHONE: "DO Phone", DOZIPCODE: "O Zip", FACILITYNAME: "Name", FACILITYNUMBER: "Number", FACILITYTYPE: "Type", LASTVISITDATE: "", LICENSEEFFECTIVEDATE: "", LICENSEFIRSTDATE: "", LICENSEENAME: "Lic Name", NBRALLVISITS: "", NBRCMPLTVISITS: "", NBRCMPLTTYPA: "", NBRCMPLTTYPB: "", NBRCMPLTINC: "", NBRCMPLTUNS: "", NBRCMPLTSUB: "", NBRCMPLTUNF: "", NBRINSPVISITS: "", NBRINSPTYPA: "", NBRINSPTYPB: "", NBROTHERVISITS: "", NBROTHERTYPA: "", NBROTHERTYPB: "", STATE: "State", STATUS: "Status", STREETADDRESS: "Street", TELEPHONE: "Phone", VSTDATEALL: "", VSTDATECMPLT: "", VSTDATEINSP: "", VSTDATEOTHER: "", ZIPCODE: "", TOTCMPVISITS: "", TOTSUBALG: "", TOTINCALG: "", TOTUNSALG: "", TOTUNFALG: "", TOTTYPEA: "", TOTTYPEB: "", CMPCOUNT: 0, COMPLAINTARRAY: [complaint(CONTROLNUMBER: "", APPROVEDATE: "", SUBALLEGATIONS: "", INCALLEGATIONS: "", UNSALLEGATIONS: "", UNFALLEGATIONS: "", CITTYPEA: "", CITTYPEB: "", NUMCMPVISITS: "selectedFacility", CMPVISITDATES: "")]),
        reportList: [ReportInfo(CONTROLNUMBER: "", FACILITYNUMBER: "", REPORTDATE: "", REPORTTITLE: "", REPORTTYPE: "", REPORTPAGE: "")])
    }
}
