# FAQView

# An easy to use FAQ view for iOS written in Swift.

* This view is a subclass of UIView.

<br>
<br>

<img
src='https://raw.githubusercontent.com/mukeshthawani/FAQView/master/Demo/graphics/screenshot_1.png' width='600' alt='FAQView'>
<img
src='https://raw.githubusercontent.com/mukeshthawani/FAQView/master/Demo/graphics/screenshot_2.png' width='600' alt='FAQView'>

## Setup with CocoaPods

If you are using CocoaPods add this text to your Podfile
and run `pod install`.

    use_frameworks!
    target 'Your target name'
    pod 'FAQView', '~> 0.5.0'

## Or Add source

Simply add
[FAQView.swift](https://github.com/mukeshthawani/FAQView/blob/master/Source/FAQView.swift) file to you project.

## Usage

### Creating a view from the code

```Swift
let items = [FAQItem(question: "What is reddit?", answer: "reddit is a source for what's new and popular on the web."),
            FAQItem(question: "How is a submission's score determined?", answer: "A submission's score is simply the number of upvotes minus the number of downvotes.")]

let faqView = FAQView(frame: view.frame, items: items)
view.addSubview(faqView)
```
#### Attributed text answers

You may use attributed text instead of plain text. Set the ```attributedAnswer``` property of items to an NSAttributedString. 



#### Customization
```Swift
// Change title
faqView.titleLabelText = "Top Queries"

// Question text color  
faqView.questionTextColor = UIColor.blue

// Answer text color
faqView.answerTextColor = UIColor.blue

// Question text font
faqView.questionTextFont = UIFont(name: "HelveticaNeue-Light", size: 15)

// View background color
faqView.viewBackgroundColor = UIColor.white

// Set up data detectors for automatic detection of links, phone numbers, etc., contained within the answer text.
faqView.dataDetectorTypes = [.phoneNumber, .calendarEvent, .link]

// Set color for links and detected data
faqView.tintColor = UIColor.red

```

## Requirements

- Swift 4.0
- Xcode 9.0+
- FAQView 0.4.x is compatible with Swift 3
- iOS 9.0+

## Author

[Mukesh Thawani](http://twitter.com/MukeshThawani)

## Contributing

Feature requests, bug reports, and pull requests are all welcome.

## License

Copyright (c) 2016-present Mukesh Thawani. Release under the [MIT License](License).
