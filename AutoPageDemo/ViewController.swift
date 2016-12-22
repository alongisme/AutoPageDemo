//
//  ViewController.swift
//  AutoPageDemo
//
//  Created by admin on 16/11/4.
//  Copyright © 2016年 along. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var autoPageView:AutoPageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        autoPageView = AutoPageView(frame:CGRect.init(x: 20, y: 50, width: self.view.bounds.width - 40, height: 200))
        autoPageView?.loadImage(["test1","test2","test3","test4"])
        self.view.addSubview(autoPageView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

