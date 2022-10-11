//
//  CurrencyType.swift
//  CurrencyConverter Watch App
//
//  Created by Zaid Neurothrone on 2022-10-10.
//

import Foundation

enum CurrencyType: String {
  case usd, aud, cad, chf, cny, eur, gbp, hkd, jpy, sgd
}

extension CurrencyType: CaseIterable, Identifiable {
  var id: Self { self }
}

extension CurrencyType: Codable, Equatable {
  private static let selectedCurrenciesKey = "selectedCurrencies"
  private static let defaultCurrencies: [CurrencyType] = [.usd, .eur]
  
  static func ==(lhs: CurrencyType, rhs: CurrencyType) -> Bool {
    lhs.rawValue == rhs.rawValue
  }
  
  static func save(currencies: [CurrencyType]) {
    let data = try! JSONEncoder().encode(currencies)
    UserDefaults.standard.set(data, forKey: selectedCurrenciesKey)
  }
  
  static func loadCurrencies() -> [CurrencyType] {
    do {
      if let data = UserDefaults.standard.data(forKey: selectedCurrenciesKey) {
        let currencies = try JSONDecoder().decode([CurrencyType].self, from: data)
        return currencies
      }
    } catch {
      // Do nothing: nothing was found
    }
    
    return defaultCurrencies
  }
}
