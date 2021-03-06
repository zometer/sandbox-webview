//
//  ViewController.swift
//  sandbox-webview
//
//  Created by Christopher Spears on 1/2/19.
//  Copyright © 2019 Christopher Spears. All rights reserved.
//

import AVFoundation
import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var scannerView: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webViewTopConstraint: NSLayoutConstraint!
    
    let scannerPanelHeight : CGFloat = 120 ;
    var scannerPanelOpen = false;
    var captureSession: AVCaptureSession!;
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!;

    @IBAction func toggleScannerView(_ sender: UIButton) {
        let verb = scannerPanelOpen ? "Closing" : "Opening";
        print(verb + " scanner view");

        if (scannerPanelOpen) {
            scannerView.frame.size.height = CGFloat(0);
            webViewTopConstraint.constant = CGFloat(0);  // self.view.safeAreaInsets.top;
            destroyCameraScannerView(container: scannerView);
        } else {
            webViewTopConstraint.constant = scannerPanelHeight + self.view.safeAreaInsets.top;
            createCameraScannerView(container: scannerView);
        }

        scannerPanelOpen = !scannerPanelOpen;
    }

    func createCameraScannerView(container:UIView) {
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video);
        // TODO: Wrap in do / catch block.
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!);
            captureSession = AVCaptureSession();
            captureSession.addInput(input);

            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill;
            videoPreviewLayer.frame = view.layer.bounds;
            scannerView.layer.addSublayer(videoPreviewLayer);
            scannerView.frame.size.height = scannerPanelHeight;
            captureSession.startRunning();
        } catch {
            print(error);
        }
    }
    
    func destroyCameraScannerView(container:UIView) {
        videoPreviewLayer.removeFromSuperlayer();
        videoPreviewLayer = nil;
        captureSession?.stopRunning();
        captureSession = nil;

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

