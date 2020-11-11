//
//  BowlingGame.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/08
//  © 2020  SmallDeskSoftware
//

import Foundation

struct BowlingGame {
    var frames:[Frame] = [Frame](repeating: .init(), count: 10)
    
    func findRecordableFrameBowl() -> (frame:Int, bowl:Int)? {
        for frameIndex in 0..<10 {
            let frame = frames[frameIndex]
            for bowlIndex in 0..<3 {
                let bowl = frame.bowls[bowlIndex]
                switch bowl {
                    case .Done(_):
                        continue
                    case .NoNeed:
                        continue
                    case .NotYet:
                        return (frameIndex, bowlIndex)
                }
            }
        }
        return nil
    }
    
    mutating func addBowlResult(_ num: Int) -> Bool {
        if let addIndex = self.findRecordableFrameBowl() {
            self.frames[addIndex.frame].bowls[addIndex.bowl] = .Done(num)
            return true
        }
        return false
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
    
    func frameResult(frame: Int) -> Int? {
        if ( frame == 0 ) {
            if let bowl0 = bowlResult(frame: 0, bowl: 0) {
                if let bowl1 = bowlResult(frame: 0, bowl: 1) {
                    return bowl0 + bowl1
                }
            }
            return nil
        }
        
        if let lastResult = frameResult(frame: frame - 1) {
            if let bowl0 = bowlResult(frame: frame, bowl: 0) {
                if let bowl1 = bowlResult(frame: frame, bowl: 1) {
                    return lastResult + bowl0 + bowl1
                }
            }
        }
        return nil
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
