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

enum ApiError: Error {
    case badRequest
}

class facilitySearchParameters: ObservableObject {
    var type: facilityType
    
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
    @Published var Street: String {
        didSet {
            UserDefaults.standard.set(Street, forKey: "Street")
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
            "Street": Street,
            "city": city,
            "zip": zip,
            "county": county,
            "facnum": facnum
        ]
    }
    init(facilityType: facilityType){
        self.type = facilityType
        self.facType = "\(facilityType.id)"
        self.facility = UserDefaults.standard.object(forKey: "facility") as? String ?? ""
        self.Street = self.type.street_search_mode == "disabled" ? "": UserDefaults.standard.object(forKey: "Street") as? String ?? ""
        self.city = self.type.city_search_mode == "disabled" ? "":UserDefaults.standard.object(forKey: "city") as? String ?? ""
        self.zip = self.type.zip_search_mode == "disabled" ? "":UserDefaults.standard.object(forKey: "zip") as? String ?? ""
        self.county = self.type.county_search_mode == "disabled" ? "":UserDefaults.standard.object(forKey: "county") as? String ?? ""
        self.facnum = UserDefaults.standard.object(forKey: "facnum") as? String ?? ""
    }
}
