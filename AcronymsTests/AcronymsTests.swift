//
//  AcronymsTests.swift
//  AcronymsTests
//
//  Created by Pattrick Do on 8/10/22.
//

import XCTest
@testable import Acronyms

class AcronymsTests: XCTestCase {

    var mockAcronymService: AcronymService!
    
    override func setUp() {
        super.setUp()
        mockAcronymService = AcronymService(networkService: MockNetworkService())
    }
    
    func testFectchAcronyms() {
        guard let service = mockAcronymService.networkService as? MockNetworkService else {
            XCTAssert(false, "MockNetworkService initialization failed.")
            return
        }
        let promise = expectation(description: "Status code: 200")
        service.expectedData = BundleUtils.shared.loadDataFromBundle(filename: "MockAcronymResponse")
        service.getResponse(for: URLRequest(url: URL(string: "https://google.com")!), decodeAs: [AcronymResponseModel].self) { result in
            switch result {
            case .failure:
                XCTAssert(true, "Failed get acronym")
            default:
                break
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: service.delayOnRequest + 2)
    }

}
