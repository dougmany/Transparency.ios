//
//  ReportList.swift
//  Facility Search
//
//  Created by Doug Meeker on 12/23/20.
//

import Foundation

struct ReportList: Decodable {
    var count: Int
    var reports: [ReportInfo?]
    
    enum CodingKeys: String, CodingKey {
        case count = "COUNT"
        case reports = "REPORTARRAY"
    }
}

struct ReportInfo: Decodable {
    var controlNumber: String
    var facilityNumber: String
    var date: String
    var title: String
    var type: String
    var page: String
    
    enum CodingKeys: String, CodingKey {
        case controlNumber = "CONTROLNUMBER"
        case facilityNumber = "FACILITYNUMBER"
        case date = "REPORTDATE"
        case title = "REPORTTITLE"
        case type = "REPORTTYPE"
        case page = "REPORTPAGE"
    }
}

