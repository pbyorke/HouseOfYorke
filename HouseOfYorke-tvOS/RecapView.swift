//
//  RecapView.swift
//  HouseOfYorke-tvOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct RecapView: View {

    @EnvironmentObject private var vm: MainViewModel

    var body: some View {
        VStack {
            Text("Current Scores")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            ForEach(vm.filteredKids) { person in
                HStack {
                    Text(person.name)
                        .font(.largeTitle)
                    Text("\(person.points)")
                        .font(.largeTitle)
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
            }
            if vm.multipleFamilies {
                Button(action: { signOff() }, label: { Text("Signoff") } )
            }
        }
    }
}

// MARK: - extension

extension RecapView {
    
    private func signOff() {
        vm.signoff()
    }
    
}

// MARK: - previews

struct RecapView_Previews: PreviewProvider {
    static var previews: some View {
        RecapView()
    }
}
