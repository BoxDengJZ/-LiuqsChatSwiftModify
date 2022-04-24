//
//  ViewController.swift
//  CoreTextCoreSwift
//
//  Created by Jz D on 2022/4/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let displayView = CTDisplayView(frame: CGRect(x: 10, y: 100, width: 200, height: 200))
        displayView.backgroundColor = UIColor.yellow
        view.addSubview(displayView)
        let config = CTFrameParserConfig()
        config.width = 300
        if let path = Bundle.main.path(forResource: "content", ofType: "json"){
            let data = CTFrameParser.parse(TemplateFile: path, with: config)
            displayView.data = data;
            displayView.frame = CGRect(x: 10, y: 100, width: 300, height: data.height)
        }
        
    }


}

