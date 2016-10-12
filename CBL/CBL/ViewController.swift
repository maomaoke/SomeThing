//
//  ViewController.swift
//  CBL
//
//  Created by 钰龙徐 on 16/6/28.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

import UIKit

private let reuseID = "123"

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: CustomLayout!
    
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.delegate = self;
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseID);
        
        collectionView.isPagingEnabled = true;
    }
}

extension ViewController: CustomLayoutDelegate {
    func marginOfItem(_ layout: CustomLayout) -> CGFloat {
        return 5;
    }
    
    func sectionInsetOfLayout(_ layout: CustomLayout) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5);
    }
    
    func columnOfLayout(_ layout: CustomLayout) -> Int {
        return 3;
    }
    
    func maxCountOfPage(_ layout: CustomLayout) -> Int {
        return 6;
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath);
        cell.backgroundColor = UIColor.red;
        return cell;
    }
}

