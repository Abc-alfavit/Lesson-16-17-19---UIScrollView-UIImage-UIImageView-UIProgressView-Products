//
//  Lesson_16_and_17___UIScrollView___UIImage___UIImageView___ProductsUITestsLaunchTests.swift
//  Lesson 16 and 17 - UIScrollView & UIImage & UIImageView - ProductsUITests
//
//  Created by Валентин Ремизов on 05.03.2023.
//

import XCTest

final class Lesson_16_and_17___UIScrollView___UIImage___UIImageView___ProductsUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
