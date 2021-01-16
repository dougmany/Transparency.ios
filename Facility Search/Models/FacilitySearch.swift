//
//  FacilitySearch.swift
//  Facility Search
//
//  Created by Doug Meeker on 12/14/20.
//

//https://www.ccld.dss.ca.gov/transparencyapi/api/FacilitySearch?facType=400&facility=&Street=&city=&zip=&county=&facnum=
import Foundation

struct FacilitySearchRoot: Decodable {
    var count: Int
    var facilities: [FacilitySearch]
    
    enum CodingKeys: String, CodingKey {
        case count = "COUNT"
        case facilities = "FACILITYARRAY"
    }
    
}

struct FacilitySearch: Decodable{
    var county: String
    var facilityName: String
    var facilityNumber: String
    var status: String
    var street:String
    var phone:String
    var zip: String
    
    enum CodingKeys: String, CodingKey{
        case county = "COUNTY"
        case facilityName = "FACILITYNAME"
        case facilityNumber = "FACILITYNUMBER"
        case status = "STATUS"
        case street = "STREETADDRESS"
        case phone = "TELEPHONE"
        case zip = "ZIPCODE"
    }
}

enum ApiError: Error {
    case badRequest
}

class facilitySearchParameters: ObservableObject {
    var type: FacilityType
    var dissabledWithData: [String]
    
    @Published var facType: String {
        didSet {
            UserDefaults.standard.set(facType, forKey: "facType")
        }
    }
    @Published var facility: String {
        didSet {
            UserDefaults.standard.set(facility, forKey: "facility")
        }
    }
    @Published var street: String {
        didSet {
            UserDefaults.standard.set(street, forKey: "street")
        }
    }
    @Published var city: String {
        didSet {
            UserDefaults.standard.set(city, forKey: "city")
        }
    }
    @Published var zip: String {
        didSet {
            UserDefaults.standard.set(zip, forKey: "zip")
        }
    }
    @Published var county: String {
        didSet {
            UserDefaults.standard.set(county, forKey: "county")
        }
    }
    public let counties = ["","Alameda", "Alpine", "Amador","Butte","Calaveras","Colusa","Contra Costa","Del Norte","El Dorado",
"Fresno","Glenn","Humboldt","Imperial","Inyo","Kern","Kings","Lake","Lassen","Los Angeles","Madera",
"Marin","Mariposa","Mendocino","Merced","Modoc","Mono","Monterey","Napa","Nevada","Orange","Placer",
"Plumas","Riverside","Sacramento","San Benito","San Bernardino","San Diego","San Francisco","San Joaquin",
"San Luis Obispo","San Mateo","Santa Barbara","Santa Clara","Santa Cruz","Shasta","Sierra","Siskiyou",
"Solano","Sonoma","Stanislaus","Sutter","Tehama","Trinity","Tulare","Tuolumne","Ventura","Yolo","Yuba"]
    
    @Published var facnum: String {
        didSet {
            UserDefaults.standard.set(facnum, forKey: "facnum")
        }
    }
    var dictionaryRepresentation: [String: String] {
        return [
            "facType": facType,
            "facility": facility,
            "Street": street,
            "city": city,
            "zip": zip,
            "county": county,
            "facnum": facnum
        ]
    }
    init(facilityType: FacilityType){
        self.type = facilityType
        self.facType = "\(facilityType.id)"
        self.dissabledWithData = []
        self.facility = UserDefaults.standard.object(forKey: "facility") as? String ?? ""
        self.street = ""
        if let street: String = UserDefaults.standard.object(forKey: "street") as! String? {
            if(street != "" && facilityType.streetSearchMode == .disabled ){
                dissabledWithData.append("Street")
            }
            else{
                self.street = street
            }
        }
        self.city = ""
        if let city: String = UserDefaults.standard.object(forKey: "city") as! String? {
            if(city != "" && facilityType.citySearchMode == .disabled ){
                dissabledWithData.append("City")
            }
            else{
                self.city = city
            }
        }
        self.zip = ""
        if let zip: String = UserDefaults.standard.object(forKey: "zip") as! String? {
            if(zip != "" && facilityType.zipSearchMode == .disabled ){
                dissabledWithData.append("Zip")
            }
            else{
                self.zip = zip
            }
        }
        self.county = ""
        if let county: String = UserDefaults.standard.object(forKey: "county") as! String? {
            if(county != "" && facilityType.countySearchMode == .disabled ){
                dissabledWithData.append("County")
            }
            else{
                self.county = county
            }
        }
        self.facnum = UserDefaults.standard.object(forKey: "facnum") as? String ?? ""
    }
}
