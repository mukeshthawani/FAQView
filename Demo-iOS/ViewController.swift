//
//  ViewController.swift
//  Demo-iOS
//
//  Created by Mukesh Thawani on 13/11/16.
//  Copyright © 2016 Mukesh Thawani. All rights reserved.
//

import UIKit
import FAQView

class ViewController: UIViewController {

  override func viewDidAppear(_ animated: Bool) {
    
      }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "FAQs"
    let rightBarButton = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
    navigationItem.leftBarButtonItem = rightBarButton
    self.automaticallyAdjustsScrollViewInsets = false
    
    let faqViewFrame = CGRect(x: view.frame.origin.x, y: 50, width: view.frame.width, height: view.frame.height - 50)
    let items = [FAQItem(question: "What is reddit?", answer: "reddit is a source for what's new and popular on the web. Users like you provide all of the content and decide, through voting, what's good and what's junk. Links that receive community approval bubble up towards #1, so the front page is constantly in motion and (hopefully) filled with fresh, interesting links."), FAQItem(question: "What does the name \"reddit\" mean?", answer: "It's (sort of) a play on words -- i.e., \"I read it on reddit.\" Also, there are some unintentional but interesting Latin meanings to the word \"reddit\"."), FAQItem(question: "How is a submission's score determined?", answer: "A submission's score is simply the number of upvotes minus the number of downvotes. If five users like the submission and three users don't it will have a score of 2. Please note that the vote numbers are not \"real\" numbers, they have been \"fuzzed\" to prevent spam bots etc. So taking the above example, if five users upvoted the submission, and three users downvote it, the upvote/downvote numbers may say 23 upvotes and 21 downvotes, or 12 upvotes, and 10 downvotes. The points score is correct, but the vote totals are \"fuzzed\"."), FAQItem(question: "Why does a dot sometimes show up where the score should be?", answer: "For the first few hours after a submission is created, the score is not displayed. This is intended to mitigate the bandwagon effect."), FAQItem(question: "I made a mistake in my submission title, how can I edit it?", answer: "Submission titles cannot be edited. However, you can simply delete it and resubmit it. The sooner you do this, the less likely you will lose any votes or comments.")]
    let faqView = FAQView(frame: faqViewFrame, items: items)
    view.addSubview(faqView)

    
    // Write this in readme that if you have nav bar and view is not coming properly then add this above line and initialize with proper frame value
    
  }

}

