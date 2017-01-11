//
//  FAQView.swift
//  FAQView
//
//  Created by Mukesh Thawani on 12/11/16.
//  Copyright © 2016 Mukesh Thawani. All rights reserved.
//

import Foundation

public class FAQView: UIView {
  
  var tableView: UITableView!
  var titleLabel: UILabel!
  
  public var items: [FAQItem]
  
  var expandedCells: [Int]!
  
  public var questionTextColor: UIColor!  {
    get {
      return configuration.questionTextColor
    }
    set(value) {
      configuration.questionTextColor = value
    }
  }
  
  public var answerTextColor: UIColor! {
    get {
      return configuration.answerTextColor
    }
    set(value) {
      configuration.answerTextColor = value
    }
  }
  
  public var questionTextFont: UIFont! {
    get {
      return configuration.questionTextFont
    }
    set(value) {
      configuration.questionTextFont = value
    }
  }
  
  public var answerTextFont: UIFont! {
    get {
      return configuration.answerTextFont
    }
    set(value) {
      configuration.answerTextFont = value
    }
  }
  
  public var titleLabelTextColor: UIColor! {
    get {
      return configuration.titleTextColor
    }
    set(value) {
      configuration.titleTextColor = value
      titleLabel.textColor = configuration.titleTextColor
    }
  }
  
  public var titleLabelTextFont: UIFont! {
    get {
      return configuration.titleTextFont
    }
    set(value) {
      configuration.titleTextFont = value
      titleLabel.font = configuration.titleTextFont
    }
  }
  
  public var titleLabelBackgroundColor: UIColor! {
    get {
      return configuration.titleLabelBackgroundColor
    }
    set(value) {
      configuration.titleLabelBackgroundColor = value
      titleLabel.backgroundColor = configuration.titleLabelBackgroundColor
    }
  }
  
  public var viewBackgroundColor: UIColor! {
    get {
      return configuration.viewBackgroundColor
    }
    set(value) {
      configuration.viewBackgroundColor = value
      self.backgroundColor = configuration.viewBackgroundColor
    }
  }
  
  public var cellBackgroundColor: UIColor! {
    get {
      return configuration.cellBackgroundColor
    }
    set(value) {
      configuration.cellBackgroundColor = value
    }
  }
  
  public var separatorColor: UIColor! {
    get {
      return configuration.separatorColor
    }
    set(value) {
      configuration.separatorColor = value
    }
  }
  
  var configuration = FAQConfiguration()
  
  public init(frame: CGRect,title: String = "Top Queries", items: [FAQItem]) {
    self.items = items
    super.init(frame: frame)
    self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
    self.tableView.translatesAutoresizingMaskIntoConstraints = false
    self.tableView.backgroundColor = UIColor.clear
    self.tableView.register(FAQViewCell.self, forCellReuseIdentifier: "cell")
    self.tableView.allowsSelection = false
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.expandedCells = []
    self.tableView.estimatedRowHeight = 50
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.tableFooterView = UIView()
    self.titleLabel = UILabel()
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
    self.titleLabel.text = title
    self.titleLabel.numberOfLines = 0
    self.titleLabel.textAlignment = .center
    self.titleLabel.textColor = configuration.titleTextColor
    self.titleLabel.font = configuration.titleTextFont
    self.titleLabel.backgroundColor = configuration.titleLabelBackgroundColor
    self.backgroundColor = configuration.viewBackgroundColor
    self.tableView.separatorStyle = .none
    self.addSubview(tableView)
    self.addSubview(titleLabel)
    addConstraintsForTableViewAndTitleLabel()
  }
  
  private func addConstraintsForTableViewAndTitleLabel() {
    
    let titleLabelTrailing = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: 0)
    let titleLabelLeading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 0)
    let titleLabelTop = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 20)
    
    
    let tableViewTrailing = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: 0)
    let tableViewLeading = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 0)
    let tableViewTop = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 15)
    let tableViewBottom = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: 0)
    NSLayoutConstraint.activate([tableViewTrailing, tableViewLeading, tableViewTop, tableViewBottom, titleLabelLeading, titleLabelTrailing, titleLabelTop])
  }
  
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func handleQuestionLabelTap(_ sender: UITapGestureRecognizer) {
    let section = sender.view?.tag
    guard let sectionValue = section else {
      return
    }
    updateSection(sectionValue)
  }
  
  func updateSection(_ section: Int) {
    guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: section)) as? FAQViewCell else { return }
    let currentItem = items[section]
    if expandedCells.contains(section) {
      let index = expandedCells.index(of: section)
      expandedCells.remove(at: index!)
      cell.collapse(animated: true)
    } else {
      expandedCells.append(section)
      cell.expand(withAnswer: currentItem.answer, animated: true)
    }
    tableView.beginUpdates()
    tableView.endUpdates()
  }
  
  }

extension FAQView: UITableViewDelegate, UITableViewDataSource {
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    return items.count
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = FAQViewCell(style: .default, reuseIdentifier: "cell", configuration: configuration)
    let currentItem = items[indexPath.section]
    cell.questionLabel.text = currentItem.question
    cell.questionLabel.tag = indexPath.section
    let gestureRecog = UITapGestureRecognizer(target: self, action: #selector(FAQView.handleQuestionLabelTap(_:)))
    cell.questionLabel.addGestureRecognizer(gestureRecog)
    cell.questionLabel.isUserInteractionEnabled = true
    if expandedCells.contains(indexPath.section) {
      cell.expand(withAnswer: currentItem.answer, animated: false)
    }
    return cell
  }
  
  public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 5
  }
  
  public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return CGFloat.leastNormalMagnitude
  }
  
  public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 5))
    headerView.backgroundColor = configuration.separatorColor
    return headerView
  }
}

public struct FAQItem {
  public let question: String
  public let answer: String
  
  public init(question: String, answer: String) {
    self.question = question
    self.answer = answer
  }
}

public class FAQConfiguration {
  
  public var questionTextColor: UIColor?
  public var answerTextColor: UIColor?
  public var questionTextFont: UIFont?
  public var answerTextFont: UIFont?
  public var titleTextColor: UIColor?
  public var titleTextFont: UIFont?
  public var viewBackgroundColor: UIColor?
  public var cellBackgroundColor: UIColor?
  public var separatorColor: UIColor?
  public var titleLabelBackgroundColor: UIColor?
  
  init() {
    defaultValue()
  }
  
  func defaultValue() {
    self.questionTextColor = UIColor.black
    self.answerTextColor = UIColor.black
    self.questionTextFont = UIFont(name: "HelveticaNeue-Bold", size: 16)
    self.answerTextFont = UIFont(name: "HelveticaNeue-Light", size: 15)
    self.titleTextColor = UIColor.black
    self.titleTextFont = UIFont(name: "HelveticaNeue-Light", size: 20)
    self.titleLabelBackgroundColor = UIColor.clear
    self.viewBackgroundColor =  UIColor(colorLiteralRed: 210/255, green: 210/255, blue: 210/255, alpha: 1)
    self.cellBackgroundColor = UIColor.white
    self.separatorColor = UIColor(colorLiteralRed: 210/255, green: 210/255, blue: 210/255, alpha: 1)
  }
}


class FAQViewCell: UITableViewCell {
  
  var configuration: FAQConfiguration!
  var questionLabel: UILabel!
  var answerLabel: UILabel!
  var indicatorImageView: UIImageView!
  var answerLabelBottom: NSLayoutConstraint!
  private var containerView: UIView!
  
  init(style: UITableViewCellStyle, reuseIdentifier: String?, configuration: FAQConfiguration) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.backgroundColor = configuration.cellBackgroundColor
    self.questionLabel = UILabel()
    self.answerLabel = UILabel()
    self.indicatorImageView = UIImageView()
    self.containerView = UIView()
    self.answerLabelBottom = NSLayoutConstraint()
    self.questionLabel.translatesAutoresizingMaskIntoConstraints = false
    self.answerLabel.translatesAutoresizingMaskIntoConstraints = false
    self.indicatorImageView.translatesAutoresizingMaskIntoConstraints = false
    self.containerView.translatesAutoresizingMaskIntoConstraints = false
    self.questionLabel.numberOfLines = 0
    self.answerLabel.numberOfLines = 0
    self.questionLabel.textColor = configuration.questionTextColor
    self.answerLabel.textColor = configuration.answerTextColor
    self.questionLabel.font = configuration.questionTextFont
    self.answerLabel.font = configuration.answerTextFont
    let indicatorImage = UIImage(named: "DownArrow", in: Bundle(for: FAQView.self), compatibleWith: nil)
    self.indicatorImageView.image = indicatorImage
    self.indicatorImageView.contentMode = .scaleAspectFit
    self.containerView.addSubview(indicatorImageView)
    addSubview(questionLabel)
    addSubview(answerLabel)
    addSubview(containerView)
    addLabelConstraints()
  }
  
  private func addLabelConstraints() {
    let questionLabelTrailing = NSLayoutConstraint(item: questionLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -30)
    let questionLabelLeading = NSLayoutConstraint(item: questionLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 0)
    let questionLabelTop = NSLayoutConstraint(item: questionLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10)
    
    let answerLabelTrailing = NSLayoutConstraint(item: answerLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: -30)
    let answerLabelLeading = NSLayoutConstraint(item: answerLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1, constant: 0)
    let answerLabelTop = NSLayoutConstraint(item: answerLabel, attribute: .top, relatedBy: .equal, toItem: questionLabel, attribute: .bottom, multiplier: 1, constant: 10)
    answerLabelBottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: answerLabel, attribute: .bottom, multiplier: 1, constant: 0)
    
    let indicatorHorizontalCenter = NSLayoutConstraint(item: indicatorImageView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0)
    let indicatorVerticalCenter = NSLayoutConstraint(item: indicatorImageView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0)
    let indicatorWidth = NSLayoutConstraint(item: indicatorImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
    let indicatorHeight = NSLayoutConstraint(item: indicatorImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
    
    let containerTrailing = NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1, constant: 5)
    let containerWidth = NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
    let containerTop = NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: self,attribute: .top, multiplier: 1, constant: 10)
    let containerHeight = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: questionLabel, attribute: .height, multiplier: 1, constant: 0)
    
    
    NSLayoutConstraint.activate([questionLabelTrailing, questionLabelLeading, questionLabelTop, answerLabelLeading
      , answerLabelTrailing, answerLabelTop ,answerLabelBottom, indicatorVerticalCenter, indicatorHorizontalCenter, indicatorWidth, indicatorHeight, containerTrailing, containerTop, containerWidth, containerHeight])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func expand(withAnswer answer: String, animated: Bool) {
    self.answerLabel.text = answer
    if animated {
      self.answerLabel.alpha = 0
      UIView.animate(withDuration: 0.5, animations: {
        self.answerLabel.alpha = 1
      })
    }
    self.answerLabelBottom.constant = 20
    self.update(arrow: .Up, animated: animated)
  }
  
  
  func collapse(animated: Bool) {
    self.answerLabel.text = ""
    self.answerLabelBottom.constant = 0
    self.update(arrow: .Down, animated: animated)
  }
  
  func update(arrow: Arrow, animated: Bool) {
    switch arrow {
    case .Up:
      self.indicatorImageView.rotate(withAngle: CGFloat(M_PI), animated: animated)
    case .Down:
      self.indicatorImageView.rotate(withAngle: CGFloat(0), animated: animated)
    }
  }
}

enum Arrow: String {
  case Up
  case Down
}

extension UIImageView {
  func rotate(withAngle angle: CGFloat, animated: Bool) {
    if animated {
      UIView.animate(withDuration: 0.5, animations: {
        self.transform = CGAffineTransform(rotationAngle: angle)
      })
    } else {
      self.transform = CGAffineTransform(rotationAngle: angle)
    }
  }
}
