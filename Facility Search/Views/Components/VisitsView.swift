//
//  VisitsView.swift
//  Facility Search
//
//  Created by Doug Meeker on 12/26/20.
//

import SwiftUI

struct VisitsView: View {
    var selectedFacility: FacilityDetail
    
    var body: some View {
        Group {
            VStack {
                Text("All Visits: \(selectedFacility.NBRALLVISITS)")
                Text(selectedFacility.VSTDATEALL)
            }
            Divider()
            VStack{
                Text("Citations")
                HStack{
                    VStack{
                        Text("Type A Citation:")
                        Text("Type B Citation:")
                    }
                    VStack{
                        Text("\((Int(selectedFacility.NBRCMPLTTYPA) ?? 0) + (Int(selectedFacility.NBRINSPTYPA) ?? 0))")
                        Text("\((Int(selectedFacility.NBRCMPLTTYPB) ?? 0) + (Int(selectedFacility.NBRINSPTYPB) ?? 0))")
                    }
                }
            }
            Divider()
            VStack {
                Text("Inspections: \(selectedFacility.NBRINSPVISITS)")
                Text(selectedFacility.VSTDATEINSP)
                HStack{
                    VStack{
                        Text("Type A Citation:")
                        Text("Type B Citation:")
                    }
                    VStack{
                        Text("\(selectedFacility.NBRINSPTYPA)")
                        Text("\(selectedFacility.NBRINSPTYPB)")
                    }
                }
            }
            Divider()
            Group{
                VStack{
                    Text("Complaints")
                    HStack{
                        VStack(alignment: .trailing) {
                            Text("Total Complaint Investigations Completed:")
                            Text("Total Allegations Substantiated:")
                            Text("Total Allegations Inconclusive:")
                            Text("Total Allegations Unsubstantiated:")
                            if selectedFacility.RcfeType {
                                Text("Total Allegations Unfounded:")
                            }
                        }
                        VStack {
                            Text("\(selectedFacility.CMPCOUNT)")
                            Text("\(selectedFacility.NBRCMPLTSUB)")
                            Text("\(selectedFacility.NBRCMPLTINC)")
                            Text("\(selectedFacility.NBRCMPLTUNS)")
                            if selectedFacility.RcfeType {
                                Text("\(selectedFacility.NBRCMPLTUNF)")
                            }
                        }
                    }
                    HStack{
                        VStack(alignment: .trailing) {
                            Text("Type A Citation:")
                            Text("Type B Citation:")
                            Text("Total Complaint Visits:")
                        }
                        VStack{
                            Text("\(selectedFacility.NBRCMPLTTYPA)")
                            Text("\(selectedFacility.NBRCMPLTTYPB)")
                            Text("\(selectedFacility.NBRCMPLTVISITS)")
                        }
                    }
                }
                Divider()
                VStack{
                    Text("Complaint Details")
                    ForEach(selectedFacility.cmpDetails, id: \.self) { detail in
                        Text(detail)
                    }
                }
            }
            Divider()
            VStack{
                Text("Other Visits: \(selectedFacility.NBROTHERVISITS)")
                Text(selectedFacility.VSTDATEOTHER)
                HStack{
                    VStack{
                        
                    }
                    VStack{
                        
                    }
                }
                Text("Type A Citation: \(selectedFacility.NBROTHERTYPA)")
                Text("Type B Citation: \(selectedFacility.NBROTHERTYPB)")
                
            }
        }
    }
}

struct VisitsView_Previews: PreviewProvider {
    static var previews: some View {
        VisitsView(selectedFacility: FacilityDetail(CAPACITY: "Capacity", CITY: "City", CONTACT: "Contact", COUNTY: "County", DISTRICTOFFICE: "DO", DOADDRESS: "DO Address", DOCITY: "DO City", DOSTATE: "DO State", DOTELEPHONE: "DO Phone", DOZIPCODE: "O Zip", FACILITYNAME: "Name", FACILITYNUMBER: "Number", FACILITYTYPE: "Type", LASTVISITDATE: "", LICENSEEFFECTIVEDATE: "", LICENSEFIRSTDATE: "", LICENSEENAME: "Lic Name", NBRALLVISITS: "1", NBRCMPLTVISITS: "1", NBRCMPLTTYPA: "1", NBRCMPLTTYPB: "1", NBRCMPLTINC: "1", NBRCMPLTUNS: "1", NBRCMPLTSUB: "1", NBRCMPLTUNF: "1", NBRINSPVISITS: "1", NBRINSPTYPA: "1", NBRINSPTYPB: "1", NBROTHERVISITS: "1", NBROTHERTYPA: "1", NBROTHERTYPB: "1", STATE: "State", STATUS: "Status", STREETADDRESS: "Street", TELEPHONE: "Phone", VSTDATEALL: "", VSTDATECMPLT: "", VSTDATEINSP: "", VSTDATEOTHER: "", ZIPCODE: "", TOTCMPVISITS: "", TOTSUBALG: "", TOTINCALG: "", TOTUNSALG: "", TOTUNFALG: "", TOTTYPEA: "", TOTTYPEB: "", CMPCOUNT: 0, COMPLAINTARRAY: [complaint(CONTROLNUMBER: "", APPROVEDATE: "", SUBALLEGATIONS: "", INCALLEGATIONS: "", UNSALLEGATIONS: "", UNFALLEGATIONS: "", CITTYPEA: "", CITTYPEB: "", NUMCMPVISITS: "selectedFacility", CMPVISITDATES: "")]))
    }
    
}
