//
//  pageCollectionViewCell.swift
//  AutoPageDemo
//
//  Created by admin on 16/11/7.
//  Copyright © 2016年 along. All rights reserved.
//

import UIKit

class pageCollectionViewCell: UICollectionViewCell {
    var itemImage:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        itemImage = UIImageView(frame: self.bounds)
        self.addSubview(itemImage!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadItemImage(name:String) {
        itemImage?.image = UIImage.init(named: name)
    }
}
