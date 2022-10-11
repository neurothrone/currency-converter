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
      fatalError("❌ -> API Key not set in scheme")
    }
    
    return key
  }
}
