//
//  ReportsVIew.swift
//  Facility Search
//
//  Created by Doug Meeker on 12/26/20.
//

import SwiftUI

struct ReportsView: View {
    let selectedFacilityNumber: String
    
    @State var reportList = [ReportInfo(CONTROLNUMBER: "", FACILITYNUMBER: "", REPORTDATE: "", REPORTTITLE: "", REPORTTYPE: "", REPORTPAGE: "")].enumerated().map({ $0 })
    
    var body: some View {
        VStack{
            Text("Reports")
            List(reportList, id: \.element.REPORTDATE) { index, report in
                NavigationLink("\(report.REPORTTITLE) - \(report.REPORTDATE)", destination: ReportView(selectedFacilityNumber: selectedFacilityNumber, selectedIndex: "\(index)" ))
            }
        } .onAppear(perform: loadData)
    }

    func loadData() {
        DataService.shared.fetchFacilityReportList(facilityNumber: selectedFacilityNumber) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(var data):
                    let dateFormatter = DateFormatter();
                    dateFormatter.dateFormat = "MM/dd/y??"
                    data.sort { dateFormatter.date(from: $0.REPORTDATE) ?? Date() > dateFormatter.date(from: $1.REPORTDATE) ?? Date()}
                    reportList = data.enumerated().map({ $0 })
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    struct Reports_Previews: PreviewProvider {
        static var previews: some View {
            ReportsView(selectedFacilityNumber: "111111111")
        }
    }
}
