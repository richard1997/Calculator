//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Jiaren on 4/2/18.
//  Copyright © 2018 Jiaren. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorTests: XCTestCase {

    var tmpClass:ViewController?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tmpClass = ViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        tmpClass = nil
    }
    
    func testCalucalte() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let firstExp = "6x5+3÷2-6"
        XCTAssertEqual(tmpClass?.calculate(firstExp), 25.5)
        
        let sndExp = "5+3-4÷2"
        XCTAssertEqual(tmpClass?.calculate(sndExp), 6)
        
        let thrdExp = "5x3-4÷2+5"
        XCTAssertNotEqual(tmpClass?.calculate(thrdExp), 12)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
