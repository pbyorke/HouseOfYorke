//
//  ParentActionsView.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 5/5/22.
//

import SwiftUI

struct ParentActionsView: View {
    
    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        VStack {
            ForEach(dataManager.children, id: \.id) { person in
                HStack {
                    Text("\(person.points)")
                    Text(person.name)
                    PlusMinusView(child: person)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
            }
            Button(action: { signOff() }, label: { Text("Signoff") } )
        }
    }
}

// MARK: - extension

extension ParentActionsView {
    
    private func signOff() {
        dataManager.signOff()
    }
    
}

// MARK: - previews

struct ParentActionsVIew_Previews: PreviewProvider {
    static var previews: some View {
        ParentActionsView()
    }
}
