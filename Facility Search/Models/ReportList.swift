//
//  ReportList.swift
//  Facility Search
//
//  Created by Doug Meeker on 12/23/20.
//

import Foundation

struct ReportList: Decodable {
    var COUNT: Int
    var REPORTARRAY: [ReportInfo]
}

struct ReportInfo: Decodable {
    var CONTROLNUMBER: String
    var FACILITYNUMBER: String
    var REPORTDATE: String
    var REPORTTITLE: String
    var REPORTTYPE: String
    var REPORTPAGE: String
}

