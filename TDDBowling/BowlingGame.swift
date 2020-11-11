//
//  BowlingGame.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/08
//  © 2020  SmallDeskSoftware
//

import Foundation

struct BowlingGame {
    var frames:[Frame] = [Frame](repeating: .init(), count: 10)
    
    func findRecordableFrameBowl() -> (frameIndex:Int, bowlIndex:Int)? {
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
            self.frames[addIndex.frameIndex].bowls[addIndex.bowlIndex] = .Done(num)
            // case Strike
            if (num == 10) && (addIndex.bowlIndex == 0) { // Strike !
                self.frames[addIndex.frameIndex].bowls[1] = .NoNeed
            }
            return true
        }
        return false
    }
        
    func frameState(frameIndex:Int) -> FrameState {
        guard let bowl1 = bowlResult(frameIndex: frameIndex, bowlIndex: 0)  else { return .Others }
        if bowl1 == 10 { return .Strike }
        guard let bowl2 = bowlResult(frameIndex: frameIndex, bowlIndex: 1) else { return .Others }
        if bowl1 + bowl2 == 10 { return .Spare }
        return .Others
    }
        
    func bowlResult(frameIndex: Int, bowlIndex: Int)  -> Int? {
        let bowl = frames[frameIndex].bowls[bowlIndex]
        
        switch bowl {
            case .Done(let num):
                return num
            default:
                return nil
        }
    }
    
    func frameScore(frameIndex: Int) -> Int? {
        if let lastResult = frameIndex == 0 ? 0 : frameScore(frameIndex: frameIndex - 1) {
            switch frameState(frameIndex: frameIndex) {
                case .Spare:
                    if let nextBowl = bowlResult(frameIndex: frameIndex+1, bowlIndex: 0) {
                        return lastResult + 10 + nextBowl
                    }
                    return nil // need further info
                case .Strike:
                    if let nextBowl = bowlResult(frameIndex: frameIndex+1, bowlIndex: 0) {
                        switch frameState(frameIndex: frameIndex+1) {
                            case .Strike:
                                if let nextNextBowl = bowlResult(frameIndex: frameIndex+2, bowlIndex: 0) {
                                    return lastResult + 10 + 10 + nextNextBowl
                                }
                            case .Spare:
                                return lastResult + 10 + 10
                            case .Others:
                                if let nextNextBowl = bowlResult(frameIndex: frameIndex+1, bowlIndex: 1) {
                                    return lastResult + 10 + nextBowl + nextNextBowl
                                }
                        }
                    }
                    return nil // need further info
                case .Others:
                    if let bowl0 = bowlResult(frameIndex: frameIndex, bowlIndex: 0) {
                        if let bowl1 = bowlResult(frameIndex: frameIndex, bowlIndex: 1) {
                            return lastResult + bowl0 + bowl1
                        }
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

enum FrameState {
    case Others
    case Spare
    case Strike
}
