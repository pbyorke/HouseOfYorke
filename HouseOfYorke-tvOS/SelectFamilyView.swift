//
//  SelectFamilyView.swift
//  HouseOfYorke-tvOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct SelectFamilyView: View {
    
    @EnvironmentObject private var vm: MainViewModel

    var body: some View {
        ScrollView {
            VStack {
                Text("Choose your family")
                    .font(.title)
                    .padding(.bottom, 20)
                ForEach(vm.allFamilies) { family in
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
        vm.family = family
        vm.signon(family: family)
    }

}

// MARK: - previews

struct SelectFamilyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectFamilyView()
            .environmentObject(MainViewModel())
    }
}
