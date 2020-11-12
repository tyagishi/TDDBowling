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
            if (addIndex.frameIndex == 9) {
                if addIndex.bowlIndex != 2 {
                    if num == 10 {
                        self.frames[9].bowls[2] = .NotYet
                    }
                    if addIndex.bowlIndex == 1 {
                        if let bowl1 = bowlResult(frameIndex: 9, bowlIndex: 0) {
                            if bowl1 + num == 10 {
                                self.frames[9].bowls[2] = .NotYet
                            }
                        }
                    }
                }
                return true
            }
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
        if let prevFrameResult = frameIndex == 0 ? 0 : frameScore(frameIndex: frameIndex - 1) {
            if frameIndex == 9 {
                return frameScoreFor10th(prevFrameResult: prevFrameResult)
            }
            switch frameState(frameIndex: frameIndex) {
                case .Spare:
                    return calcSpareFrame(frameIndex: frameIndex, prevFrameResult: prevFrameResult)
                case .Strike:
                    return calcStrikeFrame(frameIndex: frameIndex, prevFrameResult: prevFrameResult)
                case .Others:
                    if let bowl0 = bowlResult(frameIndex: frameIndex, bowlIndex: 0) {
                        if let bowl1 = bowlResult(frameIndex: frameIndex, bowlIndex: 1) {
                            return prevFrameResult + bowl0 + bowl1
                        }
                    }
            }
        }
        return nil
    }
    
    func frameScoreFor10th(prevFrameResult:Int) -> Int? {
        if let f10b1 = bowlResult(frameIndex: 9, bowlIndex: 0) {
            if let f10b2 = bowlResult(frameIndex: 9, bowlIndex: 1) {
                if frames[9].bowls[2] == .NoNeed {
                    return prevFrameResult + f10b1 + f10b2
                }
                if let f10b3 = bowlResult(frameIndex: 9, bowlIndex: 2) {
                    return prevFrameResult + f10b1 + f10b2 + f10b3
                }
            }
        }
        return nil
    }
    
    func nextBowlIndex(frameIndex:Int, bowlIndex: Int) -> (frameIndex:Int, bowlIndex:Int)? {
        switch frameState(frameIndex: frameIndex) {
            case .Strike:
                return (frameIndex+1, 0)
            case .Spare:
                fallthrough
            case .Others:
                if bowlIndex == 0 {
                    return (frameIndex, 1)
                }
                return (frameIndex+1, 0)
        }
    }
    
    func calcSpareFrame(frameIndex:Int, prevFrameResult: Int) -> Int? {
        if let nextBowl = bowlResult(frameIndex: frameIndex+1, bowlIndex: 0) {
            return prevFrameResult + 10 + nextBowl
        }
        return nil // need further info
    }
    
    func calcStrikeFrame(frameIndex:Int, prevFrameResult: Int) -> Int? {
        if (frameIndex == 8) {
            if let f10b1 = bowlResult(frameIndex: 9, bowlIndex: 0) {
                if let f10b2 = bowlResult(frameIndex: 9, bowlIndex: 1) {
                    return prevFrameResult + 10 + f10b1 + f10b2
                }
            }
            return nil
        }
        if let nextBowl = bowlResult(frameIndex: frameIndex+1, bowlIndex: 0) {
            switch frameState(frameIndex: frameIndex+1) {
                case .Strike:
                    if let nextNextBowl = bowlResult(frameIndex: frameIndex+2, bowlIndex: 0) {
                        return prevFrameResult + 10 + 10 + nextNextBowl
                    }
                case .Spare:
                    return prevFrameResult + 10 + 10
                case .Others:
                    if let nextNextBowl = bowlResult(frameIndex: frameIndex+1, bowlIndex: 1) {
                        return prevFrameResult + 10 + nextBowl + nextNextBowl
                    }
            }
        }
        return nil // need further info
    }
}
   
struct Frame {
    var bowls:[Bowl] = [.NotYet, .NotYet, .NoNeed]
}

enum Bowl: Equatable {
    case NotYet
    case Done(Int)
    case NoNeed
    
    static func ==(lhs: Bowl, rhs:Bowl) -> Bool {
        switch (lhs, rhs) {
            case let (.Done(lhsNum), .Done(rhsNum)):
                return lhsNum == rhsNum
            case (.NotYet, .NotYet):
                return true
            case (.NoNeed, .NoNeed):
                return true
            default:
                return false
        }


    }
}

enum FrameState {
    case Others
    case Spare
    case Strike
}
