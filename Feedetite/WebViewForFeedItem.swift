//
//  WebViewForFeedItem.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 22/03/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import WebKit

class WebViewForFeedItem: UIViewController{
    
    @IBOutlet weak var webView: WKWebView!
    var feedLink = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        let feedContentsObjForWebView = FeedsContents()
//        print("linkToFeed has \(feedContentsObjForWebView.feedLink)")
//        var linkToFeed = feedContentsObjForWebView.feedLink
        let url:URL = URL(string: self.feedLink)!
        let urlRequest:URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    @IBAction func backPressedOnWebView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
