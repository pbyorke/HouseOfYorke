//
//  ChoosePersonsView.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 5/2/22.
//

import SwiftUI

struct ChoosePersonView: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    @Binding var personChosen: Bool
    
    var body: some View {
        VStack {
            Text("Choose your name")
                .font(.title)
                .padding(.bottom, 20)
            ForEach(dataManager.persons) { person in
                Text(person.name)
                    .foregroundColor(.blue)
                    .padding(.bottom, 10)
                    .onTapGesture {
                        dataManager.person = person
                        personChosen = true
                    }
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - previews

struct ChoosePersonsView_Previews: PreviewProvider {
    @State static private var personChosen = true
    static var previews: some View {
        ChoosePersonView(personChosen: $personChosen)
            .environmentObject(DataManager.shared)
    }
}
