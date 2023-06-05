//
//  Updater.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 6/4/23.
//

import SwiftUI

struct Updater: View {
        
    @EnvironmentObject private var vm: ViewModel
    
    var image = ""
    var amount = 0
    
    var body: some View {
        Button {
            vm.adjust(amount)
        } label: {
            Image(systemName: image)
                .foregroundColor(amount < 0 ? .red : .green)
                .font(.system(size: 30, weight: .medium))
        }

    }
}

// MARK: - previews

struct Updater_Previews: PreviewProvider {
    static var previews: some View {
        Updater()
    }
}
