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
    
    func bowlAsText(frame:Int, bowl: Int) -> String {
        if let num = game.bowlResult(frame: frame, bowl: bowl) {
            return String(num)
        }
        return "-"
    }

    func scoreAsText(frame:Int) -> String {
        return "0"
    }
    
    func addBowlResult(num: Int) {
        _ = game.addBowlResult(num)
    }
}

