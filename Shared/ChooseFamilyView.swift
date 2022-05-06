//
//  ChooseFamilyView.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 5/2/22.
//

import SwiftUI

struct ChooseFamilyView: View {
    
    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        VStack {
            Text("Choose your family")
                .foregroundColor(.green)
                .font(.title)
                .padding(.bottom, 20)
            ScrollView {
                ForEach(dataManager.families) { family in
                    Button(action: { choose(family: family) }, label: { Text(family.name) } )
                        .padding(5)
                }
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - extension

extension ChooseFamilyView {

    private func choose(family: Family) {
        dataManager.family = family
    }

}

// MARK: - previews

struct ChooseFamilyView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseFamilyView()
            .environmentObject(DataManager.shared)
    }
}
