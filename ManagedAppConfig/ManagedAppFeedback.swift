//
//  ManagedAppFeedback.swift
//  ManagedAppConfig
//
//  Created by Michele_personal on 24/09/2017.
//  Copyright © 2017 Michele Simone. All rights reserved.
//

import Foundation



public class ManagedAppFeedback {
    
    
    /// singleton ManagedAppConfig object based on NSUserdefaults.
    public static let standard = ManagedAppConfig(with: UserDefaults.standard)
    
    
    /// the root key of the dictionary to where write the feedback
    static let managedFeedbackRootKey  = "com.apple.feedback.managed"
    
    private var provider: MDMCommunicationChannel!
    
    
    init(with provider: MDMCommunicationChannel) {
        self.provider = provider
    }
    
    func send<T>(_ value: T, for feedbackKey: String) {
        writeToFeedbackDictionary(value, forKey: feedbackKey)
    }
    
    func clearFeedback(_ key: String) {
        var data = feedbackDictionary()
        data.removeValue(forKey: key)
        provider.set(data, forKey: ManagedAppFeedback.managedFeedbackRootKey)
    }
}


/// Helpers methods for sending feedback based on counters
typealias CounterAndIntegers = ManagedAppFeedback
extension CounterAndIntegers {
    func increment(counter withKey:String) {
        var dict = feedbackDictionary()
        let currentValue: Int = dict[withKey] as? Int ?? 0
        writeToFeedbackDictionary(currentValue + 1, forKey: withKey)
    }
    
    func reset(counter withKey: String) {
        writeToFeedbackDictionary(0, forKey: withKey)
    }
}


typealias DatesAndTimestamps = ManagedAppFeedback
extension DatesAndTimestamps {
    func send(timestamp: Date, withKey key: String) {
        writeToFeedbackDictionary(timestamp, forKey: key)
    }
}

fileprivate typealias Internals = ManagedAppFeedback
extension Internals {
    fileprivate func feedbackDictionary() -> [String: Any] {
        return provider.dictionary(forKey: ManagedAppFeedback.managedFeedbackRootKey) ?? [:]
    }
    
    fileprivate func writeToFeedbackDictionary(_ value: Any, forKey: String) {
        var dict = feedbackDictionary()
        dict[forKey] = value
        provider.set(dict, forKey: ManagedAppFeedback.managedFeedbackRootKey)
    }
}
