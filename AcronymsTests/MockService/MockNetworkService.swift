//
//  MockAcronymService.swift
//  AcronymsTests
//
//  Created by Pattrick DO on 8/10/22.
//

import Foundation
@testable import Acronyms

class MockNetworkService: NetworkServicing {
    
    var expectedData: Data?
    var delayOnRequest: Double = 3.0
    
    func getResponse<T>(for request: URLRequest, decodeAs: T.Type, completion: ((Result<T, APIError>) -> Void)?) where T : Decodable {
        guard let data = expectedData else {
            completion?(.failure(.noData))
            return
        }
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            completion?(.success(model))
        } catch  {
            completion?(.failure(.decodingError(error)))
        }
    }
    
}
