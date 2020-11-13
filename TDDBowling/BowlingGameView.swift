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
                    ForEach (0..<10) { index in
                        FrameView(viewModel: viewModel, index: index)
                    }
                }
                TotalScoreView(viewModel: viewModel)
            }
            InputView(viewModel: viewModel)
        }
    }
}

struct FrameView: View {
    @ObservedObject var viewModel: BowlingGameViewModel
    let index:Int
    var body: some View {
        VStack(spacing:0) {
            FrameIndexView(index: index)
            HStack(spacing: 0) {
                FrameBowlView(viewModel: viewModel, frameIndex: index, bowlIndex: 0)
                FrameBowlView(viewModel: viewModel, frameIndex: index, bowlIndex: 1)
                if (index == 9) {
                    FrameBowlView(viewModel: viewModel, frameIndex: index, bowlIndex: 2)
                }
            }
            FrameScoreView(viewModel: viewModel, frameIndex: index)
        }
    }
}

struct FrameIndexView: View {
    let index:Int
    var body: some View {
        Text(String(index+1))
            .frame(width: index == 9 ? 75 : 50, height: 20)
            .border(Color.gray.opacity(0.5))
    }
}

struct FrameBowlView: View {
    @ObservedObject var viewModel: BowlingGameViewModel
    let frameIndex: Int
    let bowlIndex: Int

    var body: some View {
        Text(viewModel.bowlAsText(frameIndex: frameIndex, bowlIndex: bowlIndex))
            .accessibility(identifier: String("FrameBowlView\(frameIndex)-\(bowlIndex)"))
            .frame(width: 25, height: 20)
            .border(Color.gray.opacity(0.5))
    }
}

struct FrameScoreView: View {
    @ObservedObject var viewModel: BowlingGameViewModel
    let frameIndex: Int
    var body: some View {
        Text(viewModel.scoreAsText(frameIndex: frameIndex))
            .accessibility(identifier: "FrameScoreView\(frameIndex)")
            .frame(width: frameIndex == 9 ? 75 : 50, height: 20)
            .border(Color.gray.opacity(0.5))
    }
}

struct TotalScoreView: View {
    @ObservedObject var viewModel: BowlingGameViewModel
    var body: some View {
        VStack {
            Text("Total")
                .frame(width: 50, height: 20)
                .border(Color.gray.opacity(0.5))
            Text(viewModel.scoreAsText(frameIndex: 9))
                .accessibility(identifier: "TotalScoreView")
                .frame(width: 50, height: 40)
                .border(Color.gray.opacity(0.5))
        }
    }
}

struct InputView: View {
    @ObservedObject var viewModel: BowlingGameViewModel
    var body: some View {
        HStack {
            ForEach(0..<11) { index in
                Button(action: {
                    viewModel.addBowlResult(num: index)
                }, label: { Text(String(index)) } )
                .frame(width: 45, height:45)
                .accessibility(identifier: String("Button\(index)"))
                .disabled(!viewModel.isButtonAvailable(index: index))
            }
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
