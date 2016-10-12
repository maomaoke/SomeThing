//
//  OneViewController.swift
//  刷新
//
//  Created by 钰龙徐 on 16/5/20.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

import UIKit

protocol OneViewControllerDelegate: class {
    func scrollTransform(offsetY: CGFloat);
    
    func scrollEndDragging();
}

class OneViewController: UIViewController {
    
    weak var delegate: OneViewControllerDelegate?;
    @IBOutlet weak var scrollConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        scrollConstraint.constant = view.bounds.height+200;
    }
}

extension OneViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offsetY = (scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.bounds.height));
        
        if offsetY > 0 && scrollView.contentSize.height > 0 {
            print(offsetY);
            delegate?.scrollTransform(offsetY);
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = (scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.bounds.height));
        
        if offsetY > 30 {
            delegate?.scrollEndDragging();
        }
    }
}