//
//  Facility.swift
//  Facility Search
//
//  Created by Doug Meeker on 12/13/20.
//


//https://www.ccld.dss.ca.gov/transparencyapi/api/FacilityDetail/075202505

import Foundation

struct FacilityDetailRoot: Decodable{
    var FacilityDetail: FacilityDetail
    var TSO: TSO
}

struct FacilityDetail: Decodable{
    var capacity: String
    var city: String
    var contact: String
    var county: String
    var districtOffice: String
    var doAddress: String
    var doCity: String
    var doState: String
    var doPhone: String
    var doZip: String
    var facilityName: String
    var facilityNumber: String
    var facilityType: String
    var lastVisitDate: String
    var effectiveLicensedDate: String
    var firstLicensedDate: String
    var licenseeName: String
    var numberAllVisits: String
    var numberComplaintVisits: String
    var numberComplaintsTypeA: String
    var numberComplaintsTypeB: String
    var numberComplaintsInconclusive: String
    var numberComplaintsunsubstantiated: String
    var numberComplaintsSubstantiated: String
    var numberComplaintsUnfounded: String
    var numberInspectionVisits: String
    var numberInspectionsTypeA: String
    var numberInspectionsTypeB: String
    var numberOtherVisits: String
    var numberOtherTypeA: String
    var numberOtherTypeB: String
    var state: String
    var status: String
    var street: String
    var phone: String
    var allVisitDates: String
    var completVisitDates: String
    var inspectionVisitDates: String
    var otherVisitDates: String
    var zip: String
    var totalComplaintVisits: String
    var totalSubstantiatedAllegations: String
    var totalInconclusiveAllegations: String
    var totalUnsubstantiatesAllegations: String
    var totalUnfoundedAllegations: String
    var totalTypeA: String
    var totalTypeB : String
    var complaintCount: Int
    var complaints: [Complaint?]
    var phoneDigits: String { return phone.replacingOccurrences(of: "[()\\s-]+", with: "", options: .regularExpression)}
    var doPhoneDigits: String { return doPhone.replacingOccurrences(of: "[()\\s-]+", with: "", options: .regularExpression)}
    var mapLink: String {
        let link =  "http://maps.apple.com/?address=\(street),\(city),\(state)"
        return link.replacingOccurrences(of: "[\\s]+", with: "+", options: .regularExpression)
    }
    var doMapLink: String {
        let link =  "http://maps.apple.com/?address=\(doAddress),\(doCity),\(doState)"
        return link.replacingOccurrences(of: "[\\s]+", with: "+", options: .regularExpression)
    }
    var rcfeType: Bool { facilityType == "RESIDENTIAL CARE ELDERLY" || facilityType == "RCFE-CONTINUING CARE RETIREMENT COMMUNITY"}
    var cmpDetails: [String] {
        var data = [""]
        for item in complaints {
            if (Int(item?.inconclusiveAllegations ?? "") ?? 0 >= 0) {
                data.append("Complaint Investigation Completed: \(item?.approveDate ?? "")")
                data.append("# Allegations Substantiated: \(item?.substantiatedAllegations ?? "" )")
                data.append("# Allegations Inconclusive: \( item?.inconclusiveAllegations ?? "" )")
            }
            if (Int(item?.unsubstantiatedAllegations ?? "") ?? 0 >= 0) {
                data.append("Complaint Investigation Completed: \(item?.approveDate ?? "")")
                data.append("# Allegations Substantiated: \(item?.substantiatedAllegations ?? "")")
                data.append("# Allegations Unsubstantiated: \(item?.unsubstantiatedAllegations ?? "" )")
            }
            
            if (rcfeType){
                data.append("# Allegations Unfounded: \( item?.unfoundedAllegations ?? "")")
            }
            data.append("Type A Citations: \(item?.citationsTypeA ?? "")")
            data.append("Type B Citations: \(item?.citationsTypeB  ?? "")")
            data.append("# of Visits: \(item?.numberComplaintVisits ?? "")")
            data.append("Dates of Visits: \(item?.complaintVisitDates ?? "")")
            data.append("")
        }
        return data
    }
    
    enum CodingKeys: String, CodingKey {
        case capacity = "CAPACITY"
        case city = "CITY"
        case contact = "CONTACT"
        case county = "COUNTY"
        case districtOffice = "DISTRICTOFFICE"
        case doAddress = "DOADDRESS"
        case doCity = "DOCITY"
        case doState = "DOSTATE"
        case doPhone = "DOTELEPHONE"
        case doZip = "DOZIPCODE"
        case facilityName = "FACILITYNAME"
        case facilityNumber = "FACILITYNUMBER"
        case facilityType = "FACILITYTYPE"
        case lastVisitDate = "LASTVISITDATE"
        case effectiveLicensedDate = "LICENSEEFFECTIVEDATE"
        case firstLicensedDate = "LICENSEFIRSTDATE"
        case licenseeName = "LICENSEENAME"
        case numberAllVisits = "NBRALLVISITS"
        case numberComplaintVisits = "NBRCMPLTVISITS"
        case numberComplaintsTypeA = "NBRCMPLTTYPA"
        case numberComplaintsTypeB = "NBRCMPLTTYPB"
        case numberComplaintsInconclusive = "NBRCMPLTINC"
        case numberComplaintsunsubstantiated = "NBRCMPLTUNS"
        case numberComplaintsSubstantiated = "NBRCMPLTSUB"
        case numberComplaintsUnfounded = "NBRCMPLTUNF"
        case numberInspectionVisits = "NBRINSPVISITS"
        case numberInspectionsTypeA = "NBRINSPTYPA"
        case numberInspectionsTypeB = "NBRINSPTYPB"
        case numberOtherVisits = "NBROTHERVISITS"
        case numberOtherTypeA = "NBROTHERTYPA"
        case numberOtherTypeB = "NBROTHERTYPB"
        case state = "STATE"
        case status = "STATUS"
        case street = "STREETADDRESS"
        case phone = "TELEPHONE"
        case allVisitDates = "VSTDATEALL"
        case completVisitDates = "VSTDATECMPLT"
        case inspectionVisitDates = "VSTDATEINSP"
        case otherVisitDates = "VSTDATEOTHER"
        case zip = "ZIPCODE"
        case totalComplaintVisits = "TOTCMPVISITS"
        case totalSubstantiatedAllegations = "TOTSUBALG"
        case totalInconclusiveAllegations = "TOTINCALG"
        case totalUnsubstantiatesAllegations = "TOTUNSALG"
        case totalUnfoundedAllegations = "TOTUNFALG"
        case totalTypeA = "TOTTYPEA"
        case totalTypeB = "TOTTYPEB"
        case complaintCount = "CMPCOUNT"
        case complaints = "COMPLAINTARRAY"
    }
}

struct TSO: Decodable{
    var FacilityNumber: String
    var CaseClosed: Bool
    var PleadingDate: String
    var ActionType: String
}

struct Complaint: Decodable{
    var controlNumber: String
    var approveDate: String
    var substantiatedAllegations: String
    var inconclusiveAllegations: String
    var unsubstantiatedAllegations: String
    var unfoundedAllegations: String
    var citationsTypeA: String
    var citationsTypeB: String
    var numberComplaintVisits: String
    var complaintVisitDates: String
    
    enum CodingKeys: String, CodingKey {
        case  controlNumber = "CONTROLNUMBER"
        case  approveDate = "APPROVEDATE"
        case  substantiatedAllegations = "SUBALLEGATIONS"
        case  inconclusiveAllegations = "INCALLEGATIONS"
        case  unsubstantiatedAllegations = "UNSALLEGATIONS"
        case  unfoundedAllegations = "UNFALLEGATIONS"
        case  citationsTypeA = "CITTYPEA"
        case  citationsTypeB = "CITTYPEB"
        case  numberComplaintVisits = "NUMCMPVISITS"
        case  complaintVisitDates = "CMPVISITDATES"
    }
}
