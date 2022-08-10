//
//  MainViewModel.swift
//  Acronyms
//
//  Created by Pattrick Do on 8/10/22.
//

import Foundation
import Combine

class MainViewModel {
    
    @Published var acronyms: AcronymResponseModel? = nil
    @Published var error: APIError? = nil
    
    private let acronymService: AcronymServicing
    
    init(acronymService: AcronymServicing) {
        self.acronymService = acronymService
    }
    
    func fetchAcronyms(initialism: String) {
        acronymService.fetchAcronym(initialism: initialism) { [weak self] result in
            switch result {
            case .success(let acronyms):
                self?.acronyms = acronyms.first
                self?.error = nil
            case .failure(let error):
                self?.acronyms = nil
                self?.error = error
            }
        }
    }
}
