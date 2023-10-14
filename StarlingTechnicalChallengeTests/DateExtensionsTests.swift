//
//  DateExtensionsTests.swift
//  StarlingTechnicalChallengeTests
//
//  Created by Alex Ioja-Yang on 14/10/2023.
//

import XCTest
@testable import StarlingTechnicalChallenge

final class DateExtensionsTests: XCTestCase {
    
    func testFormatForNetworkCall() {
        let testDate = Date(timeIntervalSince1970: 41256732879)
        let expectedResult = "3277-05-16"
        
        XCTAssertEqual(testDate.dateFormattedForNetworkCall(), expectedResult)
    }
    
}
