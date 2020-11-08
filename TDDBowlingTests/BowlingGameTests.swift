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
    
    func test_putScore_atFrame0Bowl0_shouldBeRecorded() {
        var bowlingGame = BowlingGame()

        let resultBowl0 = bowlingGame.addBowlResult(3)
        XCTAssertTrue(resultBowl0)

        let bowl00 = bowlingGame.bowlResult(frame: 0, bowl: 0)
        XCTAssertEqual(bowl00, 3)
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

//    func test_putScore_atFrame0Bowl0_shouldBeRecorded() {
//        let bowlingGame = BowlingGame()
//
//        let result1 = bowlingGame.addBowlResult(3)
//        XCTAssertTrue(result1)
//
////        let result2 = bowlingGame.addBowlResult(2)
////        XCTAssertTrue(result2)
//
//        let bowl11 = bowlingGame.bowlResult(frame: 0, bowl: 0)
//        XCTAssertEqual(bowl11, 3)
//
////        let bowl12 = bowlingGame.bowlResult(frame: 0, bowl: 1)
////        XCTAssertEqual(bowl11, 2)
//    }
//    func test_<#methodName#>_<#withCertainState#>_<#shouldDoSomething#>() {
//    <#Arrange, Act, Assert#>
//    }
    
}
