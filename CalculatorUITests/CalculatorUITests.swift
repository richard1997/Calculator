//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by Jiaren on 13/2/18.
//  Copyright © 2018 Jiaren. All rights reserved.
//

import XCTest

class CalculatorUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHandleButtonPress() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
                //let resultLbl = 
        
        let app = XCUIApplication()
        let button = app.buttons["6"]
        button.tap()
        XCTAssert(app.staticTexts["6"].exists)  //Main & Optional display
        
        app.buttons["x"].tap()
        XCTAssert(app.staticTexts["6x"].exists) //Main display
        XCTAssert(app.staticTexts["6 ? x"].exists) //Optional display
        
        app.buttons["5"].tap()
        XCTAssert(app.staticTexts["6x5"].exists) //Main display
        XCTAssert(app.staticTexts["6 5 x"].exists) //Optional display
        
        app.buttons["+"].tap()
        XCTAssert(app.staticTexts["6x5+"].exists) //Main display
        XCTAssert(app.staticTexts["6 5 x ? +"].exists) //Optional display
        
        app.buttons["3"].tap()
        XCTAssert(app.staticTexts["6x5+3"].exists) //Main display
        XCTAssert(app.staticTexts["6 5 x 3 +"].exists) //Optional display
        
        app.buttons["÷"].tap()
        XCTAssert(app.staticTexts["6x5+3÷"].exists) //Main display
        XCTAssert(app.staticTexts["6 5 x 3 ? ÷ +"].exists) //Optional display
        
        app.buttons["2"].tap()
        XCTAssert(app.staticTexts["6x5+3÷2"].exists) //Main display
        XCTAssert(app.staticTexts["6 5 x 3 2 ÷ +"].exists) //Optional display
        
        app.buttons["-"].tap()
        XCTAssert(app.staticTexts["6x5+3÷2-"].exists) //Main display
        XCTAssert(app.staticTexts["6 5 x 3 2 ÷ + ? -"].exists) //Optional display
        
        app.buttons["6"].tap()
        XCTAssert(app.staticTexts["6x5+3÷2-6"].exists) //Main display
        XCTAssert(app.staticTexts["6 5 x 3 2 ÷ + 6 -"].exists) //Optional display
        
        app.buttons["="].tap()
        XCTAssert(app.staticTexts["25.5"].exists)  //Main & Optional display
        
        app.buttons["+"].tap()
        XCTAssert(app.staticTexts["25.5+"].exists) //Main display
        XCTAssert(app.staticTexts["25.5 ? +"].exists) //Optional display
        
        app.buttons["-"].tap()
        XCTAssert(app.staticTexts["25.5-"].exists) //Main display
        XCTAssert(app.staticTexts["25.5 ? -"].exists) //Optional display
        
        app.buttons["3"].tap()
        XCTAssert(app.staticTexts["25.5-3"].exists) //Main display
        XCTAssert(app.staticTexts["25.5 3 -"].exists) //Optional display
        
        app.buttons["0"].tap()
        XCTAssert(app.staticTexts["25.5-30"].exists) //Main display
        XCTAssert(app.staticTexts["25.5 30 -"].exists) //Optional display
        
        app.buttons["="].tap()
        XCTAssert(app.staticTexts["-4.5"].exists)  //Main & Optional display
        
        app.buttons["C"].tap()
        XCTAssert(app.staticTexts["Ready"].exists)  //Main & Optional display
    }
    
}
