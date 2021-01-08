//
//  DataService.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/19/20.
//

import Foundation

class DataService {
    static let shared = DataService()

    func createURLComponents(path: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.ccld.dss.ca.gov"
        components.path = path
        
        return components
    }
    
    func fetchFacilityGroups(completion: @escaping (Result<FacilityGroups, Error>) -> Void) {
        
        let componentURL = createURLComponents(path: "/transparencyapi/api/group")
        
        guard let validURL = componentURL.url else {
            print("URL creation failed...")
            return
        }
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let groups = FacilityGroups(groups: try JSONDecoder().decode([FacilityGroup].self, from: validData))
                
                completion(.success(groups))
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func fetchFacilityDetail(facilityNumber: String, completion: @escaping (Result<FacilityDetail, Error>) -> Void) {
        
        let componentURL = createURLComponents(path: "/transparencyapi/api/FacilityDetail/\(facilityNumber)")
        
        guard let validURL = componentURL.url else {
            print("URL creation failed...")
            return
        }
        
        print(validURL)
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let detailRoot = try JSONDecoder().decode(FacilityDetailRoot.self, from: validData)
                completion(.success(detailRoot.FacilityDetail))
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume()
    }
    
    func fetchFacilityList(parameters: facilitySearchParameters, completion: @escaping (Result<[FacilitySearch], Error>) -> Void) {
        
        var componentURL = createURLComponents(path: "/transparencyapi/api/FacilitySearch/")
        componentURL.queryItems = parameters.dictionaryRepresentation.map {
            URLQueryItem(name: $0, value: $1)
        }
        
        guard let validURL = componentURL.url else {
            print("URL creation failed...")
            return
        }
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 400 {
                    completion(.failure(ApiError.badRequest))
                    return
                }
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let detailRoot = try JSONDecoder().decode(FacilitySearchRoot.self, from: validData)
                completion(.success(detailRoot.facilities))
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume()
    }
    
    //https://www.ccld.dss.ca.gov/transparencyapi/api/FacilityReports?facNum=340317938&inx=0
    func fetchFacilityReport(facilityNumber: String, index: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        var componentUrl = createURLComponents(path: "/transparencyapi/api/FacilityReports/")
        componentUrl.queryItems = [ URLQueryItem(name: "facNum", value: facilityNumber), URLQueryItem(name: "inx", value: index) ]
        
        guard let validURL = componentUrl.url else {
            print("URL creation failed...")
            return
        }
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            let data = String(decoding: validData, as: UTF8.self)
            completion(.success(data))
            
        }.resume()
    }
    
    func fetchFacilityReportList(facilityNumber: String, completion: @escaping (Result<[ReportInfo], Error>) -> Void) {
        
        let componentUrl = createURLComponents(path: "/transparencyapi/api/FacilityReports/\(facilityNumber)")
        
        guard let validURL = componentUrl.url else {
            print("URL creation failed...")
            return
        }
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let data = try JSONDecoder().decode(ReportList.self, from: validData)
                completion(.success(data.reports))
            } catch let serializationError {
                completion(.failure(serializationError))
            }
            
        }.resume()
    }
    
    //https://www.ccld.dss.ca.gov/transparencyapi/api/FAQ?mode=Public&id=full
    func fetchFaq( completion: @escaping (Result<String, Error>) -> Void) {
        
        var componentUrl = createURLComponents(path: "/transparencyapi/api/faq")
        componentUrl.queryItems = [ URLQueryItem(name: "mode", value: "Public"), URLQueryItem(name: "id", value: "full") ]
          

            guard let validURL = componentUrl.url else {
                print("URL creation failed...")
                return
            }
            
            URLSession.shared.dataTask(with: validURL) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("API status: \(httpResponse.statusCode)")
                }
                
                guard let validData = data, error == nil else {
                    completion(.failure(error!))
                    return
                }

                let data = String(decoding: validData, as: UTF8.self)
                completion(.success(data))
                
            }.resume()
    }
    
    // https://www.ccld.dss.ca.gov/transparencyapi/api/Glossary
    func fetchGlossary( completion: @escaping (Result<String, Error>) -> Void) {
        
        let componentUrl = createURLComponents(path: "/transparencyapi/api/glossary")

            guard let validURL = componentUrl.url else {
                print("URL creation failed...")
                return
            }
            
            URLSession.shared.dataTask(with: validURL) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("API status: \(httpResponse.statusCode)")
                }
                
                guard let validData = data, error == nil else {
                    completion(.failure(error!))
                    return
                }

                let data = String(decoding: validData, as: UTF8.self)
                completion(.success(data))
                
            }.resume()
    }
}
