//
//  PasswordView.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/12/22.
//

import SwiftUI

struct PasswordView: View {
    
    @EnvironmentObject private var vm: MainViewModel

    var person: Person
    @State private var password = ""
    
    var body: some View {
        VStack {
            VStack {
                Text("Enter password")
                SecureField("", text: $password)
                    .autocapitalization(.none)
                    .textFieldStyle(.roundedBorder)
                Button { press() } label: { Text("Sign in") }
            }
            .padding()
            .border(Color.black)
        }
        .padding(.horizontal, 40)
    }
}

// MARK: - extension

extension PasswordView {
    
    private func press() {
        if password == person.password {
            vm.person = person
        }
    }
    
}

// MARK: - previews

struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView(person: Person())
    }
}
