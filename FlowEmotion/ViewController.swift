//
//  ViewController.swift
//  FlowEmotion
//
//  Created by 乔文德 on 2016/12/9.
//  Copyright © 2016年 wind. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加掉落表情
        FlowUtils.sharedInstance.addFlowEmotion(view: view, imageName: "haha");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

