//
//  FAQViewTests.swift
//  FAQViewTests
//
//  Created by Mukesh Thawani on 12/11/16.
//  Copyright © 2016 Mukesh Thawani. All rights reserved.
//

import XCTest
@testable import FAQView

class FAQViewTests: XCTestCase {
  
  var faqView: FAQView!
  let blueColor = UIColor.blue
  let systemFont = UIFont.systemFont(ofSize: 20)
  
  override func setUp() {
    super.setUp()
    let item = FAQItem(question: "Question", answer: "Answer")
    faqView = FAQView(frame: CGRect.zero, items: [item])
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func test_TitleLabelProperties_WhenSetToDefault() {
    let titleLabel = faqView.titleLabel
    let configuration = faqView.configuration
    XCTAssertEqual(titleLabel?.backgroundColor, configuration.titleLabelBackgroundColor)
    XCTAssertEqual(titleLabel?.textColor, configuration.titleTextColor)
    XCTAssertEqual(titleLabel?.font, configuration.titleTextFont)
  }
  
  func test_TitleLabelProperties_WhenCustomized() {
    let titleLabel = faqView.titleLabel
    faqView.titleLabelBackgroundColor = UIColor.blue
    faqView.titleLabelTextColor = UIColor.blue
    faqView.titleLabelTextFont = UIFont.systemFont(ofSize: 20)
    XCTAssertEqual(titleLabel?.backgroundColor, UIColor.blue)
    XCTAssertEqual(titleLabel?.textColor, UIColor.blue)
    XCTAssertEqual(titleLabel?.font, UIFont.systemFont(ofSize: 20))
  }
  
  func test_ViewBackgroundColor_WhenSetToDefault() {
    XCTAssertEqual(faqView.backgroundColor, faqView.configuration.viewBackgroundColor)
  }
  
  func test_ViewBackgroundColor_WhenCustomized() {
    faqView.viewBackgroundColor = UIColor.blue
    XCTAssertEqual(faqView.backgroundColor, UIColor.blue)
  }
  
  func test_QuestionLabelProperties_WhenSetToDefault() {
    let faqViewCell = faqView.tableView(faqView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! FAQViewCell
    let questionLabel = faqViewCell.questionLabel
    let configuration = faqView.configuration
    XCTAssertEqual(questionLabel.textColor, configuration.questionTextColor)
    XCTAssertEqual(questionLabel.font, configuration.questionTextFont)
  }
  
  func test_QuestionLabelProperties_WhenCustomized() {
    faqView.questionTextColor = blueColor
    faqView.questionTextFont = systemFont
    let faqViewCell = faqView.tableView(faqView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! FAQViewCell
    let questionLabel = faqViewCell.questionLabel
    XCTAssertEqual(questionLabel.textColor, blueColor)
    XCTAssertEqual(questionLabel.font, systemFont)
  }
  
  func test_AnswerLabelProperties_WhenSetToDefault() {
    let faqViewCell = faqView.tableView(faqView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! FAQViewCell
    let answerLabel = faqViewCell.answerLabel
    let configuration = faqView.configuration
    XCTAssertEqual(answerLabel.textColor, configuration.answerTextColor)
    XCTAssertEqual(answerLabel.font, configuration.answerTextFont)
  }
  
  func test_AnswerLabelProperties_WhenCustomized() {
    faqView.answerTextColor = blueColor
    faqView.answerTextFont = systemFont
    let faqViewCell = faqView.tableView(faqView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! FAQViewCell
    let answerLabel = faqViewCell.answerLabel
    XCTAssertEqual(answerLabel.textColor, blueColor)
    XCTAssertEqual(answerLabel.font, systemFont)
  }
  
}
