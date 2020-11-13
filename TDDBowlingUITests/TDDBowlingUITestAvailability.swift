//
//  TDDBowlingUITestAvailability.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/13
//  © 2020  SmallDeskSoftware
//

import XCTest

class TDDBowlingUITestAvailability: XCTestCase {
    var bowlButtons: [XCUIElement] = []
    var frameBowlLabels:[[XCUIElement]] = [[XCUIElement]]()
    var frameScoreLabels: [XCUIElement] = []
    var totalScoreLabel: XCUIElement!
    
    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        let app = XCUIApplication()
        app.launch()

        for index in 0..<10 {
            let button = app.buttons["Button\(index)"]
            bowlButtons.append(button)
            let bowl0 = app.staticTexts["FrameBowlView\(index)-0"]
            let bowl1 = app.staticTexts["FrameBowlView\(index)-1"]
            frameBowlLabels.append([bowl0, bowl1])
            let score = app.staticTexts["FrameScoreView\(index)"]
            frameScoreLabels.append(score)
        }

        let button10 = app.buttons["Button10"]
        bowlButtons.append(button10)

        let bowlf10b3 = app.staticTexts["FrameBowlView9-2"]
        frameBowlLabels[9].append(bowlf10b3)
        
        totalScoreLabel = app.staticTexts["TotalScoreView"]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_buttonAvailable_initial_allShouldBeAvailable() {
        // because this is first bowl, all button should be available
        for index in 0...10 {
            XCTAssertTrue(bowlButtons[index].isEnabled, "Button\(index) should be Enabled")
        }
    }
    
    func test_buttonAvailablability_afterBowl1_0_AvailabilityDepends() {
        bowlButtons[0].tap()
        // still all button should be available
        for index in 0...10 {
            XCTAssertTrue(bowlButtons[index].isEnabled, "Button\(index) should be Enabled")
        }
    }

    func test_buttonAvailablability_afterBowl1_4_AvailabilityDepends() {
        bowlButtons[4].tap()
        // 0-6 available, 7-10 unavailable
        for index in 0...6 {
            XCTAssertTrue(bowlButtons[index].isEnabled, "Button\(index) should be Enabled")
        }
        for index in 7...10 {
            XCTAssertFalse(bowlButtons[index].isEnabled, "Button\(index) should not be Enabled")
        }
    }
    
    func test_buttonAvailablability_atFrame10StartWith4Then1_AvailabilityDepends() {
        // finish 9 frames
        for _ in 0...8 {  bowlButtons[10].tap() }
        
        // at 10-th frame
        bowlButtons[4].tap()
        for index in 0...6 {
            XCTAssertTrue(bowlButtons[index].isEnabled, "Button\(index) should be Enabled")
        }
        for index in 7...10 {
            XCTAssertFalse(bowlButtons[index].isEnabled, "Button\(index) should not be Enabled")
        }
        
        bowlButtons[1].tap()
        for index in 0...10 {
            XCTAssertFalse(bowlButtons[index].isEnabled, "Button\(index) should not be Enabled")
        }
    }
    
    func test_buttonAvailablability_atFrame10With4ThenSpareThen3_AvailabilityDepends() {
        // finish 9 frames
        for _ in 0...8 {  bowlButtons[10].tap() }
        
        // at 10-th frame
        bowlButtons[4].tap()
        for index in 0...6 {
            XCTAssertTrue(bowlButtons[index].isEnabled, "Button\(index) should be Enabled")
        }
        for index in 7...10 {
            XCTAssertFalse(bowlButtons[index].isEnabled, "Button\(index) should not be Enabled")
        }
        
        bowlButtons[6].tap()
        for index in 0...10 {
            XCTAssertTrue(bowlButtons[index].isEnabled, "Button\(index) should be Enabled")
        }
        bowlButtons[3].tap()
        for index in 0...10 {
            XCTAssertFalse(bowlButtons[index].isEnabled, "Button\(index) should not be Enabled")
        }
    }

    func test_buttonAvailablability_atFrame10StrikeThen3ThenSpare_AvailabilityDepends() {
        for _ in 0...8 {  bowlButtons[10].tap() }

        // at 10-th frame
        bowlButtons[10].tap()
        for index in 0...10 {
            XCTAssertTrue(bowlButtons[index].isEnabled, "Button\(index) should be Enabled")
        }

        bowlButtons[3].tap()
        for index in 0...7 {
            XCTAssertTrue(bowlButtons[index].isEnabled, "Button\(index) should be Enabled")
        }
        for index in 8...10 {
            XCTAssertFalse(bowlButtons[index].isEnabled, "Button\(index) should not be Enabled")
        }

        bowlButtons[7].tap()
        for index in 0...10 {
            XCTAssertFalse(bowlButtons[index].isEnabled, "Button\(index) should not be Enabled")
        }
    }

    func test_buttonAvailablability_atFrame102StrikeThen3_AvailabilityDepends() {
        for _ in 0...8 {  bowlButtons[10].tap() }

        // at 10-th frame
        bowlButtons[10].tap()
        for index in 0...10 {
            XCTAssertTrue(bowlButtons[index].isEnabled, "Button\(index) should be Enabled")
        }

        bowlButtons[10].tap()
        for index in 0...10 {
            XCTAssertTrue(bowlButtons[index].isEnabled, "Button\(index) should be Enabled")
        }

        bowlButtons[3].tap()
        for index in 0...10 {
            XCTAssertFalse(bowlButtons[index].isEnabled, "Button\(index) should not be Enabled")
        }
    }
}
