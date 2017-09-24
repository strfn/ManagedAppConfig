//
//  ManagedAppConfigTests.swift
//  ManagedAppConfigTests
//
//  Created by Michele_personal on 22/09/2017.
//  Copyright © 2017 Michele Simone. All rights reserved.
//

import XCTest
@testable import ManagedAppConfig


class ManagedAppConfigTests: XCTestCase {
    
    let MDMMock = MDMChannelMock()
    lazy var testableObject = ManagedAppConfig(with: MDMMock)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testReadAll() {
        let _ = testableObject.all
        //check is accessing the apconfig dictionary.
        XCTAssertEqual(MDMMock.keyUsedForRootDictionary, "com.apple.configuration.managed", "The right root key is used to access the Managed App config dictionary")
    }

    
    func testCanReadStringValue() {
        var result: String? = testableObject.read(MDMChannelMock.Keys.string)
        XCTAssertEqual(result, MDMChannelMock.Values.string, "Can read a String")
        result = testableObject.read("unexisting")
        XCTAssertNil(result,"Nil is returned for unexsting value")
    }
    
    func testCanReadInt() {
        let result: Int? = testableObject.read(MDMChannelMock.Keys.integer)
        XCTAssertEqual(result, MDMChannelMock.Values.integer, "Can read an Int")
    }
    
    func testCanReadURL() {
        let result: URL? = testableObject.read(MDMChannelMock.Keys.url)
        XCTAssertEqual(result, MDMChannelMock.Values.url, "Can read an Int")
    }
    
    func testCanReadDictionary() {
        let result : [String:String]? = testableObject.read(MDMChannelMock.Keys.dictionary)
        XCTAssertNotNil(result, "Can read a dictionary")
    
    }
    
    func testUseEnumsAsKey() {
        enum Keys: String {
            case aKey = "key.string"
        }
        let result : String? = testableObject.read(Keys.aKey)
         XCTAssertEqual(result, MDMChannelMock.Values.string, "Can read using enum keys")
    }
}



