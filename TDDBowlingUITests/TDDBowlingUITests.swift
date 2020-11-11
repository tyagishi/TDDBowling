//
//  TDDBowlingUITests.swift
//
//  Created by : Tomoaki Yagishita on 2020/11/08
//  © 2020  SmallDeskSoftware
//

import XCTest

class TDDBowlingUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_RecordOneBowl_FirstBowl_OnlyOneShouldBeRecorded() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let button1 = app.buttons["Button1"]
        XCTAssertTrue(button1.exists)

        let frame0bowl0Label = app.staticTexts["FrameBowlView0-0"]
        XCTAssertTrue(frame0bowl0Label.exists)

        XCTAssertEqual(frame0bowl0Label.label, "-")
        
        button1.tap()

        XCTAssertEqual(frame0bowl0Label.label, "1")
    }

}
