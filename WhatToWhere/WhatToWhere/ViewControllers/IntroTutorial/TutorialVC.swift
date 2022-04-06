//
//  TutorialVC.swift
//  WhatToWhere
//
//  Created by Nimisha Makwana on 05/03/22.
//

import Foundation
import UIKit

class TutorialVC: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnSkip: UIButton!
    var timer: Timer?

    var introPageViewController: IntroPageVC? {
        didSet {
            introPageViewController?.tutorialDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.addTarget(self, action: #selector(self.didChangePageControlValue), for: .valueChanged)
        self.btnSkip.setTitle(NSLocalizedString("skip", comment: ""), for: .normal)
//        self.startTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
//    func startTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(scrollAutomatically), userInfo: nil, repeats: true)
//    }
//
//    @objc func scrollAutomatically(_ timer1: Timer) {
//
//        if pageControl.currentPage >= 3 {
//            introPageViewController?.scrollToViewController(index: 0)
//        } else {
//            introPageViewController?.scrollToViewController(index: pageControl.currentPage+1)
//        }
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let introPageViewController = segue.destination as? IntroPageVC {
            self.introPageViewController = introPageViewController
        }
    }

    @IBAction func btnSkipClicked(_ sender: Any) {
        NSUtils.sharedInstance.saveValuetoUserDefault(keyParameter: Key.KEYInitialView, valueParameter: 1)
        let controller = PushAuthenticationControllerView.sharedInstance.OverViewVC()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    @objc func didChangePageControlValue() {
        introPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension TutorialVC: IntroPageViewControllerDelegate {
    
    func tutorialPageViewController(tutorialPageViewController: IntroPageVC,
        didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(tutorialPageViewController: IntroPageVC,
        didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
