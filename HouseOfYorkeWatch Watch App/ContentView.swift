//
//  ContentView.swift
//  HouseOfYorkeWatch Watch App
//
//  Created by Peter Yorke on 6/4/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            List {
                ForEach(vm.allPersons, id: \.id) { person in
                    Button {
                        vm.selectedPerson = person
                        vm.password = ""
                        vm.page = person.parent ? .password : .person
                    } label: {
                        Text(person.name)
                            .font(.title)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
    }
    
}

// MARK: - previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
