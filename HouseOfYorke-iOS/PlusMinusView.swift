//
//  PlusMinusView.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct PlusMinusView: View {
    
    @EnvironmentObject var dataManager: DataManager

    @State private var showPicker = false
    @State private var selectedAmount = "0"
    @State private var amounts = [String]()
    var child: Person
    
    var body: some View {
        HStack {
            Button { plus() } label: { Image(systemName: "plus.circle.fill") }
            Button { minus() } label: { Image(systemName: "minus.circle.fill") }
            Button { zero() } label: { Image(systemName: "plusminus.circle.fill") }
            if showPicker {
                HStack {
                    Picker("Amount", selection: $selectedAmount) {
                        ForEach(amounts, id: \.self) {
                            Text($0)
                        }
                    }
                    .border(Color.cyan)
                    Button { save() } label: { Image(systemName: "square.and.arrow.down.on.square") }
                }
            }
        }
    }
    
    private func plus() {
        amounts = ["0", "5", "10", "50"]
        showPicker = true
    }
    
    private func minus() {
        amounts = ["0", "-5", "-10", "-50"]
        showPicker = true
    }
    
    private func zero() {
        showPicker = false
        dataManager.zero(child)
    }
    
    private func save() {
        showPicker = false
        let amount = Int(selectedAmount) ?? 0
        dataManager.adjust(child, amount)
    }
}

// MARK: - previews

struct PlusMinusView_Previews: PreviewProvider {
    static var previews: some View {
        PlusMinusView(child: Person())
    }
}
