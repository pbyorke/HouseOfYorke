//
//  ChooseFamilyView.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct ChooseFamilyView: View {
    
    @EnvironmentObject private var vm: MainViewModel

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("Choose your family")
                        .font(.largeTitle)
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
}

// MARK: - extension

extension ChooseFamilyView {

    private func choose(family: Family) {
        vm.family = family
        vm.signon(family: family)
    }
    
}

// MARK: - previews

struct ChooseFamilyView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseFamilyView()
            .environmentObject(MainViewModel())
    }
}
