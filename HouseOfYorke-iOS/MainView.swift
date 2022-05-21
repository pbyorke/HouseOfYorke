//
//  MainView.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var vm: MainViewModel

    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 10) {
                    HeaderView()
//                    DebugHeader()
                    if vm.isSignedIn {
                        PersonActionsView()
                    }
                    if vm.needFamilySection {
                        ChooseFamilyView()
                    }
                    if vm.needPersonSection {
                        ChoosePersonView()
                    }
                    Spacer()
                }
                .padding(.top, 20)
            }
        }
    }
    
}

// MARK: - previews

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MainViewModel())
    }
}

private struct DebugHeader: View {
    @EnvironmentObject private var vm: MainViewModel
    var body: some View {
        VStack {
            
            VStack {
                Text("Family")
                    .bold()
                    .underline()
                Text(vm.family?.name ?? "-none-")
            }
            .padding()
            .border(Color.black)
            
            VStack {
                Text("Person")
                    .bold()
                    .underline()
                Text(vm.person?.name ?? "-none-")
            }
            .padding()
            .border(Color.black)
            
            VStack {
                Text("Families")
                    .bold()
                    .underline()
                ForEach(vm.allFamilies) { Text($0.name) }
            }
            .padding()
            .border(Color.black)
            
            VStack {
                Text("Persons")
                    .bold()
                    .underline()
                ForEach(vm.allPersons) { Text($0.name) }
            }
            .padding()
            .border(Color.black)
            
            VStack {
                Text("Filtered Persons")
                    .bold()
                    .underline()
                ForEach(vm.personsInAFamily) { Text($0.name) }
            }
            .padding()
            .border(Color.black)
        }
    }
}
