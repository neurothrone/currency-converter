//
//  ContentView.swift
//  CurrencyConverter Watch App
//
//  Created by Zaid Neurothrone on 2022-10-09.
//

import SwiftUI

struct ContentView: View {
  @FocusState private var isAmountFocused: Bool
  
  @State private var amount: Double = 500
  @State private var selectedCurrency: CurrencyType = .usd
  
  var body: some View {
    NavigationStack {
      TabView {
        content
        CurrenciesScreen()
      }
      .navigationTitle("WatchFX")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
  
  var content: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        Text(Int(amount).description)
          .font(.largeTitle)
          .padding()
          .contentShape(Rectangle())
          .focusable()
          .focused($isAmountFocused)
          .digitalCrownRotation(
            $amount,
            from: .zero,
            through: 1000,
            by: 20,
            sensitivity: .high,
            isContinuous: false,
            isHapticFeedbackEnabled: true
          )
          .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
              .strokeBorder(isAmountFocused ? .green : .white, lineWidth: 2)
          )
        
        HStack {
          NavigationLink {
            CurrencySelectionScreen(selection: $selectedCurrency)
          } label: {
            Text(selectedCurrency.rawValue)
          }
          
          NavigationLink {
            ResultsScreen(amount: amount, baseCurrency: selectedCurrency)
          } label: {
            Text("Go")
              .frame(width: geo.size.width * 0.4)
          }
        }
        .padding(.top)
        .frame(height: geo.size.height / 3)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
