//
//  Facility.swift
//  Facility Search
//
//  Created by Doug Meeker on 12/13/20.
//


//https://www.ccld.dss.ca.gov/transparencyapi/api/FacilityDetail/075202505

import Foundation

struct facilityDetailRoot: Decodable{
    var FacilityDetail: FacilityDetail
    var TSO: TSO
}

struct FacilityDetail: Decodable{
    var CAPACITY: String
    var CITY: String
    var CONTACT: String
    var COUNTY: String
    var DISTRICTOFFICE: String
    var DOADDRESS: String
    var DOCITY: String
    var DOSTATE: String
    var DOTELEPHONE: String
    var DOZIPCODE: String
    var FACILITYNAME: String
    var FACILITYNUMBER: String
    var FACILITYTYPE: String
    var LASTVISITDATE: String
    var LICENSEEFFECTIVEDATE: String
    var LICENSEFIRSTDATE: String
    var LICENSEENAME: String
    var NBRALLVISITS: String
    var NBRCMPLTVISITS: String
    var NBRCMPLTTYPA: String
    var NBRCMPLTTYPB: String
    var NBRCMPLTINC: String
    var NBRCMPLTUNS: String
    var NBRCMPLTSUB: String
    var NBRCMPLTUNF: String
    var NBRINSPVISITS: String
    var NBRINSPTYPA: String
    var NBRINSPTYPB: String
    var NBROTHERVISITS: String
    var NBROTHERTYPA: String
    var NBROTHERTYPB: String
    var STATE: String
    var STATUS: String
    var STREETADDRESS: String
    var TELEPHONE: String
    var VSTDATEALL: String
    var VSTDATECMPLT: String
    var VSTDATEINSP: String
    var VSTDATEOTHER: String
    var ZIPCODE: String
    var TOTCMPVISITS: String
    var TOTSUBALG: String
    var TOTINCALG: String
    var TOTUNSALG: String
    var TOTUNFALG: String
    var TOTTYPEA: String
    var TOTTYPEB: String
    var CMPCOUNT: Int
    var COMPLAINTARRAY: [complaint?]
    var MapLink: String { "https//maps.apple.com/?address=\(STREETADDRESS),\(CITY),\(STATE)"}
}

struct TSO: Decodable{
    var FacilityNumber: String
    var CaseClosed: Bool
    var PleadingDate: String
    var ActionType: String
}

struct complaint: Decodable{
    var CONTROLNUMBER: String
    var APPROVEDATE: String
    var SUBALLEGATIONS: String
    var INCALLEGATIONS: String
    var UNSALLEGATIONS: String
    var UNFALLEGATIONS: String
    var CITTYPEA: String
    var CITTYPEB: String
    var NUMCMPVISITS: String
    var CMPVISITDATES: String
}
