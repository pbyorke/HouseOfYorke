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
    @State private var zeroCount = 0
    var child: Person
    
    init(child: Person) {
        zeroCount = 0
        self.child = child
    }
    
    var body: some View {
        HStack {
            Button { plus() } label: { Image(systemName: "plus.circle.fill") }.frame(width: 40)
            Button { minus() } label: { Image(systemName: "minus.circle.fill") }.frame(width: 40)
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
        zeroCount = 0
        amounts = ["0", "5", "10", "50"]
        showPicker = true
    }
    
    private func minus() {
        zeroCount = 0
        amounts = ["0", "-5", "-10", "-50"]
        showPicker = true
    }
    
    private func zero() {
        if zeroCount > 1 {
            zeroCount = 0
            showPicker = false
            dataManager.zero(child)
        }
        zeroCount += 1
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
