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
                    ForEach(vm.children, id: \.id) { person in
                        HStack {
                            Text("\(person.points)")
                            Text(person.name)
                            PlusMinusView(child: person)
                            Spacer()
                        }
                        .font(.title)
                        .padding(.horizontal)
                        .padding(.bottom, 15)
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
    
}

// MARK: - previews

struct ParentActionsVIew_Previews: PreviewProvider {
    static var previews: some View {
        ParentActionsView()
    }
}
