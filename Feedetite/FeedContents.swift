//
//  FeedContents.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 21/03/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import FeedKit
class FeedsContents {
    var feedImage = ""
    var feedTitle = ""
    var feedLink = ""
    
    let feedURL = URL(string: "https://www.popsci.com/rss-science.xml?loc=contentwell&lnk=science&dom=section-1")
    
    
    func parse(){
        let parser = FeedParser(URL: feedURL!)
        parser?.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
    // Do your thing, then back to the Main thread
    DispatchQueue.main.async {
    // ..and update the UI
        print(result.isSuccess)
        let feeds = result.rssFeed
        self.feedTitle = (feeds?.items?.first?.title)!
        self.feedLink = (feeds?.items?.first?.link)!
        
            }
        }
    }
}
