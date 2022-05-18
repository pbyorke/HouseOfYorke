//
//  MainView.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ZStack {
            Color.peacefulBackground.ignoresSafeArea()
            VStack(spacing: 10) {
                HeaderView()
                if dataManager.isSignedIn {
                    PersonActionsView()
                }
                if dataManager.needFamily {
                    ChooseFamilyView()
                }
                if dataManager.needPerson {
                    ChoosePersonView()
                }
                Spacer()
            }
            .padding(.top, 20)
        }
    }
    
}

// MARK: - previews

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(DataManager())
    }
}
