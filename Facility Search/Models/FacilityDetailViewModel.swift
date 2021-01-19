//
//  FacilityDetailViewModel.swift
//  Facility Search
//
//  Created by Doug Meeker on 1/1/21.
//

import Foundation

class FacilityDetailViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded(FacilityDetailRoot)
    }
    @Published private(set) var state = State.idle
    
    private let facilityNumber: String
    
    init(facilityNumber: String) {
        self.facilityNumber = facilityNumber
    }
     
    func load() {
        state = .loading
        DataService.shared.fetchFacilityDetail(facilityNumber: facilityNumber) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.state = .loaded(data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.state = .failed(error)
                }
            }
        }
    }
}
