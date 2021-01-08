//
//  ReportsVIew.swift
//  Facility Search
//
//  Created by Doug Meeker on 12/26/20.
//

import SwiftUI

struct ReportsView: View {
    @ObservedObject var viewModel : ReportListViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.load)
        case .loading:
            Text("Loading...")
        case .failed(let error):
            Text("An error occured...\(error.localizedDescription)")
        case .loaded(let reportList):
            VStack{
                Text("Reports")
                List(reportList, id: \.element.date) { index, report in
                    NavigationLink("\(report.title) - \(report.date)", destination: ReportView(selectedFacilityNumber: report.facilityNumber, selectedIndex: "\(index)" ))
                }
            }
        }
    }
    
    struct Reports_Previews: PreviewProvider {
        static var previews: some View {
            ReportsView(viewModel: ReportListViewModel(facilityNumber: "111111111"))
        }
    }
}
