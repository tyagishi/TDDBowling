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
    
    func bowlAsTextForFrame10(bowlIndex: Int) -> String {
        switch bowlIndex {
            case 0:
                if let bowl0 = game.bowlResult(frameIndex: 9, bowlIndex: 0) {
                    if bowl0 == 10 {
                        return "X"
                    }
                    return String(bowl0)
                }
                return "-"
            case 1:
                if let bowl0 = game.bowlResult(frameIndex: 9, bowlIndex: 0) {
                    if let bowl1 = game.bowlResult(frameIndex: 9, bowlIndex: 1) {
                        if bowl0 == 10 {
                            if bowl1 == 10 { return "X" }
                            return String(bowl1)
                        }
                        if (bowl0 + bowl1 == 10) { return "/" }
                        return String(bowl1)
                    }
                }
                return "-"
            case 2:
                if let bowl1 = game.bowlResult(frameIndex: 9, bowlIndex: 1) {
                    if let bowl2 = game.bowlResult(frameIndex: 9, bowlIndex: 2) {
                        if bowl2 == 10 { return "X" }
                        if bowl1 + bowl2 == 10 { return "/" }
                        return String(bowl2)
                    }
                }
                return "-"
            default:
                return "-"
        }
    }
    
    func bowlAsText(frameIndex:Int, bowlIndex: Int) -> String {
        if (frameIndex == 9) {
            return bowlAsTextForFrame10(bowlIndex: bowlIndex)
        }
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
    
    func isButtonAvailable(index: Int) -> Bool {
        if let availableRange = game.availableRangeForNextThrow() {
            return availableRange.contains(index)
        }
        return false
    }
}

