//
//  FacilityGroupViewModel.swift
//  Facility Search
//
//  Created by Doug Meeker on 1/1/21.
//

import Foundation

class FacilityGroupViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded([FacilityGroup])
    }
    @Published private(set) var state = State.idle
     
    func load() {
        state = .loading
        DataService.shared.fetchFacilityGroups() { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    var facilityTypes = data.groups
                    facilityTypes.sort { $0.sortOrder < $1.sortOrder }
                    self?.state = .loaded(facilityTypes)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.state = .failed(error)
                }
            }
        }
    }
}
