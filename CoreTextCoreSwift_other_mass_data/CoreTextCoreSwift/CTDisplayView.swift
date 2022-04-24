//
//  CTDisplayView.swift
//  CoreTextCoreSwift
//
//  Created by Jz D on 2022/4/24.
//

import Foundation




class CTDisplayView: UIView{
    
    var data: CoreTextData?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGrsture = UITapGestureRecognizer(target: self, action: #selector(userTaped))
        addGestureRecognizer(tapGrsture)
        isUserInteractionEnabled = true
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() , let d_d = data else { return }
        context.textMatrix = .identity
        
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        guard let lines = CTFrameGetLines(d_d.ctframe) as? [CTLine] else{
            return
        }
        let lineCount = lines.count
        guard lineCount > 0 else {
            return
        }
        d_d.imageArray.forEach { data in
            print(data.imagePosition.origin.y)
        }
        
        var originsArray = [CGPoint](repeating: CGPoint.zero, count: lineCount)
        //用于存储每一行的坐标
        CTFrameGetLineOrigins(d_d.ctframe, CFRangeMake(0, 0), &originsArray)
        for (i,line) in lines.enumerated(){
                var lineAscent:CGFloat      = 0
                var lineDescent:CGFloat     = 0
                var lineLeading:CGFloat     = 0
                _ = CTLineGetTypographicBounds(line , &lineAscent, &lineDescent, &lineLeading)
                let lineOrigin = originsArray[i]
                context.textPosition = lineOrigin
            print(lineOrigin.y )
            if let first = d_d.imageArray.first(where: { val in
                let frame = val.imagePosition
                return (lineOrigin.y == frame.origin.y)
            }){
                let font = UIFont.systemFont(ofSize: 16)
                context.textPosition.y = lineOrigin.y + (first.imagePosition.size.height - font.lineHeight - font.descender) / 2
            }
            CTLineDraw(line, context)
        }
        
        
        for imageData in d_d.imageArray{
            if let image = UIImage(named: imageData.name), let cg = image.cgImage{
                context.draw(cg, in: imageData.imagePosition)
            }
        }
        
        
    }
    
    
    @objc func userTaped(_ gesture: UITapGestureRecognizer){
        let point = gesture.location(in: self)
        guard let d = data else { return }
        for imageData in d.imageArray{
            //coreImageData中的坐标系 跟UIKit坐标系翻转
            let imageRect = imageData.imagePosition
            var imagePosition = imageRect.origin
            imagePosition.y = bounds.size.height - imageRect.origin.y - imageRect.size.height;
            let rect = CGRect(x: imagePosition.x, y: imagePosition.y, width: imageRect.size.width, height: imageRect.size.height)
            if rect.contains(point){
                print("picture was clicked")
                break
            }
            
        }
        let linkData = CoreUntil.touchLink(in: self, at: point, data: d)
        print(linkData.url)
        
        
    }
}
