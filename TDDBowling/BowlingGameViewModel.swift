//
//  BowlingGameViewModel.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/08
//  © 2020  SmallDeskSoftware
//

import Foundation
import SwiftUI

class BowlingGameViewModel : ObservableObject{
    @Published var game: BowlingGame
    
    init() {
        game = BowlingGame()
    }
    
    func bowlAsText(frameIndex:Int, bowlIndex: Int) -> String {
        switch game.frameState(frameIndex: frameIndex) {
            case .Strike:
                return bowlIndex == 0 ? "X" : ""
            case .Spare:
                if bowlIndex == 1 { return "/" }
                fallthrough
            case .Others:
                if let num = game.bowlResult(frameIndex: frameIndex, bowlIndex: bowlIndex)  {
                    return String(num)
                }
                return "-"
        }
    }

    func scoreAsText(frameIndex:Int) -> String {
        if let result = game.frameScore(frameIndex: frameIndex)  {
            return String(result)
        }
        return "-"
    }
    
    func addBowlResult(num: Int) {
        _ = game.addBowlResult(num)
    }
}

