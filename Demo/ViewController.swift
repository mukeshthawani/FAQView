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

  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = "FAQs"
    let rightBarButton = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
    navigationItem.leftBarButtonItem = rightBarButton
    self.automaticallyAdjustsScrollViewInsets = false

    let faqViewFrame = CGRect(x: view.frame.origin.x, y: 50, width: view.frame.width, height: view.frame.height - 50)
    let items = [FAQItem(question: "What is reddit?", answer: "reddit is a source for what's new and popular on the web. Users like you provide all of the content and decide, through voting, what's good and what's junk. Links that receive community approval bubble up towards #1, so the front page is constantly in motion and (hopefully) filled with fresh, interesting links."), FAQItem(question: "What does the name \"reddit\" mean?", answer: "It's (sort of) a play on words -- i.e., \"I read it on reddit.\" Also, there are some unintentional but interesting Latin meanings to the word \"reddit\"."), FAQItem(question: "How is a submission's score determined?", answer: "A submission's score is simply the number of upvotes minus the number of downvotes. If five users like the submission and three users don't it will have a score of 2. Please note that the vote numbers are not \"real\" numbers, they have been \"fuzzed\" to prevent spam bots etc. So taking the above example, if five users upvoted the submission, and three users downvote it, the upvote/downvote numbers may say 23 upvotes and 21 downvotes, or 12 upvotes, and 10 downvotes. The points score is correct, but the vote totals are \"fuzzed\"."), FAQItem(question: "Why does a dot sometimes show up where the score should be?", answer: "For the first few hours after a submission is created, the score is not displayed. This is intended to mitigate the bandwagon effect."), FAQItem(question: "I made a mistake in my submission title, how can I edit it?", answer: "Submission titles cannot be edited. However, you can simply delete it and resubmit it. The sooner you do this, the less likely you will lose any votes or comments."), FAQItem(question: "What is that number next to usernames? And what is karma?", answer: "The number next to a username is called that user's \"karma.\" It reflects how much good the user has done for the reddit community. The best way to gain karma is to submit links that other people like and vote for."), FAQItem(question: "Why should I try to accumulate karma?", answer: "Why should you try to score points in a video game? Why should your favorite sports team try to win the championship?Or, to look at things from a less competitive and more altruistic perspective, read what philosophers have said about the matter -- namely, don't set out to accumulate karma; just set out to be a good person, and let your karma simply be a reminder of your legacy. Note: reddit makes no guarantees about attaining Nirvana. Update: A redditor named jumpercable tried to redeem his karma. See how it went (your mileage may vary)."), FAQItem(question: "What can I do to get my submissions noticed?", answer: "Remember that adage about not judging a book by its cover? No one actually follows it. So choose your title carefully — make it useful, provide context, and be descriptive. Be careful though, if you're too aggressive it could backfire. Phrases like, \"Vote this up to spread the word!\" or \"AMAZING!\" tend to annoy most redditors, who will make sure your post doesn't see the light of day."), FAQItem(question: "Is reddit available in languages other than English?", answer: "Yes! In the upper-right corner of the page, there should be a link that says, \"English\". Click it and you'll get a popup where you can change to another language.")]
    let faqView = FAQView(frame: faqViewFrame, items: items)
    view.addSubview(faqView)
  }

}
