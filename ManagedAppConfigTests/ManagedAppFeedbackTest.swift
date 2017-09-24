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
    
    func testSingleton() {
        let singleton = ManagedAppFeedback.standard
        XCTAssert(singleton.provider is UserDefaults, "Singleton provider is userdefaults")
    }
    
    func testCanWriteString() {
        let value = "some feedback value"
        let key = "com.string"
        testableObject.send(value, for: key)
        XCTAssertEqual(MDMMock.feedbackValue(forKey: key), value, "Can send a string feedback")
        
        enum Keys: String {
            case someKey = "com.enumKey"
        }
        testableObject.send(value, for: Keys.someKey)
        XCTAssertEqual(MDMMock.feedbackValue(forKey: Keys.someKey.rawValue), value, "Can sed string values using enum keys")
    }

    func testCanWriteInteger() {
        let value = 1
        let key = "com.integer"
        testableObject.send(value, for: key)
        XCTAssertEqual(MDMMock.feedbackValue(forKey: key), value, "Can send an Integer")
    }
    
    func testCanIncemementInteger() {
        let key = "com.counter"
        testableObject.increment(counter: key)
        var storedValue: Int? = MDMMock.feedbackValue(forKey: key)
        XCTAssertEqual(1, storedValue, "Counter is iniy to 1 for new keys")
        testableObject.increment(counter: key)
        storedValue = MDMMock.feedbackValue(forKey: key)
        XCTAssertEqual(2, storedValue, "Counter value is incremented on increment call")
        
    }
    
    func testCanZeroInteger() {
        let integer = 10
        let key = "com.integer"
        //write some value first
        testableObject.send(integer, for: key)
        //then reset to 0
        testableObject.reset(counter: key)
        XCTAssertEqual(0, MDMMock.feedbackValue(forKey: key), "Counter has been reset to 0")
    }
    
    func testCanWriteTimestamp() {
        let timestamp = Date()
        let key = "com.timestamp"
        testableObject.send(timestamp: timestamp, withKey: key)
        XCTAssertEqual(timestamp, MDMMock.feedbackValue(forKey: key),"Timestamp has been send")
    }
    
    func testCanClearFeedback() {
        let key = "com.toremove"
        testableObject.send("any data", for: key)
        testableObject.clearFeedback(key)
        XCTAssertNil(MDMMock.feedbackValue(forKey: key), "Feedback has been deleted")
        
    }
}
