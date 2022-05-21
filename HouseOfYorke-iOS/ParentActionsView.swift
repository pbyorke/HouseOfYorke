//
//  ParentActionsView.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct ParentActionsView: View {
    
    @EnvironmentObject private var vm: MainViewModel

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(vm.childrenInAFamily, id: \.id) { person in
                        displayAPerson(person: person)
                    }
                    Button(action: { signOff() }, label: { Text("Signoff") } )
                }
            }
        }
    }
}

// MARK: - extension

extension ParentActionsView {
    
    private func signOff() {
        vm.signoff()
    }
    
    private func displayAPerson(person: Person) -> some View {
        HStack {
            VStack {
                Text("\(person.points)")
            }
            VStack {
                HStack {
                    Text(person.name)
                    Spacer()
                }
                HStack {
                    PlusMinusView(child: person)
                    Spacer()
                }
            }
        }
        .font(.title)
        .padding(.horizontal)
        .padding(.bottom, 15)
    }
    
}

// MARK: - previews

struct ParentActionsVIew_Previews: PreviewProvider {
    static var previews: some View {
        ParentActionsView()
    }
}
