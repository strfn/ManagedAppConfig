//
//  MDMChannelMock.swift
//  ManagedAppConfigTests
//
//  Created by Michele_personal on 24/09/2017.
//  Copyright © 2017 Michele Simone. All rights reserved.
//

import Foundation
import ManagedAppConfig

class MDMChannelMock: MDMCommunicationChannel {
    
    var keyUsedForRootDictionary = ""
    var lastFeedbackKey: String?
    
    
    // Mock data
    struct Keys {
        static let string = "key.string"
        static let integer = "key.integer"
        static let url = "key.url"
        static let dictionary = "key.dictionary"
    }
    
    struct Values {
        static let string = "values.string"
        static let integer = 1
        static let url = URL(string: "http://www.google.com")!
        static let dictionary = ["somekey": "somevalue"]
    }
    
    private let managedConfigs : [String : Any] = [
        Keys.string : Values.string,
        Keys.integer: Values.integer,
        Keys.url: Values.url,
        Keys.dictionary: Values.dictionary
    ]
    
    lazy var mockStorage: [String: Any] = [
        "com.apple.configuration.managed": managedConfigs
    ]
    
    
    
    func dictionary(forKey: String) -> [String : Any]? {
        keyUsedForRootDictionary = forKey
        return mockStorage[forKey] as? [String : Any]
    }
    
    func set(_ object: Any?, forKey: String) {
        mockStorage[forKey] = object
    }
    
    func feedbackValue<T>(forKey: String) -> T? {
        guard let feddbackDictionary = mockStorage["com.apple.feedback.managed"] as? [String : Any] else {
            return nil
        }
        return feddbackDictionary[forKey] as? T
    }
}
