//
//  BundleUtils.swift
//  AcronymsTests
//
//  Created by Pattrick Do on 8/10/22.
//

import Foundation

import Foundation

class BundleUtils {
    
    static let shared = BundleUtils()

    func loadDataFromBundle(filename: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: filename, ofType: "json") {
            do {
                return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            }
            catch {
                return nil
            }
        }
        return nil
    }
    
}
