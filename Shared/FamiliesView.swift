//
//  FamiliesView.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 4/30/22.
//

import SwiftUI

struct FamiliesView: View {
    
    @EnvironmentObject var repository: Repository
    
    private var action: () -> ()
    
    init(action: @escaping () -> ()) {
        self.action = action
    }

    var body: some View {
        ScrollView {
            ForEach(repository.families) { family in
                Button(action: { choose(family: family) }, label: { Text(family.name) } )
                    .padding(5)
            }
            .border(Color.black)
        }
    }
    
}

// MARK: - extension

extension FamiliesView {

    private func choose(family: Family) {
        repository.familyFilter = family
        action()
    }
    
}

// MARK: - previews

struct FamiliesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FamiliesView { }
                .environmentObject(Repository.shared)
        }
    }
}
