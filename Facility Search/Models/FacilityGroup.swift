//
//  FacilityTypes.swift
//  Facility Search
//
//  Created by Doug Meeker on 12/15/20.
//

import Foundation

struct FacilityGroups: Decodable {
    var groups: [FacilityGroup]
}

struct FacilityGroup: Decodable {
    var id: String
    var name: String
    var sortOrder: Int
    var types: [FacilityType]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "display_name"
        case sortOrder = "display_order"
        case types = "facility_type"
    }
}

struct FacilityType: Decodable{
    var id: Int
    var name: String
    var description: String
    var nameSearchMode: SearchMode
    var streetSearchMode: SearchMode
    var citySearchMode: SearchMode
    var zipSearchMode: SearchMode
    var countySearchMode: SearchMode
    var groupId: String
    var sortOrder: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "display_name"
        case description = "description"
        case nameSearchMode = "facility_name_search_mode"
        case streetSearchMode = "street_search_mode"
        case citySearchMode = "city_search_mode"
        case zipSearchMode = "zip_search_mode"
        case countySearchMode = "county_search_mode"
        case groupId = "facility_group_id"
        case sortOrder = "display_order"
    }
}

enum SearchMode: String, Decodable {
    case disabled
    case exact
    case optional
}
