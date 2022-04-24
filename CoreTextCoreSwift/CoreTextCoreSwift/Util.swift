//
//  Util.swift
//  CoreTextCoreSwift
//
//  Created by Jz D on 2022/4/24.
//

import Foundation


extension CTFrameParser{
    
    
    static func parse(TemplateFile path: String, with config: CTFrameParserConfig) -> CoreTextData{
        let info = load(templateFile: path, with: config)
        let data = parseAttributeContent(info.2, config: config)
        data.imageArray = info.0
        data.linkArray = info.1
        return data
    }
    
    
    static func load(templateFile path: String, with config: CTFrameParserConfig) -> ([CoreTextImageData], [CoreTextLinkData], NSAttributedString){
        var result = ([CoreTextImageData](), [CoreTextLinkData](), NSAttributedString())
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let array = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard let arr = array as? [Any]
            else { return result }
            let resultStr = NSMutableAttributedString()
            for dict in arr{
                if let pairs = dict as? [String: String], let type = pairs["type"]{
                    switch type{
                    case "txt":
                        let temp = parseAttributedContent(fromDictonry: pairs, config: config)
                        resultStr.append(temp)
                    case "img":
                        let imageData = CoreTextImageData()
                        if let name = pairs["name"]{
                            imageData.name = name
                        }
                        imageData.position = Int32(resultStr.length)
                        result.0.append(imageData)
                        //创建占位符
                        let holder = parseImageData(from: pairs, config: config)
                        resultStr.append(holder)
                    case "link":
                        let startPos = resultStr.length
                        let holder = parseAttributedContent(fromDictonry: pairs, config: config)
                        resultStr.append(holder)
                        let length = resultStr.length - startPos;
                        let linkRange = NSMakeRange(startPos, length);
                        let linkData = CoreTextLinkData()
                        if let name = pairs["content"], let url = pairs["url"]{
                            linkData.title = name
                            linkData.url = url
                        }
                        linkData.range = linkRange
                        result.1.append(linkData)
                    default:()
                    }
                }
                
            }
            result.2 = resultStr
            return result
        } catch{
            print(error)
        }
        return result
        
    }
}
