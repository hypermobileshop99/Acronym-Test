//
//  AcronymService.swift
//  Acronyms
//
//  Created by Pattrick Do on 8/10/22.
//

import Foundation

protocol AcronymServicing {
    func fetchAcronym(initialism: String, completion: ((Result<[AcronymResponseModel], APIError>) -> Void)?)
}

class AcronymService: AcronymServicing {
    
    let networkService: NetworkServicing
    
    init(networkService: NetworkServicing = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func fetchAcronym(initialism: String, completion: ((Result<[AcronymResponseModel], APIError>) -> Void)?) {
        let request = NetworkRequest.getAcronym(initialism: initialism).createRequest()
        networkService.getResponse(for: request, decodeAs: [AcronymResponseModel].self) { result in
            completion?(result)
        }
    }
    
}
