//
//  HeaderView.swift
//  HouseOfYorke
//
//  Created by Peter Yorke on 6/3/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image("badge")
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
        }
        .padding(20)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
