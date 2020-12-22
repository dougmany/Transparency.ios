//
//  FacilitySearch.swift
//  Facility Search
//
//  Created by Doug Meeker on 12/14/20.
//

//https://www.ccld.dss.ca.gov/transparencyapi/api/FacilitySearch?facType=400&facility=&Street=&city=&zip=&county=&facnum=
import Foundation

struct facilitySearchRoot: Decodable {
    var COUNT:Int
    var FACILITYARRAY:[facilitySearch]
}

struct facilitySearch: Decodable{
    var COUNTY: String
    var FACILITYNAME: String
    var FACILITYNUMBER: String
    var STATUS: String
    var STREETADDRESS:String
    var TELEPHONE:String
    var ZIPCODE: String
}

struct facilitySearchParameters: Decodable {
    var facType: String
    var facility: String
    var Street: String
    var city: String
    var zip: String
    var county: String
    var facnum: String
    var dictionaryRepresentation: [String: String] {
        return [
            "facType": facType,
            "facility": facility,
            "Street": Street,
            "city": city,
            "zip": zip,
            "county": county,
            "facnum": facnum
        ]
    }
}
