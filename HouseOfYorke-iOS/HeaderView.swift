//
//  HeaderView.swift
//  HouseOfYorke-iOS
//
//  Created by Peter Yorke on 5/12/22.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            HStack {
                Image("badge")
                Text("House Of Yorke")
                    .font(Font.custom("copperplate-bold", size: 30))
            }
            .padding(.bottom, 50)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
