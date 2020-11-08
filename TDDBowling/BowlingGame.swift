//
//  BowlingGame.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/08
//  © 2020  SmallDeskSoftware
//

import Foundation

struct BowlingGame {
    var frames:[Frame] = [Frame](repeating: .init(), count: 10)
    
    mutating func addBowlResult(_ num: Int) -> Bool {
        self.frames[0].bowls[0] = .Done(num)
        return true
    }

    func bowlResult(frame: Int, bowl: Int)  -> Int? {
        let bowl = frames[frame].bowls[bowl]
        
        switch bowl {
            case .Done(let num):
                return num
            default:
                return nil
        }
    }
}

struct Frame {
    var bowls:[Bowl] = [.NotYet, .NotYet, .NoNeed]
}

enum Bowl {
    case NotYet
    case Done(Int)
    case NoNeed
}
