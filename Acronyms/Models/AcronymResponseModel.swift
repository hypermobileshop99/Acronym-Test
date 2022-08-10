//
//  AcronymResponseModel.swift
//  Acronyms
//
//  Created by Pattrick Do on 8/10/22.
//

import Foundation

struct AcronymResponseModel: Codable {
    let sf: String
    let lfs: [LF]
}

struct LF: Codable {
    let lf: String
    let freq, since: Int
    let vars: [LF]?
}
