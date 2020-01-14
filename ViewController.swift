//
//  ViewController.swift
//  WebView
//
//  Created by Angelina Tsuboi on 1/12/20.
//  Copyright © 2020 Angelina Tsuboi. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    var websites = [String?]()
    var initialIndex: Int!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self //telling webView that we want to be informed as soon as something intersting happens and set the site we navigated to the current view controller
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: "https://www." + websites[initialIndex]!)!
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //adds spacing
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload)) //refreshes webview
        
        let backButton = UIBarButtonItem(barButtonSystemItem: .undo, target: webView, action: #selector(webView.goBack)) //back button
        
        let forwardButton = UIBarButtonItem(barButtonSystemItem: .redo, target: webView, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [backButton, forwardButton, progressButton, spacer, refreshButton] //adds these items to toolbar
        navigationController?.isToolbarHidden = false //enables toolbar to be seen
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) //observing the progress value (looking at how much the webview is done loading)
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true; //swiping features
        
    
    }
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        for website in websites{
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
   
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        present(ac, animated:true)
    }
    
    func openPage(action: UIAlertAction){
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
}

