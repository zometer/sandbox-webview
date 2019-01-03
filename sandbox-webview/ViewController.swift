//
//  ViewController.swift
//  sandbox-webview
//
//  Created by Christopher Spears on 1/2/19.
//  Copyright © 2019 Christopher Spears. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var scannerView: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webViewTopConstraint: NSLayoutConstraint!
    
    var scannerPanelOpen = false;
    let scannerPanelHeight : CGFloat = 120 ;

    @IBAction func toggleScannerView(_ sender: UIButton) {
        let verb = scannerPanelOpen ? "Closing" : "Opening";
        print(verb + " scanner view");

        if (scannerPanelOpen) {
            scannerView.frame.size.height = CGFloat(0);
            webViewTopConstraint.constant = self.view.safeAreaInsets.top;
        } else {
            webViewTopConstraint.constant = scannerPanelHeight + self.view.safeAreaInsets.top;
        }

        scannerPanelOpen = !scannerPanelOpen;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let frame = scannerView.frame;
        print("scannerView.height: ", frame.height);
        
        let appUrl = URL(string: "https://google.com");
        let request = URLRequest(url: appUrl!);
        	webView.load(request);
        // webViewOutlet.uiDelegate = self ;
    }
}

