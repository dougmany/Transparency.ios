//
//  DataService.swift
//  FacilitySearch3
//
//  Created by Doug Meeker on 12/19/20.
//

import Foundation

class DataService {
    static let shared = DataService()
    fileprivate let baseURLString = "https://api.github.com"
    
    func createURLComponents(path: String) -> URLComponents {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "www.ccld.dss.ca.gov"
            components.path = path
            
            return components
        }
    
    func fetchFacilityGroups(completion: @escaping (Result<facilityGroups, Error>) -> Void) {
            
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
                        let groups = facilityGroups(groups: try JSONDecoder().decode([facilityGroup].self, from: validData))
                        
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
            
            URLSession.shared.dataTask(with: validURL) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("API status: \(httpResponse.statusCode)")
                }
                
                guard let validData = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                do {
                    let detailRoot = try JSONDecoder().decode(facilityDetailRoot.self, from: validData)
                    completion(.success(detailRoot.FacilityDetail))
                } catch let serializationError {
                    completion(.failure(serializationError))
                }
                
            }.resume()
    }
    
    func fetchFacilityList(parameters: facilitySearchParameters, completion: @escaping (Result<[facilitySearch], Error>) -> Void) {
        
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
                }
                
                guard let validData = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                do {
                    let detailRoot = try JSONDecoder().decode(facilitySearchRoot.self, from: validData)
                    completion(.success(detailRoot.FACILITYARRAY))
                } catch let serializationError {
                    completion(.failure(serializationError))
                }
                
            }.resume()
    }
}
