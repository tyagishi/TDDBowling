//
//  BowlingGameView.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/08
//  © 2020  SmallDeskSoftware
//

import SwiftUI

struct BowlingGameView: View {
    @StateObject var viewModel: BowlingGameViewModel = BowlingGameViewModel()
    
    var body: some View {
        VStack(spacing:0) {
            HStack(spacing: 0) {
                Group {
                    FrameView(viewModel: viewModel, index: 0)
                    FrameView(viewModel: viewModel, index: 1)
                    FrameView(viewModel: viewModel, index: 2)
                    FrameView(viewModel: viewModel, index: 3)
                    FrameView(viewModel: viewModel, index: 4)
                    FrameView(viewModel: viewModel, index: 5)
                    FrameView(viewModel: viewModel, index: 6)
                    FrameView(viewModel: viewModel, index: 7)
                    FrameView(viewModel: viewModel, index: 8)
                    FrameView(viewModel: viewModel, index: 9)
                }
                TotalScoreView(viewModel: viewModel)
            }
            InputView(viewModel: viewModel)
        }
    }
}

struct FrameView: View {
    let viewModel: BowlingGameViewModel
    let index:Int
    var body: some View {
        VStack(spacing:0) {
            FrameIndexView(index: index)
            HStack(spacing: 0) {
                FrameBowlView(viewModel: viewModel, frameIndex: index, bowlIndex: 0)
                FrameBowlView(viewModel: viewModel, frameIndex: index, bowlIndex: 1)
            }
            FrameScoreView(viewModel: viewModel, frameIndex: index)
        }
    }
}

struct FrameIndexView: View {
    let index:Int
    var body: some View {
        Text(String(index+1))
            .frame(width: 50, height: 20)
            .border(Color.gray.opacity(0.5))
    }
}

struct FrameBowlView: View {
    let viewModel: BowlingGameViewModel
    let frameIndex: Int
    let bowlIndex: Int

    var body: some View {
        Text(viewModel.bowlAsText(frame: frameIndex, bowl: bowlIndex))
            .frame(width: 25, height: 20)
            .border(Color.gray.opacity(0.5))
    }
}

struct FrameScoreView: View {
    let viewModel: BowlingGameViewModel
    let frameIndex: Int
    var body: some View {
        Text(viewModel.scoreAsText(frame: frameIndex))
            .frame(width: 50, height: 20)
            .border(Color.gray.opacity(0.5))
    }
}

struct TotalScoreView: View {
    let viewModel: BowlingGameViewModel
    var body: some View {
        VStack {
            Text("Total")
                .frame(width: 50, height: 20)
                .border(Color.gray.opacity(0.5))
            Text(viewModel.scoreAsText(frame: 9))
                .frame(width: 50, height: 40)
                .border(Color.gray.opacity(0.5))
        }
    }
}

struct InputView: View {
    @ObservedObject var viewModel: BowlingGameViewModel
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
