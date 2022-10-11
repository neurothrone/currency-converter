//
//  ResultsScreen.swift
//  CurrencyConverter Watch App
//
//  Created by Zaid Neurothrone on 2022-10-11.
//

import Combine
import SwiftUI

struct CurrencyResult: Codable {
  let base: String
  let rates: [String: Double]
}

struct ResultsScreen: View {
  enum FetchState {
    case fetching, success, failed
  }
  
  @AppStorage("amount") var amount: Double = 1
  @AppStorage("baseCurrency") var baseCurrency: CurrencyType = .usd
  
  @State private var fetchState: FetchState = .fetching
  @State private var fetchedCurrencies: [(symbol: String, rate: Double)] = []
  @State private var request: AnyCancellable?
  
  var body: some View {
    Group {
      if fetchState == .success {
        List(fetchedCurrencies, id: \.symbol) { currency in
          Text(rate(for: currency))
        }
      } else {
        Text(
          fetchState == .fetching
          ? "Fetching..."
          : "Fetch failed"
        )
      }
    }
    .navigationTitle(amount.formatted(.currency(code: baseCurrency.rawValue)))
    .onAppear(perform: fetchData)
  }
}

extension ResultsScreen {
  private func fetchData() {
    guard let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=\(WebService.apiKey)&base=\(baseCurrency.rawValue)") else {
      fetchState = .failed
      return
    }
    
    request = URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: CurrencyResult.self, decoder: JSONDecoder())
      .replaceError(with: .init(base: "", rates: [:]))
      .receive(on: DispatchQueue.main)
      .sink(receiveValue: parse)
  }
  
  private func parse(result: CurrencyResult) {
    guard !result.rates.isEmpty else {
      fetchState = .failed
      return
    }
    
    fetchState = .success
    
    // Get user's selected currencies from app storage
    let selectedCurrencies = CurrencyType.loadCurrencies()
    
    for symbol in result.rates {
      let currencyType = CurrencyType(rawValue: symbol.key) ?? .usd
      guard selectedCurrencies.contains(currencyType) else { continue }
      
      let rateName = symbol.key
      let rateValue = symbol.value
      
      fetchedCurrencies.append((symbol: rateName, rate: rateValue))
    }
    
    fetchedCurrencies.sort { $0.symbol < $1.symbol}
  }
  
  private func rate(for result: (symbol: String, rate: Double)) -> String {
    result.rate.formatted(.currency(code: result.symbol))
  }
}

struct ResultsScreen_Previews: PreviewProvider {
  static var previews: some View {
    ResultsScreen(amount: 500, baseCurrency: .usd)
  }
}
