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
    func set(_ object: Any?, forKey: String)
}

extension UserDefaults: MDMCommunicationChannel {}

public class ManagedAppConfig {
    
    
    /// singleton ManagedAppConfig object based on NSUserdefaults.
    public static let standard = ManagedAppConfig(with: UserDefaults.standard)
    
    static let managedConfigRootKey = "com.apple.configuration.managed"
    
    private var provider: MDMCommunicationChannel!
    
    
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

private typealias EnumKeys = ManagedAppConfig
extension EnumKeys {
    func read<K: RawRepresentable, T>(_ key: K) -> T? where K.RawValue == String {
        return read(key.rawValue)
    }
}
