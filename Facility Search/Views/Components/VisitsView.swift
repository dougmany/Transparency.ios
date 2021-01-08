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
                Text("All Visits: \(selectedFacility.numberAllVisits)")
                Text(selectedFacility.allVisitDates )
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
                        Text("\((Int(selectedFacility.numberComplaintsTypeA) ?? 0) + (Int(selectedFacility.numberInspectionsTypeA) ?? 0))")
                        Text("\((Int(selectedFacility.numberComplaintsTypeB) ?? 0) + (Int(selectedFacility.numberInspectionsTypeB) ?? 0))")
                    }
                }
            }
            Divider()
            VStack {
                Text("Inspections: \(selectedFacility.numberInspectionVisits)")
                Text(selectedFacility.inspectionVisitDates)
                HStack{
                    VStack{
                        Text("Type A Citation:")
                        Text("Type B Citation:")
                    }
                    VStack{
                        Text("\(selectedFacility.numberInspectionsTypeA)")
                        Text("\(selectedFacility.numberInspectionsTypeB)")
                    }
                }
            }
            if selectedFacility.complaintCount > 0 {
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
                                if selectedFacility.rcfeType {
                                    Text("Total Allegations Unfounded:")
                                }
                            }
                            VStack {
                                Text("\(selectedFacility.complaintCount)")
                                Text("\(selectedFacility.numberComplaintsSubstantiated)")
                                Text("\(selectedFacility.numberComplaintsInconclusive)")
                                Text("\(selectedFacility.numberComplaintsunsubstantiated)")
                                if selectedFacility.rcfeType {
                                    Text("\(selectedFacility.numberComplaintsUnfounded)")
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
                                Text("\(selectedFacility.numberComplaintsTypeA)")
                                Text("\(selectedFacility.numberComplaintsTypeB)")
                                Text("\(selectedFacility.numberComplaintVisits)")
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
            }
            Divider()
            VStack{
                Text("Other Visits: \(selectedFacility.numberOtherVisits)")
                Text(selectedFacility.otherVisitDates)
                HStack{
                    VStack{
                        
                    }
                    VStack{
                        
                    }
                }
                Text("Type A Citation: \(selectedFacility.numberOtherTypeA)")
                Text("Type B Citation: \(selectedFacility.numberOtherTypeB)")
                
            }
        }
    }
}

struct VisitsView_Previews: PreviewProvider {
    static var previews: some View {
        VisitsView(selectedFacility: FacilityDetail(capacity: "", city: "", contact: "", county: "", districtOffice: "", doAddress: "", doCity: "", doState: "", doPhone: "", doZip: "", facilityName: "", facilityNumber: "", facilityType: "", lastVisitDate: "", effectiveLicensedDate: "", firstLicensedDate: "", licenseeName: "", numberAllVisits: "", numberComplaintVisits: "", numberComplaintsTypeA: "", numberComplaintsTypeB: "", numberComplaintsInconclusive: "", numberComplaintsunsubstantiated: "", numberComplaintsSubstantiated: "", numberComplaintsUnfounded: "", numberInspectionVisits: "", numberInspectionsTypeA: "", numberInspectionsTypeB: "", numberOtherVisits: "", numberOtherTypeA: "", numberOtherTypeB: "", state: "", status: "", street: "", phone: "", allVisitDates: "", completVisitDates: "", inspectionVisitDates: "", otherVisitDates: "", zip: "", totalComplaintVisits: "", totalSubstantiatedAllegations: "", totalInconclusiveAllegations: "", totalUnsubstantiatesAllegations: "", totalUnfoundedAllegations: "", totalTypeA: "", totalTypeB: "", complaintCount: 0, complaints: [Complaint(controlNumber: "", approveDate: "", substantiatedAllegations: "", inconclusiveAllegations: "", unsubstantiatedAllegations: "", unfoundedAllegations: "", citationsTypeA: "", citationsTypeB: "", numberComplaintVisits: "", complaintVisitDates: "")]))
    }
}
