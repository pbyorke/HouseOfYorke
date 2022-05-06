//
//  PersonActionsView.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 5/2/22.
//

import SwiftUI

struct PersonActionsView: View {
    
    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        VStack {
            Text("\(dataManager.name), you have \(dataManager.points) points")
                .foregroundColor(.red)
                .font(.title)
                .padding(.bottom, 20)
            Button(action: { signOff() }, label: { Text("Signoff") } )
        }
    }
}

// MARK: - extension

extension PersonActionsView {
    
    private func signOff() {
        dataManager.signOff()
    }
    
}

// MARK: - previews

struct PersonActionsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonActionsView()
            .environmentObject(DataManager.shared)
    }
}
