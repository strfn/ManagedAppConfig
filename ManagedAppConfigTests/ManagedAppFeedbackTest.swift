//
//  ManagedAppFeedbackTest.swift
//  ManagedAppConfigTests
//
//  Created by Michele_personal on 24/09/2017.
//  Copyright © 2017 Michele Simone. All rights reserved.
//

import XCTest
@testable import ManagedAppConfig

class ManagedAppFeedbackTest: XCTestCase {
    
    var MDMMock: MDMChannelMock!
    var testableObject: ManagedAppFeedback!
    
    override func setUp() {
        super.setUp()
        MDMMock = MDMChannelMock()
        testableObject = ManagedAppFeedback(with: MDMMock)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIsWritingFeedbackToTheRootDictionary() {
        
    }
    
    func testCanWriteString() {
        let value = "some feedback value"
        let key = "com.string"
        testableObject.send(value, for: key)
        XCTAssertEqual(MDMMock.feedbackValue(forKey: key), value, "Can send a string feedback")
    }

    func testCanWriteInteger() {
        let value = 1
        let key = "com.integer"
        testableObject.send(value, for: key)
        XCTAssertEqual(MDMMock.feedbackValue(forKey: key), value, "Can send an Integer")
    }
    
    func testCanIncemementInteger() {
        let key = "com.counter"
        testableObject.increment(integer: key)
        var storedValue: Int? = MDMMock.feedbackValue(forKey: key)
        XCTAssertEqual(1, storedValue, "Counter is iniy to 1 for new keys")
        testableObject.increment(integer: key)
        storedValue = MDMMock.feedbackValue(forKey: key)
        XCTAssertEqual(2, storedValue, "Counter value is incremented on increment call")
        
    }
    
    func testCanZeroInteger() {
        XCTFail("NOt implemented")
    }
    
    func testCanWriteTimestamp() {
        XCTFail("NOt implemented")
    }
    
    func testCanClearFeedback() {
        XCTFail("NOt implemented")
    }
}
