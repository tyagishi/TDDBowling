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
    
    func test_buttonAvailable_bowl1_shouldBeAvailable() {
        // because this is first bowl, all button should be available
        XCTAssertTrue(bowlButtons[0].isHittable)
    }

}
