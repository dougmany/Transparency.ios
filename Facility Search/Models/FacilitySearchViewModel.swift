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
        case loaded([FacilitySearch])
    }
    @Published private(set) var state = State.idle
    
    var dissabledWithDate: [String]
     
    private let parameters: facilitySearchParameters
    
    init(parameters: facilitySearchParameters) {
        self.parameters = parameters
        self.dissabledWithDate = parameters.dissabledWithData
    }
    
    func load() {
        state = .loading
        DataService.shared.fetchFacilityList(parameters: parameters) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    var list = data
                    list.sort { $0.facilityName < $1.facilityName }
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
