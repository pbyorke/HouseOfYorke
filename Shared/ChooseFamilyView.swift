//
//  ChooseFamilyView.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 5/2/22.
//

import SwiftUI

struct ChooseFamilyView: View {
    
    @EnvironmentObject var repository: Repository
    @Binding var familyChosen: Bool
    
    var body: some View {
        VStack {
            Text("Choose your family")
                .font(.title)
                .padding(.bottom, 20)
            ForEach(repository.families) { family in
                Text(family.name)
                    .foregroundColor(.blue)
                    .padding(.bottom, 10)
                    .onTapGesture {
                        repository.family = family
                        familyChosen = true
                        repository.familyFilter = family
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
            .environmentObject(Repository.shared)
    }
}
