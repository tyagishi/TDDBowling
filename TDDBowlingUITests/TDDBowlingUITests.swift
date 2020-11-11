//
//  TDDBowlingUITests.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/08
//  © 2020  SmallDeskSoftware
//

import XCTest

class TDDBowlingUITests: XCTestCase {
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
        totalScoreLabel = app.staticTexts["TotalScoreView"]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_LabelExists() throws {
        for index in 0..<10 {
            XCTAssertTrue(frameBowlLabels[index][0].exists)
            XCTAssertTrue(frameBowlLabels[index][1].exists)
            XCTAssertTrue(frameScoreLabels[index].exists)
        }
        XCTAssertTrue(totalScoreLabel.exists)
    }

    func test_RecordOneFrame_TwoBowl_ShouldBeRecordedAndAtFirstFrame() throws {
        checkAndThrowFrame(prevResult: 0, frameIndex: 0, num1: 1, num2: 5)
    }
    
    func test_ScoreAtEachFrame_From0To9FrameNoSpareNoStrike_CorrectlyDisplayed() {
        var localScore:Int = 0
        for index in 0..<10 {
            let (bowl0, bowl1) = randomBowlForFrame()
            checkAndThrowFrame(prevResult: localScore, frameIndex: index, num1: bowl0, num2: bowl1)
            localScore = localScore + bowl0 + bowl1
        }
        
        XCTAssertEqual(totalScoreLabel.label, String(localScore))
    }
    
    
    func checkAndThrowFrame(prevResult: Int, frameIndex:Int, num1:Int, num2:Int) {
        XCTAssertEqual(frameBowlLabels[frameIndex][0].label, "-")
        XCTAssertEqual(frameBowlLabels[frameIndex][1].label, "-")
        XCTAssertEqual(frameScoreLabels[frameIndex].label, "-")

        self.bowlButtons[num1].tap()
        XCTAssertEqual(frameBowlLabels[frameIndex][0].label, String(num1))
        XCTAssertEqual(frameBowlLabels[frameIndex][1].label, "-")
        XCTAssertEqual(frameScoreLabels[frameIndex].label, "-")

        self.bowlButtons[num2].tap()
        XCTAssertEqual(frameBowlLabels[frameIndex][0].label, String(num1))
        XCTAssertEqual(frameBowlLabels[frameIndex][1].label, String(num2))
        XCTAssertEqual(frameScoreLabels[frameIndex].label, String(prevResult + num1 + num2))
    }
    
    func randomBowlForFrame() -> (Int, Int) {
        let bowl0 = Int.random(in: 0..<10)
        let bowl1 = Int.random(in: 0..<(10-bowl0))
        return (bowl0, bowl1)
    }
    
    func test_ScoreAtFirst2Frames_From0To1WithSpareAtFirstFrame_CorrectlyDisplayed() {
        bowlButtons[5].tap()
        bowlButtons[5].tap()
        XCTAssertEqual(frameBowlLabels[0][0].label, "5")
        XCTAssertEqual(frameBowlLabels[0][1].label, "/")
        XCTAssertEqual(frameScoreLabels[0].label, "-") // still un-calculatable
        
        bowlButtons[6].tap()
        XCTAssertEqual(frameScoreLabels[0].label, "16") // now can calculate frameScoreLabels[0]
        
        bowlButtons[2].tap()
        XCTAssertEqual(frameScoreLabels[1].label, "24")
    }
    

}
