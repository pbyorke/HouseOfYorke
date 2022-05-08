//
//  PersonActionsView.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/7/22.
//

import SwiftUI

struct PersonActionsView: View {
    
    @EnvironmentObject var dataManager: DataManager

    var body: some View {
        
        if dataManager.parent {
            ParentActionsView()
        } else {
            KidActionsView()
        }
    }
}

// MARK: - previews

struct PersonActionsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonActionsView()
            .environmentObject(DataManager.shared)
    }
}
