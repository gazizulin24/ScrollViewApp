//
//  ItemWebViewController.swift
//  ScrollViewApp
//
//  Created by Timur Gazizulin on 24.11.23.
//

import UIKit
import WebKit

final class ItemWebViewController: UIViewController {
    
    var link = "https://apple.com"
    
    private let webView = WKWebView()
    
    private let toolBar = UIToolbar()
    
    // Toolbar Items
    private let backButtonItem = UIBarButtonItem(systemItem: .rewind)
    private let forwardButtonItem = UIBarButtonItem(systemItem: .fastForward)
    private let spacer1 = UIBarButtonItem(systemItem: .flexibleSpace)
    private let spacer2 = UIBarButtonItem(systemItem: .flexibleSpace)
    private let refreshButtonItem = UIBarButtonItem(systemItem: .refresh)
    private let shareButtonitem = UIBarButtonItem(systemItem: .action)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createWebView()
        createToolBar()
        loadRequest()
        
    }
    
    // MARK: - Create Toolbar
    private func createToolBar(){
        self.view.addSubview(toolBar)
        
        // Toolbar Items Actions
        backButtonItem.action = #selector(goBackAction)
        forwardButtonItem.action = #selector(goForwardAction)
        refreshButtonItem.action = #selector(refreshAction)
        shareButtonitem.action = #selector(shareAction)
        
        // Toolbar Items
        toolBar.items = [backButtonItem, forwardButtonItem, spacer1, refreshButtonItem,spacer2, shareButtonitem]
        
        // Toolbar Layout
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
    private func createWebView(){
        self.view.addSubview(webView)
        
        // Set delegate
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
    private func loadRequest(){
        if let url = URL(string: link){
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}

// MARK: - WebView Delegate
extension ItemWebViewController:WKNavigationDelegate{
    
    // MARK: - Did Start Loading Page
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        backButtonItem.isEnabled = false
        forwardButtonItem.isEnabled = false
        refreshButtonItem.isEnabled = false
        shareButtonitem.isEnabled = false
        
    }
    
    // MARK: - Did finish Loading Page
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        refreshButtonItem.isEnabled = true
        shareButtonitem.isEnabled = true
        
        if webView.canGoBack{
            backButtonItem.isEnabled = true
        }
        
        if webView.canGoForward{
            forwardButtonItem.isEnabled = true
        }
        
    }
    
}
