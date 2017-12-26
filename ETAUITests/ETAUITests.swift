//
//  ETAUITests.swift
//  ETAUITests
//
//  Created by Jaime Remedios on 09/10/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import XCTest

class ETAUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test.
        // Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation -
        // required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice().orientation = .portrait
        let screenshot = XCUIApplication().windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot, quality: .original)
        add(attachment)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["702"]/*[[".cells.staticTexts[\"702\"]",".staticTexts[\"702\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Interface Campolide"]/*[[".cells.staticTexts[\"Interface Campolide\"]",".staticTexts[\"Interface Campolide\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["New Message"].buttons["Cancel"].tap()
        let screenshot = XCUIApplication().windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        add(attachment)
    }

}
