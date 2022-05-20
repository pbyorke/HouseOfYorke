//
//  KidActionsView.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct KidActionsView: View {
    
    @EnvironmentObject private var vm: MainViewModel

    var body: some View {
        VStack {
            Text("Hi \(vm.name), you have")
                .font(.title)
                .padding(.bottom, 20)
            Text("\(vm.points) points")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
            Button(action: { signOff() }, label: { Text("Signoff") } )
        }
    }
}

// MARK: - extension

extension KidActionsView {
    
    private func signOff() {
        vm.signoff()
    }
    
}

// MARK: - previews

struct KidActionsVIew_Previews: PreviewProvider {
    static var previews: some View {
        KidActionsView()
    }
}
