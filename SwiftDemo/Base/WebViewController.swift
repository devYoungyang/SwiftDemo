//
//  BaseWebViewController.swift
//  ZeeRay_SWIFT
//
//  Created by Yang on 2021/5/21.
//
import WebKit
import UIKit

class WebViewController: UIViewController {

    var url: String?

    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView.init(progressViewStyle: .default)
        progressView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 0.5)
        progressView.tintColor = .red
        progressView.progress = 0.0
        return progressView
    }()
    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration.init()
        let webView = WKWebView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), configuration: config)
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(webView)
        view.addSubview(progressView)
        webView.rx.observeWeakly(Double.self, "estimatedProgress").subscribe(onNext: { (value) in
            self.progressView.alpha = 1.0
            self.progressView.setProgress(value!.float, animated: true)
            if value! >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: { () -> Void in
                    self.progressView.alpha = 0.0
                }, completion: { (_: Bool) -> Void in
                    self.progressView.progress = 0
                })
            }
        }).disposed(by: rx.disposeBag)
//        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)

        webView.load(URLRequest.init(url: URL.init(string: url!)!))

    }
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "estimatedProgress" {
//            YYLog(webView.estimatedProgress.float)
//            progressView.alpha = 1.0
//            progressView.setProgress(webView.estimatedProgress.float, animated: true)
//            if(self.webView.estimatedProgress >= 1.0) {
//                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: { () -> Void in
//                    self.progressView.alpha = 0.0
//                }, completion: { (finished:Bool) -> Void in
//                    self.progressView.progress = 0
//                })
//            }
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension WebViewController: WKUIDelegate {
//    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//
//    }
    /**   处理网页js中的文本输入  */
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {

    }
    /**   处理网页js中的确认框,若不使用该方法,则确认框无效  */
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {

    }
    /**   处理网页js中的提示框,若不使用该方法,则提示框无效  */
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {

    }

}
extension WebViewController: WKNavigationDelegate {
    /** 决定网页能否被允许跳转     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

    }
    /** 处理网页开始加载  */
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

    }
    /**   处理网页加载失败  */
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {

    }
    /**  处理网页内容开始返回   */
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {

    }
    /**  处理网页加载完成   */
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    }
    /**   处理网页返回内容时发生的失败  */
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {

    }
}
