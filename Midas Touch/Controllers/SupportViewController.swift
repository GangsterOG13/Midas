import UIKit
import WebKit

class SupportViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
  
    private var progressKVOhandle: NSKeyValueObservation?
    let group = DispatchGroup()
    var url: URL!
    var backToGame: Bool!
    var request: URLRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("urlll123\(url.description)")
        
        
        self.request = URLRequest(url: url)
        self.webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        self.webView.load(request)
        self.webView.uiDelegate = self
        self.webView.allowsBackForwardNavigationGestures = true
        self.webView.navigationDelegate = self
        
        self.webView.scrollView.zoomScale = 1.0
        self.webView.scrollView.delegate = self
        
        progressKVOhandle = webView.observe(\.estimatedProgress) { [weak self] (object, _) in
                    self?.activityIndicator.setProgress(Float(object.estimatedProgress), animated: true)
                    self?.activityIndicator.isHidden = self?.webView.estimatedProgress == 1
                }
       
    }
    

    //MARK: - UIScrollViewDelegate
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
      scrollView.pinchGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        AppUtility.lockOrientation(.all)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppUtility.lockOrientation(.portrait)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
            //UIApplication.shared.open(navigationAction.request.url!, options: [:])
        }
        return nil
    }
    
    @IBAction func reloadWebView(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    
    @IBAction func goBackWebView(_ sender: UIBarButtonItem) {
        if backToGame == nil {
            backToGame = true
        }
        if (backToGame) {
            AppUtility.lockOrientation(.landscape)
            self.dismiss(animated: true)
        }else {
            webView.goBack()
        }
    }
    //    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//       //load cookie of current domain
//        webView.loadDiskCookies(for: url.host!){
//            decisionHandler(.allow)
//        }
//    }
//
//    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//       //write cookie for current domain
//        webView.writeDiskCookies(for: url.host!){
//            decisionHandler(.allow)
//        }
//    }
   
        
}
