//
//  SelectFamilyView.swift
//  HouseOfYorke-tvOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct SelectFamilyView: View {
    
    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        ScrollView {
            VStack {
                Text("Choose your family")
                    .font(.title)
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

extension SelectFamilyView {

    private func choose(family: Family) {
        dataManager.family = family
    }

}

// MARK: - previews

struct SelectFamilyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectFamilyView()
            .environmentObject(DataManager.shared)
    }
}
