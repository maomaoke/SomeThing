//
//  ViewController.swift
//  刷新
//
//  Created by 钰龙徐 on 16/5/20.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let containerVC = ContainerViewController();
        navigationController?.pushViewController(containerVC, animated: true);
    }
}

