//
//  ViewController.swift
//  CoreTextCoreSwift
//
//  Created by Jz D on 2022/4/24.
//

import UIKit

class ViewController: UIViewController {

    lazy var displayView = CTDisplayView(frame: CGRect(x: 10, y: 100, width: 200, height: 200))
    
    let config = CTFrameParserConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayView.backgroundColor = UIColor.yellow
        view.addSubview(displayView)
        
        config.width = 300
        if let path = Bundle.main.path(forResource: "content", ofType: "json"){
            let data = CTFrameParser.parse(TemplateFile: path, with: config)
            displayView.data = data;
            displayView.frame = CGRect(x: 10, y: 100, width: 300, height: data.height)
        }
        
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let path = Bundle.main.path(forResource: "666", ofType: "json"){
            let data = CTFrameParser.parse(TemplateFile: path, with: config)
            displayView.data = data;
            displayView.frame = CGRect(x: 10, y: 100, width: 300, height: data.height)
        }
    }
}

