//
//  UrlStoryViewController.swift
//  Hacker Client
//
//  Created by Admin on 7/17/17.
//  Copyright © 2017 binarian. All rights reserved.
//

import UIKit

class UrlStoryViewController: UIViewController{
    
    var storyURL: String?
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        progressIndicator.startAnimating()
        
        guard let recivedUrl = storyURL else {
            print("URL isnot found")
            return
        }
        
        let url = URL(string: recivedUrl)!
        let requestObj = URLRequest(url: url)
        webView.loadRequest(requestObj)
    }
}

extension UrlStoryViewController: UIWebViewDelegate{
//    func webViewDidStartLoad(_ webView: UIWebView) {
//        progressIndicator.startAnimating()
//    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        progressIndicator.stopAnimating()
    }
}
