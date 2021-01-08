//
//  ReportListViewModel.swift
//  Facility Search
//
//  Created by Doug Meeker on 1/1/21.
//

import Foundation

class ReportListViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded([EnumeratedSequence<([ReportInfo])>.Element])
    }
    @Published private(set) var state = State.idle
    
    private let facilityNumber: String
    
    init(facilityNumber: String) {
        self.facilityNumber = facilityNumber
    }
    
    func load() {
        state = .loading
        DataService.shared.fetchFacilityReportList(facilityNumber: facilityNumber) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let dateFormatter = DateFormatter();
                    var list = data
                    dateFormatter.dateFormat = "MM/dd/y??"
                    list.sort { dateFormatter.date(from: $0.date) ?? Date() > dateFormatter.date(from: $1.date) ?? Date()}
                    let reportList = list.enumerated().map({ $0 })
                    self?.state = .loaded(reportList)
                }
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }
}
