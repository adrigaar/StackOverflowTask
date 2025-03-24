//
//  UserTests.swift
//  StackOverflow TaskTests
//
//  Created by Thomas on 24/03/2025.
//

import XCTest
@testable import StackOverflow_Task

final class UserTests: XCTestCase {
    
    var sut: User!
    
    override func setUp() {
        sut = User(name: "testUser")
    }
    
    func user_containsName() {
        XCTAssertNotNil(sut.name)
    }
    
}
