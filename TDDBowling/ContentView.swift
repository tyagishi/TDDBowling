//
//  ContentView.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/08
//  © 2020  SmallDeskSoftware
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        BowlingGameView()
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .previewLayout(.fixed(width: 1344, height: 621))
    }
}
