//
//  ContentView.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 6/3/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var vm: ViewModel
    
    var body: some View {
        VStack {
            HeaderView()
            Text("House of Yorke")
                .foregroundColor(.black)
                .font(.largeTitle)
                .fontWeight(.medium)
            switch vm.page {
            case .choose:   choosePage
            case .person:   personPage
            case .parent:   parentPage
            case .password: passwordPage
            case .update:   updatePage
            case .tv:       tvPage
            }
            Spacer()
#if !os(tvOS)
            if vm.page != .choose {
                Button {
                    vm.page = .choose
                } label: {
                    Text("Done")
                }
            }
#endif
        }
    }
    
    // MARK: - tvPage
    
    private var tvPage: some View {
        VStack {
            List {
                ForEach(vm.allPersons.filter { !$0.parent }) { person in
                    Text("\(person.name) - \(person.points)")
                        .foregroundColor(.black)
                }
            }
            .listStyle(.plain)
        }
    }
    
    // MARK: - choosePersonPage
    
    private var choosePage: some View {
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
#if !os(tvOS)
                    .listRowSeparator(.hidden)
#endif
                }
            }
            .listStyle(.plain)
        }
    }
    
    // MARK: - personPage
    
    private var personPage: some View {
        VStack {
            Divider()
            Text("Hello \(vm.selectedPerson?.name ?? ""), you have \(vm.selectedPerson?.points ?? 0) points")
        }
    }
    
    // MARK: - parentPage
    
    private var parentPage: some View {
        VStack {
            Divider()
            List {
                ForEach(vm.allPersons.filter { !$0.parent }, id: \.id) { person in
                    Button {
                        vm.updatePerson = person
                        vm.page = .update
                    } label: {
                        Text(person.name)
                            .font(.title)
                    }
                    #if !os(tvOS)
                    .listRowSeparator(.hidden)
                    #endif
                }
            }
            .listStyle(.plain)
        }
    }
    
    // MARK: - passwordPage
    
    private var passwordPage: some View {
        VStack {
            Divider()
            Text("Enter password for \(vm.selectedPerson?.name ?? "")")
            SecureField("", text: $vm.password)
                .frame(height: 40)
                .cornerRadius(6)
                .padding(.horizontal, 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(
                            Color(.gray),
                            lineWidth: 1
                        )
                )
            if vm.badPassword {
                Text("Whoops")
                    .foregroundColor(.red)
                    .font(.system(size: 30, weight: .medium))


            }
            Button {
                vm.validate()
            } label: {
                Text("Sign In")
            }
        }
        .padding(20)
    }
    
    // MARK: - updatePage
    
    private var updatePage: some View {
        VStack {
            Divider()
            Text("\(vm.updatePerson?.name ?? "") (\(vm.updatePerson?.points ?? 0))")
                .font(.title)
            HStack {
                Updater(image: "5.circle", amount: 5)
                Updater(image: "10.circle", amount: 10)
                Updater(image: "50.circle", amount: 50)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            HStack {
                Updater(image: "5.circle", amount: -5)
                Updater(image: "10.circle", amount: -10)
                Updater(image: "50.circle", amount: -50)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
    }
    
}

// MARK: - previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
