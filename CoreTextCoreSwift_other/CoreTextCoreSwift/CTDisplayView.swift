//
//  CTDisplayView.swift
//  CoreTextCoreSwift
//
//  Created by Jz D on 2022/4/24.
//

import Foundation




class CTDisplayView: UIView{
    
    var data: CoreTextData?
    
    
    
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
        CTFrameDraw(d_d.ctframe, context);
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
