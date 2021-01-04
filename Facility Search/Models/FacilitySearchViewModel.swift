//
//  FacilitySearchViewModel.swift
//  Facility Search
//
//  Created by Doug Meeker on 1/1/21.
//

import Foundation

class FacilitySearchViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded([facilitySearch])
    }
    @Published private(set) var state = State.idle
     
    private let parameters: facilitySearchParameters
    
    init(parameters: facilitySearchParameters) {
        self.parameters = parameters
    }
    
    func load() {
        state = .loading
        DataService.shared.fetchFacilityList(parameters: parameters) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    var list = data
                    list.sort { $0.FACILITYNAME < $1.FACILITYNAME }
                    self?.state = .loaded(list)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.state = .failed(error)
                }
            }
        }
    }
}
