//
//  CurrenciesView.swift
//  CurrencyConverter Watch App
//
//  Created by Zaid Neurothrone on 2022-10-11.
//

import SwiftUI

struct CurrenciesView: View {
  @State private var selectedCurrencies: [CurrencyType] = CurrencyType.loadCurrencies()
  
  let selectedColor: Color = .init(red: 0, green: 0.55, blue: 0.25)
  let deselectedColor: Color = .init(red: 0.3, green: 0, blue: 0)
  
  var body: some View {
    NavigationStack {
      List(CurrencyType.allCases) { currency in
        Button(currency.rawValue.capitalized) {
          toggle(currency)
        }
        .listItemTint(
          selectedCurrencies.contains(currency)
          ? selectedColor
          : deselectedColor
        )
      }
      .listStyle(.carousel)
      .navigationTitle("Currencies")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

extension CurrenciesView {
  private func toggle(_ currency: CurrencyType) {
    if let index = selectedCurrencies.firstIndex(of: currency) {
      selectedCurrencies.remove(at: index)
    } else {
      selectedCurrencies.append(currency)
    }
    
    CurrencyType.save(currencies: selectedCurrencies)
  }
}

struct CurrenciesView_Previews: PreviewProvider {
  static var previews: some View {
    CurrenciesView()
  }
}
