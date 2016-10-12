//
//  TwoViewController.swift
//  刷新
//
//  Created by 钰龙徐 on 16/5/20.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

import UIKit

protocol TwoViewControllerDelegate: class {
    func upScrollEndDragging();
}

class TwoViewController: UIViewController {

    weak var delegate: TwoViewControllerDelegate?
    @IBOutlet weak var scrollConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollConstraint.constant = view.bounds.height+1;
    }
}

extension TwoViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if scrollView.contentOffset.y < -50 {
            delegate?.upScrollEndDragging();
        }
    }
}
