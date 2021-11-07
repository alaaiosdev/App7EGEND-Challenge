//
//  MockLoader.swift
//  App7EGEND Challenge
//
//  Created by alaa ajoury on 30/10/2021.
//

import Foundation

enum MockLoaderError: Error, CustomStringConvertible {
    case invalidFileName(String)
    case invalidFileURL(URL)
    case invalidJSON(String)
    var description: String {
        switch self {
        case .invalidFileName(let name): return "\(name) FileName is incorrect"
        case .invalidFileURL(let url): return "\(url) FilePath is incorrect"
        case .invalidJSON(let name): return "\(name) has Invalid JSON"
        }
    }
}

struct MockLoader {
    
    static func loadMockFile(named fileName:String,bundle:Bundle = .main) throws -> TripsModel {
        guard let url = bundle.url(forResource: fileName, withExtension: nil) else { throw MockLoaderError.invalidFileName(fileName) }
        do {
            let data = try Data.init(contentsOf: url)
            if let _ = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? [String:Any] {
                let trips = try JSONDecoder().decode(TripsModel.self, from: data)
                return trips
            } else {
                throw MockLoaderError.invalidFileURL(url)
            }
        } catch {
            throw MockLoaderError.invalidJSON(fileName)
        }
    }
    
    static func loadAPIResponse(response: [String: Any]) throws -> TripsModel {
        let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
        do {
            let trips = try JSONDecoder().decode(TripsModel.self, from: data)
            return trips
        } catch {
            throw MockLoaderError.invalidJSON("Input Response")
        }
    }
}
