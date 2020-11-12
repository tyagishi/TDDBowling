//
//  BowlingGameTests.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/08
//  © 2020  SmallDeskSoftware
//

import XCTest
@testable import TDDBowling

class BowlingGameTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_initializeBowlingGame_withoutAnyArguments() {
        let bowlingGame = BowlingGame()
        XCTAssertNotNil(bowlingGame)
    }
    
    func test_putScore_atFrame0Bowl0And1_shouldBeRecorded() {
        var bowlingGame = BowlingGame()

        let resultBowl0 = bowlingGame.addBowlResult(3)
        XCTAssertTrue(resultBowl0)

        let bowl00 = bowlingGame.bowlResult(frameIndex: 0, bowlIndex: 0)
        XCTAssertEqual(bowl00, 3)

        let resultBowl1 = bowlingGame.addBowlResult(5)
        XCTAssertTrue(resultBowl1)

        let bowl01 = bowlingGame.bowlResult(frameIndex: 0, bowlIndex: 1)
        XCTAssertEqual(bowl01, 5)
    }
    
    func test_recordScore_wholeGameWithOutSpareStrike_shouldBeRecorded() {
        var bowlingGame = BowlingGame()
        var gameData:[[Int]] = []
        
        for _ in 0..<10 {
            let bowl1 = Int.random(in: 0..<10)
            let bowlResult1 = bowlingGame.addBowlResult(bowl1)
            XCTAssertNotNil(bowlResult1)
            let bowl2 = Int.random(in: 0..<(10-bowl1))
            let bowlResult2 = bowlingGame.addBowlResult(bowl2)
            XCTAssertNotNil(bowlResult2)
            gameData.append([bowl1, bowl2])
        }
        
        for index in 0..<10 {
            XCTAssertEqual(bowlingGame.bowlResult(frameIndex: index, bowlIndex: 0), gameData[index][0])
            XCTAssertEqual(bowlingGame.bowlResult(frameIndex: index, bowlIndex: 1), gameData[index][1])
        }
    }
    
    func test_recordScore_12Strikes_shouldBeRecorded() {
        var bowlingGame = BowlingGame()

        for index in 0..<9 {
            XCTAssertTrue(bowlingGame.addBowlResult(10), "failed to record \(index+1)-th strike ")
        }

        XCTAssertTrue(bowlingGame.addBowlResult(10), "failed to record 10-th strike ")

        XCTAssertNil(bowlingGame.frameScore(frameIndex: 8))
        XCTAssertNil(bowlingGame.frameScore(frameIndex: 9))

        XCTAssertTrue(bowlingGame.addBowlResult(10), "failed to record 11-th strike ")

        XCTAssertEqual(bowlingGame.frameScore(frameIndex: 8), 270)
        XCTAssertNil(bowlingGame.frameScore(frameIndex: 9))

        XCTAssertTrue(bowlingGame.addBowlResult(10), "failed to record 12-th strike ")

        XCTAssertEqual(bowlingGame.frameScore(frameIndex: 9), 300)
    }

    func test_recordScore_11StrikesPlus1_shouldBeRecorded() {
        var bowlingGame = BowlingGame()

        for index in 0..<11 {
            XCTAssertTrue(bowlingGame.addBowlResult(10), "failed to record \(index+1)-th strike ")
        }
        XCTAssertEqual(bowlingGame.frameScore(frameIndex: 8), 270)
        XCTAssertNil(bowlingGame.frameScore(frameIndex: 9))

        XCTAssertTrue(bowlingGame.addBowlResult(3), "failed to record 3rd throw in 10th frame")

        XCTAssertEqual(bowlingGame.frameScore(frameIndex: 9), 293)
    }

    func test_recordScore_10StrikesPlus2_shouldBeRecorded() {
        var bowlingGame = BowlingGame()

        for index in 0..<10 {
            XCTAssertTrue(bowlingGame.addBowlResult(10), "failed to record \(index+1)-th strike ")
        }
        XCTAssertNil(bowlingGame.frameScore(frameIndex: 8))
        XCTAssertNil(bowlingGame.frameScore(frameIndex: 9))

        XCTAssertTrue(bowlingGame.addBowlResult(3), "failed to record 2nd throw in 10th frame")

        XCTAssertEqual(bowlingGame.frameScore(frameIndex: 8), 263)
        XCTAssertNil(bowlingGame.frameScore(frameIndex: 9))
        
        XCTAssertTrue(bowlingGame.addBowlResult(3), "failed to record 3rd throw in 10th frame")

        XCTAssertEqual(bowlingGame.frameScore(frameIndex: 9), 279)
    }

    func test_recordScore_9StrikesPlusSparePlus1_shouldBeRecorded() {
        var bowlingGame = BowlingGame()

        for index in 0..<9 {
            XCTAssertTrue(bowlingGame.addBowlResult(10), "failed to record \(index+1)-th strike ")
        }
        XCTAssertNil(bowlingGame.frameScore(frameIndex: 8))

        XCTAssertTrue(bowlingGame.addBowlResult(4), "failed to record 1st throw in 10th frame")
        
        XCTAssertNil(bowlingGame.frameScore(frameIndex: 8))
        XCTAssertNil(bowlingGame.frameScore(frameIndex: 9))
        
        XCTAssertTrue(bowlingGame.addBowlResult(6), "failed to record 2nd throw in 10th frame")
        
        XCTAssertEqual(bowlingGame.frameScore(frameIndex: 8), 254)
        XCTAssertNil(bowlingGame.frameScore(frameIndex: 9))
        
        XCTAssertTrue(bowlingGame.addBowlResult(5), "failed to record 3rd throw in 10th frame")
        
        XCTAssertEqual(bowlingGame.frameScore(frameIndex: 9), 269)
    }

}
