//
//  FacilityTypes.swift
//  Facility Search
//
//  Created by Doug Meeker on 12/15/20.
//

import Foundation

struct facilityGroups: Decodable{
    var groups: [facilityGroup]
}

struct facilityGroup: Decodable{
    var id: String
    var display_name: String
    var display_order: Int
    var facility_type: [facilityType]
}

struct facilityType: Decodable{
    var id: Int
    var display_name: String
    var description: String
    var facility_name_search_mode: String
    var street_search_mode: String
    var city_search_mode: String
    var zip_search_mode: String
    var county_search_mode: String
    var facility_group_id: String
    var display_order: Int
}
