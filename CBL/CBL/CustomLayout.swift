//
//  CustomLayout.swift
//  CBL
//
//  Created by 钰龙徐 on 16/6/28.
//  Copyright © 2016年 Qingdao Jidan Information Technology Co. Ltd. All rights reserved.
//

import UIKit

@objc protocol CustomLayoutDelegate: NSObjectProtocol {
    
    func sectionInsetOfLayout(_ layout: CustomLayout) -> UIEdgeInsets;
    func marginOfItem(_ layout: CustomLayout) -> CGFloat;
    func columnOfLayout(_ layout: CustomLayout) -> Int;
    
    func maxCountOfPage(_ layout: CustomLayout) -> Int;
}

class CustomLayout: UICollectionViewLayout {
    
    weak var delegate: CustomLayoutDelegate?
    
    fileprivate var column: Int!
    fileprivate var row: Int!
    fileprivate var maxCountOfPage: Int!
    fileprivate var sectionInsets: UIEdgeInsets!
    fileprivate var margin: CGFloat!
    
    fileprivate var maxX: CGFloat = 0;
    fileprivate var page: Int = 0;
    
    fileprivate var collectionViewContentWidth: CGFloat!
    fileprivate var collectionViewContentHeight: CGFloat!
    
    fileprivate var attributesArray = [UICollectionViewLayoutAttributes]()
}

extension CustomLayout {
    override func prepare() {
        super.prepare();
        print("啦啦啦啦啦啦");
        if attributesArray.count > 0 {
            attributesArray.removeAll();
        }
        
        guard let itemCount = collectionView?.numberOfItems(inSection: 0),
            let col = delegate?.columnOfLayout(self),
            let margin = delegate?.marginOfItem(self),
            let sectionInset = delegate?.sectionInsetOfLayout(self),
            let maxCountOfPage = delegate?.maxCountOfPage(self) else {return};
        
        
        self.column = col;
        self.margin = margin;
        self.sectionInsets = sectionInset;
        self.maxCountOfPage = maxCountOfPage;
        self.row = maxCountOfPage / col;
        
        collectionViewContentWidth = (collectionView!.bounds.width - sectionInsets.left - sectionInsets.right);
        collectionViewContentHeight = (collectionView!.bounds.height - sectionInsets.top - sectionInsets.bottom);
        
        for i in 0..<itemCount {
            if let attributes = layoutAttributesForItem(at: IndexPath(item: i, section: 0)) {
                attributesArray.append(attributes);
            }
        }
    }
    
        override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath);
            

            let itemWidth = (collectionViewContentWidth - CGFloat(column-1) * margin) / CGFloat(column);
            let itemHeight = (collectionViewContentHeight - CGFloat(row-1) * margin) / CGFloat(row);
            
            page = (indexPath as NSIndexPath).item / maxCountOfPage + 1;

            let _col = ((indexPath as NSIndexPath).item - (page - 1) * maxCountOfPage) % column;
            let _row = ((indexPath as NSIndexPath).item - (page - 1) * maxCountOfPage) / column;
            
            
            let itemX = itemWidth * CGFloat(_col) + CGFloat(page-1) * collectionView!.bounds.width + CGFloat(_col) * margin + sectionInsets.left;
            let itemY = itemHeight * CGFloat(_row) + CGFloat(_row) * margin + sectionInsets.top;
            
            attributes.frame = CGRect(x: itemX, y: itemY, width: itemWidth, height: itemHeight);
            
            maxX = CGFloat(page) * collectionViewContentWidth;
            return attributes;
        }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return attributesArray;
    }
    
    override var collectionViewContentSize : CGSize {
        
        return CGSize(width: maxX + (sectionInsets.left + sectionInsets.right) * CGFloat(page), height: 0);
    }
}

extension CustomLayout {
//    private func setupInitial() {
//        
//    }
}
