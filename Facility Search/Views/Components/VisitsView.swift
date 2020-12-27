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
        VStack {
            Text("All Visits: \(selectedFacility.NBRALLVISITS)")
            Text(selectedFacility.VSTDATEALL)
        }
        Divider()
        VStack{
            Text("Citations")
            Text("Type A Citation: \((Int(selectedFacility.NBRCMPLTTYPA) ?? 0) + (Int(selectedFacility.NBRINSPTYPA) ?? 0))")
            Text("Type B Citation: \((Int(selectedFacility.NBRCMPLTTYPB) ?? 0) + (Int(selectedFacility.NBRINSPTYPB) ?? 0))")
            
        }
        Divider()
        VStack {
            Text("Inspections: \(selectedFacility.NBRINSPVISITS)")
            Text(selectedFacility.VSTDATEINSP)
            Text("Type A Citation: \(selectedFacility.NBRINSPTYPA)")
            Text("Type B Citation: \(selectedFacility.NBRINSPTYPB)")
        }
        Divider()
        Group{
            VStack{
                Text("Complaints")
                Text("Total Complaint Investigations Completed: \(selectedFacility.CMPCOUNT)")
                Text("Total Allegations Substantiated: \(selectedFacility.NBRCMPLTSUB)")
                Text("Total Allegations Inconclusive: \(selectedFacility.NBRCMPLTINC)")
                Text("Total Allegations Unsubstantiated: \(selectedFacility.NBRCMPLTUNS)")
                if selectedFacility.RcfeType {
                    Text("Total Allegations Unfounded: \(selectedFacility.NBRCMPLTUNF)")
                }
                Text("Type A Citation: \(selectedFacility.NBRCMPLTTYPA)")
                Text("Type B Citation: \(selectedFacility.NBRCMPLTTYPB)")
                Text("Total Complaint Visits: \(selectedFacility.NBRCMPLTVISITS)")
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
            Text("Type A Citation: \(selectedFacility.NBROTHERTYPA)")
            Text("Type B Citation: \(selectedFacility.NBROTHERTYPB)")
            
        }
    }
}
