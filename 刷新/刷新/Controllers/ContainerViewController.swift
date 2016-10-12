//
//  ContainerViewController.swift
//  刷新
//
//  Created by 钰龙徐 on 16/5/20.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

import UIKit


class ContainerViewController: UIViewController {
    
    @IBOutlet weak var scrollConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    private var oneView: UIView? = nil;
    private var twoView: UIView? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setupChildViewController();
        
        setupConstraint();
    }
    private func setupChildViewController() {
        let oneVC = OneViewController();
        addChildViewController(oneVC);
        oneVC.delegate = self;
        let twoVC = TwoViewController();
        addChildViewController(twoVC);
        twoVC.delegate = self;
        
        view.addSubview(oneVC.view);
        view.addSubview(twoVC.view);
        
        oneView = oneVC.view;
        twoView = twoVC.view;
    }

    private func setupConstraint() {
        oneView?.snp_makeConstraints(closure: { (make) in
            make.top.left.bottom.right.equalTo(view);
        })
        twoView?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(view!.snp_bottom);
            make.left.right.equalTo(view);
            make.height.equalTo(view.snp_height).offset(-64);
        })
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
    }
}

extension ContainerViewController: OneViewControllerDelegate {
    func scrollTransform(offsetY: CGFloat) {
        print(offsetY);
        twoView?.transform = CGAffineTransformMakeTranslation(0, -offsetY);
    }
    
    func scrollEndDragging() {
        twoView?.transform = CGAffineTransformIdentity;
        self.twoView?.snp_updateConstraints(closure: { (make) in
            make.top.equalTo(self.view).offset(64);
        }) 
        UIView.animateWithDuration(0.15, animations: {
            self.oneView?.transform = CGAffineTransformMakeTranslation(0, -self.view.bounds.height+64);
            self.twoView?.layoutIfNeeded()
            }) { (finished) in

        };
    }
}

extension ContainerViewController: TwoViewControllerDelegate {
    func upScrollEndDragging() {
        
        twoView?.snp_updateConstraints(closure: { (make) in
            make.top.equalTo(self.view).offset(self.view.bounds.height);
        })
        UIView.animateWithDuration(0.15, animations: {
            self.oneView?.transform = CGAffineTransformMakeTranslation(0, 0);
            self.twoView?.layoutIfNeeded();
        }) { (finished) in
            
        };
    }
}
