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
#if os(tvOS)
                .frame(width: 200, height: 200)
#else
                .frame(width: 100, height: 100)
#endif
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
