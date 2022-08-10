//
//  NetworkRequest.swift
//  Acronyms
//
//  Created by Pattrick Do on 8/10/22.
//

import Foundation

enum NetworkRequest {
    
    static let baseUrlString = "http://www.nactem.ac.uk/software/acromine/dictionary.py"
    static func url(with components: String) -> URL {
        return URL(string: "\(Self.baseUrlString)\(components)")!
    }
    
    case getAcronym(initialism: String)
}

extension NetworkRequest {
    var method: String {
        switch self {
        case .getAcronym:
            return "GET"
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .getAcronym:
            return nil
        }
    }
    
    var headers: Dictionary<String, String>? {
        switch self {
        case .getAcronym:
            return nil
        }
    }
    
    var url: URL {
        switch self {
        case .getAcronym(let initialism):
            return NetworkRequest.url(with: "?sf=\(initialism)")
        }
    }
    
    func createRequest() -> URLRequest {
        let url = self.url
        var request = URLRequest(url: url)
        request.httpMethod = self.method
        request.httpBody = self.httpBody
        if let headers = self.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
}
