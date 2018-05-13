//
//  WebViewForItem.swift
//  Feedetite
//
//  Created by Vigneshwar Devendran on 05/04/18.
//  Copyright © 2018 Vigneshwar Devendran. All rights reserved.
//

import UIKit
import WebKit


class WebViewForItem: UIViewController{
    var itemUrl = ""
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        let url = URL(string: itemUrl)
        let req = URLRequest(url: url!)
        webView.load(req)
        
    }
}
