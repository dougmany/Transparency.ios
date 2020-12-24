//
//  ReportView.swift
//  Facility Search
//
//  Created by Doug Meeker on 12/23/20.
//

import SwiftUI

struct ReportView: View {
    let selectedFacilityNumber: String
    let selectedIndex: String
    
    @State var report = "<h1>Loading...</h1>"
    
    var body: some View {
        HTMLStringView(htmlContent: report)
            .onAppear(perform: loadData)
    }
    
    func loadData(){
        DataService.shared.fetchFacilityReport(facilityNumber: selectedFacilityNumber, index: selectedIndex) { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let data):
                        if data.count == 0 {
                            report = "Not found"
                        } else {
                            self.report = data
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}


struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView(selectedFacilityNumber: "111111111", selectedIndex: "1")
    }
}
