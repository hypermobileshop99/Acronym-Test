//
//  NetworkService.swift
//  Acronyms
//
//  Created by Pattrick Do on 8/10/22.
//

import Foundation

enum APIError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    
    var errorMessage: String {
        switch self {
        case APIError.transportError:
            return "Can not connect target URL"
        case APIError.serverError(let statusCode):
            return "Server Error with \(statusCode)"
        case APIError.noData:
            return "No Data"
        case APIError.decodingError:
            return "Decoding Error"
        }
    }
}

protocol NetworkServicing: AnyObject {
    
    func getResponse<T: Decodable>(for request: URLRequest, decodeAs: T.Type, completion: ((Result<T, APIError>) -> Void)?)
    
}

class NetworkService: NetworkServicing {
    
    static let shared = NetworkService()
    
    func getResponse<T>(for request: URLRequest, decodeAs: T.Type, completion: ((Result<T, APIError>) -> Void)?) where T : Decodable {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion?(.failure(.transportError(error)))
                return
            }
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion?(.failure(.serverError(statusCode: response.statusCode)))
            }
            guard let data = data else {
                completion?(.failure(.noData))
                return
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion?(.success(response))
            } catch {
                completion?(.failure(.decodingError(error)))
            }

        }
        task.resume()
    }
    
}
