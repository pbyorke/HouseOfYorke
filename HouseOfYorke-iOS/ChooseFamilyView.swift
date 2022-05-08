//
//  ChooseFamilyView.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct ChooseFamilyView: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Choose your family")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                ForEach(dataManager.families) { family in
                    Button(action: { choose(family: family) }, label: { Text(family.name) } )
                        .font(.title)
                        .padding(5)
                }
            }
        }
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
