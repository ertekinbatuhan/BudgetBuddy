//
//  Finance_TrackerUITests.swift
//  Finance TrackerUITests
//
//  Created by Batuhan Berk Ertekin on 3.08.2024.
//

import XCTest

final class Finance_TrackerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddingFinance() throws {
        
        let app = XCUIApplication()
        app.launch()

        let financeAddButton = app.navigationBars["Welcome"].buttons["Add"]
        financeAddButton.tap()
        
        let collectionViewsQuery = app.collectionViews
        let titleTextField = collectionViewsQuery.textFields["Enter title here"]
        let descriptionTextField = collectionViewsQuery.textFields["Enter description here"]
        let amountTextField = collectionViewsQuery.textFields["Write amount"]
        let financeSaveButton =  app.navigationBars["Add Finance"]/*@START_MENU_TOKEN@*/.buttons["Add"]/*[[".otherElements[\"Add\"].buttons[\"Add\"]",".buttons[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        titleTextField.tap()
        titleTextField.typeText("Sample Title")
        
        descriptionTextField.tap()
        descriptionTextField.typeText("Sample Description")
        
        amountTextField.tap()
        amountTextField.typeText("100")
        
       let datePicker = collectionViewsQuery.datePickers.collectionViews.staticTexts["3"]
       datePicker.tap()
        
       financeSaveButton.tap()
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
