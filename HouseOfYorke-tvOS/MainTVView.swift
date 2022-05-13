//
//  MainTVView.swift
//  HouseOfYorke-tvOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct MainTVView: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        VStack(spacing: 10) {
            HeaderView()
                .padding(.horizontal, 200)
            if dataManager.needFamily {
                SelectFamilyView()
            } else {
                RecapView()
            }
            Spacer()
        }
        .padding(.top, 20)
    }
    
}

// MARK: - previews

struct MainTVView_Previews: PreviewProvider {
    static var previews: some View {
        MainTVView()
            .environmentObject(DataManager.shared)
    }
}
