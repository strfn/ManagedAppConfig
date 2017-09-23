//
//  ManagedAppConfig.swift
//  ManagedAppConfig
//
//  Created by Michele_personal on 22/09/2017.
//  Copyright © 2017 Michele Simone. All rights reserved.
//

import Foundation



public protocol MDMCommunicationChannel {
    func dictionary(forKey: String) -> [String : Any]?
}

extension UserDefaults: MDMCommunicationChannel {}

public class ManagedAppConfig {
    static let managedConfigRootKey = "com.apple.configuration.managed"
    static let feedbackKey = "com.apple.feedback.managed"
    
    private var provider: MDMCommunicationChannel = UserDefaults.standard
    
    
    init(with provider: MDMCommunicationChannel) {
        self.provider = provider
    }
    
    lazy var all: [String: Any] = {
        return provider.dictionary(forKey: ManagedAppConfig.managedConfigRootKey) ?? [String: Any]()
    }()
    
    func read<T>(_ key: String) -> T? {
        return all[key] as? T
    }
}
