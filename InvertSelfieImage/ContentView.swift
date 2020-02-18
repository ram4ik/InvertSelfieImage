//
//  ContentView.swift
//  InvertSelfieImage
//
//  Created by ramil on 18.02.2020.
//  Copyright © 2020 com.ri. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(systemName: "person")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotation3DEffect(.degrees(45), axis: (x: -1, y: 0, z: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
