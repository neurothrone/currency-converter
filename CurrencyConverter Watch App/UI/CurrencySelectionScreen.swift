//
//  CurrencySelectionScreen.swift
//  CurrencyConverter Watch App
//
//  Created by Zaid Neurothrone on 2022-10-10.
//

import SwiftUI

struct CurrencySelectionScreen: View {
  @Binding var selection: CurrencyType
  
  let selectedColor: Color = .init(red: 0, green: 0.55, blue: 0.25)
  let deselectedColor: Color = .init(red: 0.3, green: 0, blue: 0)
  
  var body: some View {
    NavigationStack {
      List(CurrencyType.allCases) { currency in
        Button(currency.rawValue.capitalized) {
          selection = currency
        }
        .listItemTint(
          currency == selection
          ? selectedColor
          : deselectedColor
        )
      }
      .listStyle(.carousel)
      .navigationTitle("Selection")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct CurrencySelectionScreen_Previews: PreviewProvider {
  static var previews: some View {
    CurrencySelectionScreen(selection: .constant(.usd))
  }
}
