//
//  Util.swift
//  CoreTextCoreSwift
//
//  Created by Jz D on 2022/4/24.
//

import Foundation


extension CTFrameParser{
    
    
    static func parse(TemplateFile path: String, with config: CTFrameParserConfig) -> CoreTextData{
        let imageArray = NSMutableArray()
        let linkArray = NSMutableArray()
        let attrStr = loadTemplateFile(path, config: config, imageArray: imageArray, linkArray: linkArray)
        let data = parseAttributeContent(attrStr, config: config)
        data.imageArray = imageArray as! [CoreTextImageData]
        data.linkArray = linkArray as! [CoreTextLinkData]
        return data
    }
    
    
}
