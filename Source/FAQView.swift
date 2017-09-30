//
//  FAQView.swift
//  FAQView
//
//  Created by Mukesh Thawani on 12/11/16.
//  Copyright © 2016 Mukesh Thawani. All rights reserved.
//
import Foundation

public class FAQView: UIView {
  
  // MARK: Public Properties
  
  public var items: [FAQItem]
  
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
  
  public var dataDetectorTypes: UIDataDetectorTypes? {
    get {
      return configuration.dataDetectorTypes
    }
    set(value) {
      configuration.dataDetectorTypes = value
    }
  }
  
  public var answerTintColor: UIColor! {
    get {
      return configuration.tintColor
    }
    set(value) {
      configuration.tintColor = value
    }
  }
  
  // MARK: Internal Properties
  
  var tableView: UITableView = {
    let tableview = UITableView()
    tableview.translatesAutoresizingMaskIntoConstraints = false
    tableview.backgroundColor = UIColor.clear
    tableview.allowsSelection = false
    tableview.separatorStyle = .none
    tableview.estimatedRowHeight = 50
    tableview.tableFooterView = UIView()
    return tableview
  }()
  
  var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()

  var expandedCells = [CellOperation]()
  var configuration = FAQConfiguration()
  var heightAtIndexPath = NSMutableDictionary()
  
  // MARK: Initialization
  
  public init(frame: CGRect,title: String = "Top Queries", items: [FAQItem]) {
    self.items = items
    super.init(frame: frame)
    expandedCells = Array(repeating: CellOperation.collapsed, count: items.count)
    setupTitleView(title: title)
    setupTableView()
    setupView()
    self.addSubview(tableView)
    self.addSubview(titleLabel)
    addConstraintsForTableViewAndTitleLabel()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Internal Methods
  
  func updateSection(_ section: Int) {
    if expandedCells[section] == .expanded {
      expandedCells[section] = .collapse
    } else {
      expandedCells[section] = .expand
    }
    tableView.reloadSections(IndexSet(integer: section), with: .fade)
    tableView.scrollToRow(at: IndexPath(row: 0, section: section), at: .top, animated: true)
  }
  
  func updateCellOperation(section: Int, cellOperation: CellOperation) {
    if cellOperation == .expand {
      expandedCells[section] = .expanded
    } else if cellOperation == .collapse {
      expandedCells[section] = .collapsed
    }
  }

  // MARK: Private Methods
  
  private func setupTitleView(title: String) {
    self.titleLabel.textColor = configuration.titleTextColor
    self.titleLabel.font = configuration.titleTextFont
    self.titleLabel.backgroundColor = configuration.titleLabelBackgroundColor
    self.titleLabel.text = title
  }
  
  private func setupTableView() {
    self.tableView.register(FAQViewCell.self, forCellReuseIdentifier: "cell")
    self.tableView.dataSource = self
    self.tableView.delegate = self
  }
  
  private func setupView() {
    self.backgroundColor = configuration.viewBackgroundColor
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
  
}

extension FAQView: UITableViewDelegate, UITableViewDataSource {
  
  public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    let height = self.heightAtIndexPath.object(forKey: indexPath)
    if ((height) != nil) {
      return CGFloat(height as! CGFloat)
    } else {
      return UITableViewAutomaticDimension
    }
  }
  
  public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let height = cell.frame.size.height
    self.heightAtIndexPath.setObject(height, forKey: indexPath as NSCopying)
  }
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    return items.count
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FAQViewCell
    cell.configuration = configuration
    let currentItem = items[indexPath.section]
    let cellOperation = expandedCells[indexPath.section]
    cell.configure(currentItem: currentItem, indexPath: indexPath, cellOperation: cellOperation)
    updateCellOperation(section: indexPath.section, cellOperation: cellOperation)
    cell.didSelectQuestion = { [weak self] cell in
      guard let faqView = self else {
        return
      }
      faqView.updateSection(indexPath.section)
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
  public let answer: String?
  public let attributedAnswer: NSAttributedString?
  
  public init(question: String, answer: String) {
    self.question = question
    self.answer = answer
    self.attributedAnswer = nil
  }
  
  public init(question: String, attributedAnswer: NSAttributedString) {
    self.question = question
    self.attributedAnswer = attributedAnswer
    self.answer = nil
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
  public var dataDetectorTypes: UIDataDetectorTypes?
  public var tintColor: UIColor?
  
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
    let colorValue: CGFloat = 210/255
    self.viewBackgroundColor = UIColor(red: colorValue, green: colorValue, blue: colorValue, alpha: 1)
    self.cellBackgroundColor = UIColor.white
    self.separatorColor = UIColor(red: colorValue, green: colorValue, blue: colorValue, alpha: 1)
  }
}


class FAQViewCell: UITableViewCell {
  
  // MARK: Internal Properties
  
  var questionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()
  
  var answerTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.backgroundColor = UIColor.clear
    textView.isScrollEnabled = false
    textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    textView.isEditable = false
    textView.dataDetectorTypes = []
    return textView
  }()
  
  var indicatorImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    let indicatorImage = UIImage(named: "DownArrow", in: Bundle(for: FAQView.self), compatibleWith: nil)
    imageView.image = indicatorImage
    return imageView
  }()
  
  var answerTextViewBottom = NSLayoutConstraint()
  
  var configuration: FAQConfiguration! {
    didSet {
      setup(with: configuration)
    }
  }
  
  var didSelectQuestion: ((_ cell: FAQViewCell) ->())?
  
  // MARK: Private Properties
  
  private let actionByQuestionTap = #selector(didTapQuestion)
  
  private var containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // MARK: Initialization
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionSetup()
    self.containerView.addSubview(indicatorImageView)
    contentView.addSubview(questionLabel)
    contentView.addSubview(answerTextView)
    contentView.addSubview(containerView)
    addLabelConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(currentItem: FAQItem, indexPath: IndexPath, cellOperation: CellOperation) {
    questionLabel.text = currentItem.question
    switch cellOperation {
    case .collapsed:
      collapse(animated: false)
    case .expand:
      if let answer = currentItem.answer {
        expand(withAnswer: answer, animated: true)
      } else if let attributedAnswer = currentItem.attributedAnswer {
        expand(withAttributedAnswer: attributedAnswer, animated: true)
      }
    case .collapse:
      collapse(animated: true)
    case .expanded:
      if let answer = currentItem.answer {
        expand(withAnswer: answer, animated: false)
      } else if let attributedAnswer = currentItem.attributedAnswer {
        expand(withAttributedAnswer: attributedAnswer, animated: false)
      }
    }
  }
  
  // MARK: Private Methods
  
  private func selectionSetup() {
    questionLabel.isUserInteractionEnabled = true
    indicatorImageView.isUserInteractionEnabled = true
    let questionLabelGestureRecognizer = UITapGestureRecognizer(target: self, action
      : actionByQuestionTap)
    questionLabel.addGestureRecognizer(questionLabelGestureRecognizer)
    let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: actionByQuestionTap)
    indicatorImageView.addGestureRecognizer(imageGestureRecognizer)
  }
  
  private func setup(with configuration: FAQConfiguration) {
    self.backgroundColor = configuration.cellBackgroundColor
    self.questionLabel.textColor = configuration.questionTextColor
    self.answerTextView.textColor = configuration.answerTextColor
    self.questionLabel.font = configuration.questionTextFont
    self.answerTextView.font = configuration.answerTextFont
    if let dataDetectorTypes = configuration.dataDetectorTypes {
      self.answerTextView.dataDetectorTypes = dataDetectorTypes
    }
    if let tintColor = configuration.tintColor {
      self.answerTextView.tintColor = tintColor
    }
  }
  
  private func addLabelConstraints() {
    let questionLabelTrailing = NSLayoutConstraint(item: questionLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1, constant: -30)
    let questionLabelLeading = NSLayoutConstraint(item: questionLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1, constant: 0)
    let questionLabelTop = NSLayoutConstraint(item: questionLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 10)
    
    let answerTextViewTrailing = NSLayoutConstraint(item: answerTextView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1, constant: -30)
    let answerTextViewLeading = NSLayoutConstraint(item: answerTextView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1, constant: -5)
    let answerTextViewTop = NSLayoutConstraint(item: answerTextView, attribute: .top, relatedBy: .equal, toItem: questionLabel, attribute: .bottom, multiplier: 1, constant: 10)
    answerTextViewBottom = NSLayoutConstraint(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: answerTextView, attribute: .bottom, multiplier: 1, constant: 0)
    
    let indicatorHorizontalCenter = NSLayoutConstraint(item: indicatorImageView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0)
    let indicatorVerticalCenter = NSLayoutConstraint(item: indicatorImageView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0)
    let indicatorWidth = NSLayoutConstraint(item: indicatorImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
    let indicatorHeight = NSLayoutConstraint(item: indicatorImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
    
    let containerTrailing = NSLayoutConstraint(item: containerView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1, constant: 5)
    let containerWidth = NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
    let containerTop = NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: contentView,attribute: .top, multiplier: 1, constant: 10)
    let containerHeight = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: questionLabel, attribute: .height, multiplier: 1, constant: 0)
    
    
    NSLayoutConstraint.activate([questionLabelTrailing, questionLabelLeading, questionLabelTop, answerTextViewLeading
      , answerTextViewTrailing, answerTextViewTop ,answerTextViewBottom, indicatorVerticalCenter, indicatorHorizontalCenter, indicatorWidth, indicatorHeight, containerTrailing, containerTop, containerWidth, containerHeight])
  }
  
  @objc private func didTapQuestion(_ recognizer: UIGestureRecognizer) {
    self.didSelectQuestion?(self)
  }
  
  private func expand(withAnswer answer: String, animated: Bool) {
    answerTextView.text = answer
    expand(animated: animated)
  }
  
  private func expand(withAttributedAnswer attributedAnswer: NSAttributedString, animated: Bool) {
    answerTextView.attributedText = attributedAnswer
    expand(animated: animated)
  }
  
  private func expand(animated: Bool) {
    answerTextView.isHidden = false
    if animated {
      answerTextView.alpha = 0
      UIView.animate(withDuration: 0.5, animations: {
        self.answerTextView.alpha = 1
      })
    }
    answerTextViewBottom.constant = 20
    update(arrow: .up, animated: animated)
  }
  
  private func collapse(animated: Bool) {
    answerTextView.text = ""
    answerTextView.isHidden = true
    answerTextViewBottom.constant = -20
    update(arrow: .down, animated: animated)
  }
  
  private func update(arrow: Arrow, animated: Bool) {
    switch arrow {
    case .up:
      if animated {
        // Change direction from down to up with animation
        self.indicatorImageView.rotate(withAngle: CGFloat(0), animated: false)
        self.indicatorImageView.rotate(withAngle: CGFloat(Double.pi), animated: true)
      } else {
        // Change direction from down to up without animation
        self.indicatorImageView.rotate(withAngle: CGFloat(Double.pi), animated: false)
      }
    case .down:
      if animated {
        // Change direction from up to down with animation
        self.indicatorImageView.rotate(withAngle: CGFloat(Double.pi), animated: false)
        self.indicatorImageView.rotate(withAngle: CGFloat(0), animated: true)
      } else {
        // Change direction from up to down without animation
        self.indicatorImageView.rotate(withAngle: CGFloat(0), animated: false)
      }
    }
  }
}

enum Arrow: String {
  case up
  case down
}

enum CellOperation {
  case collapsed
  case expand
  case expanded
  case collapse
}

extension UIImageView {
  func rotate(withAngle angle: CGFloat, animated: Bool) {
    UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
       self.transform = CGAffineTransform(rotationAngle: angle)
    })
  }
}
