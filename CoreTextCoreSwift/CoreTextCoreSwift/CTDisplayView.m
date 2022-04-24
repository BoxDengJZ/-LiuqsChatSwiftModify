//
//  CTDisplayView.m
//  CoreTextCore
//
//  Created by 韩志峰 on 2021/1/20.
//

#import "CTDisplayView.h"
#import <CoreText/CoreText.h>
#import "CoreTextData.h"
#import "CoreTextImageData.h"
#import "CoreUntil.h"
@implementation CTDisplayView



- (void)drawRect:(CGRect)rect {
   

    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    if (self.data) {
        CTFrameDraw(self.data.ctframe, context);
        for (CoreTextImageData * imageData in self.data.imageArray) {
            UIImage * image = [UIImage imageNamed: imageData.name];
            CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
        }
    }
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupEvents];
    }
    return  self;
}
- (void)setupEvents{
    UIGestureRecognizer *tapGrsture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTaped:)];
    [self addGestureRecognizer:tapGrsture];
    self.userInteractionEnabled = YES;
}
- (void)userTaped:(UITapGestureRecognizer *)gesture{
    CGPoint point = [gesture locationInView:self];
    for (CoreTextImageData *imageData in self.data.imageArray) {
        //coreImageData中的坐标系 跟UIKit坐标系翻转
        CGRect imageRect = imageData.imagePosition;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = self.bounds.size.height - imageRect.origin.y - imageRect.size.height;
        CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        if (CGRectContainsPoint(rect, point)) {
            NSLog(@"picture was clicked");
            break;
        }
        
    }
    CoreTextLinkData *linkData = [CoreUntil touchLinkInView:self atPoint:point data:self.data];
    if (linkData) {
        NSLog(@"%@",linkData.url);
    }
    
}


@end
