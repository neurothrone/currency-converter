//
//  CurrencyPickerView.swift
//  CurrencyConverter Watch App
//
//  Created by Zaid Neurothrone on 2022-10-10.
//

import SwiftUI

struct CurrencyPickerView: View {
  @Binding var selection: CurrencyType
  
  var body: some View {
    Picker("Select a currency", selection: $selection) {
      ForEach(CurrencyType.allCases) { currency in
        Text(currency.rawValue)
      }
    }
    .labelsHidden()
  }
}

struct CurrencyPickerView_Previews: PreviewProvider {
  static var previews: some View {
    CurrencyPickerView(selection: .constant(.usd))
  }
}
