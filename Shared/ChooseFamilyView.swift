//
//  ChooseFamilyView.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 5/2/22.
//

import SwiftUI

struct ChooseFamilyView: View {
    
    @EnvironmentObject var dataManager: DataManager
    @Binding var familyChosen: Bool
    
    var body: some View {
        VStack {
            Text("Choose your family")
                .font(.title)
                .padding(.bottom, 20)
            ForEach(dataManager.families) { family in
                Text(family.name)
                    .foregroundColor(.blue)
                    .padding(.bottom, 10)
                    .onTapGesture {
                        dataManager.family = family
                        familyChosen = true
                        dataManager.familyFilter = family
                    }
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - previews

struct ChooseFamilyView_Previews: PreviewProvider {
    @State static private var familyChosen = true
    static var previews: some View {
        ChooseFamilyView(familyChosen: $familyChosen)
            .environmentObject(DataManager.shared)
    }
}
