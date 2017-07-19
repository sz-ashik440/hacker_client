//
//  UrlStoryViewController.swift
//  Hacker Client
//
//  Created by Admin on 7/17/17.
//  Copyright © 2017 binarian. All rights reserved.
//

import UIKit

class UrlStoryViewController: UIViewController {
    
    var storyURL: String?
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let recivedUrl = storyURL else {
            print("URL isnot found")
            return
        }
        
        let url = URL(string: recivedUrl)!
        let requestObj = URLRequest(url: url)
        webView.loadRequest(requestObj)
    }
}
