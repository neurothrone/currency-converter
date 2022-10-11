//
//  WebService.swift
//  CurrencyConverter Watch App
//
//  Created by Zaid Neurothrone on 2022-10-11.
//

import Foundation

final class WebService {
  static var apiKey: String {
    guard let key = ProcessInfo.processInfo.environment["API_KEY"] else {
      fatalError("❌ -> Environment variable [API_Key] was not found. Did you forget to add it in scheme?")
    }
    
    return key
  }
}
