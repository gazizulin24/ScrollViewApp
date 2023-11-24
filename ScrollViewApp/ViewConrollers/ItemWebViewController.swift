//
//  ItemWebViewController.swift
//  ScrollViewApp
//
//  Created by Timur Gazizulin on 24.11.23.
//

import UIKit
import WebKit

class ItemWebViewController: UIViewController {
    
    var link = "https://apple.com"
    
    let webView = WKWebView()
    
    let toolBar = UIToolbar()
    
    let backButtonItem = UIBarButtonItem(systemItem: .rewind)
    let forwardButtonItem = UIBarButtonItem(systemItem: .fastForward)
    let spacer1 = UIBarButtonItem(systemItem: .flexibleSpace)
    let spacer2 = UIBarButtonItem(systemItem: .flexibleSpace)
    let refreshButtonItem = UIBarButtonItem(systemItem: .refresh)
    let shareButtonitem = UIBarButtonItem(systemItem: .action)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createWebView()
        createToolBar()
        loadRequest()
    }
    
    // MARK: - Create Toolbar
    func createToolBar(){
        self.view.addSubview(toolBar)
        
        backButtonItem.action = #selector(goBackAction)
        forwardButtonItem.action = #selector(goForwardAction)
        refreshButtonItem.action = #selector(refreshAction)
        shareButtonitem.action = #selector(shareAction)
        
        toolBar.items = [backButtonItem, forwardButtonItem, spacer1, refreshButtonItem,spacer2, shareButtonitem]
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            toolBar.topAnchor.constraint(equalTo: webView.bottomAnchor)
        ])
    }
    
    @objc func shareAction(){
        let ac = UIActivityViewController(activityItems: [link], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc func refreshAction(){
        webView.reload()
    }
    
    @objc func goBackAction(){
        if webView.canGoBack{
            webView.goBack()
        }
    }
    @objc func goForwardAction(){
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    // MARK: - Create WebView
    func createWebView(){
        self.view.addSubview(webView)
        
        webView.navigationDelegate = self
        
        // Layout
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
    }
    
    // MARK: - Load Request
    func loadRequest(){
        if let url = URL(string: link){
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}

extension ItemWebViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        backButtonItem.isEnabled = true
        forwardButtonItem.isEnabled = false
        refreshButtonItem.isEnabled = false
        shareButtonitem.isEnabled = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        refreshButtonItem.isEnabled = true
        shareButtonitem.isEnabled = true
        if webView.canGoBack{
            backButtonItem.isEnabled = true
        } else{
            backButtonItem.isEnabled = false
        }
        if webView.canGoForward{
            forwardButtonItem.isEnabled = true
        }
    }
}
