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

        let bowl00 = bowlingGame.bowlResult(frame: 0, bowl: 0)
        XCTAssertEqual(bowl00, 3)

        let resultBowl1 = bowlingGame.addBowlResult(5)
        XCTAssertTrue(resultBowl1)

        let bowl01 = bowlingGame.bowlResult(frame: 0, bowl: 1)
        XCTAssertEqual(bowl01, 5)
    }
    
    func test_recordScore_wholeGameWithOutSpareStrike_shouldBeRecorded() {
        var bowlingGame = BowlingGame()
        var gameData:[[Int]] = []
        
        for _ in 0..<10 {
            let bowl1 = Int.random(in: 0..<10)
            let bowlResult1 = bowlingGame.addBowlResult(bowl1)
            XCTAssertNotNil(bowlResult1)
            let bowl2 = Int.random(in: 0..<(9-bowl1))
            let bowlResult2 = bowlingGame.addBowlResult(bowl2)
            XCTAssertNotNil(bowlResult2)
            gameData.append([bowl1, bowl2])
        }
        
        for index in 0..<10 {
            XCTAssertEqual(bowlingGame.bowlResult(frame: index, bowl: 0), gameData[index][0])
            XCTAssertEqual(bowlingGame.bowlResult(frame: index, bowl: 1), gameData[index][1])
        }
    }
}
