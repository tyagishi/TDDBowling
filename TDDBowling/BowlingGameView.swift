//
//  BowlingGameView.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/08
//  © 2020  SmallDeskSoftware
//

import SwiftUI

struct BowlingGameView: View {
    var body: some View {
        VStack(spacing:0) {
            HStack(spacing: 0) {
                Group {
                    FrameView()
                    FrameView()
                    FrameView()
                    FrameView()
                    FrameView()
                    FrameView()
                    FrameView()
                    FrameView()
                    FrameView()
                    FrameView()
                }
                TotalScoreView()
            }
            InputView()
        }
    }
}

struct FrameView: View {
    var body: some View {
        VStack(spacing:0) {
            FrameIndexView()
            HStack(spacing: 0) {
                FrameBowlView()
                FrameBowlView()
            }
            FrameScoreView()
        }
    }
}

struct FrameIndexView: View {
    var body: some View {
        Text("1")
            .frame(width: 50, height: 20)
            .border(Color.gray.opacity(0.5))
    }
}

struct FrameBowlView: View {
    var body: some View {
        Text("3")
            .frame(width: 25, height: 20)
            .border(Color.gray.opacity(0.5))
    }
}

struct FrameScoreView: View {
    var body: some View {
        Text("100")
            .frame(width: 50, height: 20)
            .border(Color.gray.opacity(0.5))
    }
}

struct TotalScoreView: View {
    var body: some View {
        VStack {
            Text("Total")
                .frame(width: 50, height: 20)
                .border(Color.gray.opacity(0.5))
            Text("154")
                .frame(width: 50, height: 40)
                .border(Color.gray.opacity(0.5))
        }
    }
}

struct InputView: View {
    var body: some View {
        HStack {
            Button(action: {}, label: { Text("0") } )
            Button(action: {}, label: { Text("1") } )
            Button(action: {}, label: { Text("2") } )
            Button(action: {}, label: { Text("3") } )
            Button(action: {}, label: { Text("4") } )
            Button(action: {}, label: { Text("5") } )
            Button(action: {}, label: { Text("6") } )
            Button(action: {}, label: { Text("7") } )
            Button(action: {}, label: { Text("8") } )
            Button(action: {}, label: { Text("9") } )
        }
        .font(.largeTitle)
    }
}

struct BowlingGameView_Previews: PreviewProvider {
    static var previews: some View {
        BowlingGameView()
            .previewLayout(.fixed(width: 1792/2, height: 828/2))
    }
}
