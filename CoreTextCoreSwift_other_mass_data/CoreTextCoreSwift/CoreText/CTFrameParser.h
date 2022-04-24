//
//  CTFrameParser.h
//  CoreTextCore
//
//  Created by 韩志峰 on 2021/1/20.
//

#import <Foundation/Foundation.h>
#import "CoreTextData.h"
#import "CTFrameParserConfig.h"

NS_ASSUME_NONNULL_BEGIN
/*
 模型类，通过CTFrameParaserConfig生成CoreTextData实例
 */
@interface CTFrameParser : NSObject
+ (NSDictionary *)attributeWithConfig:(CTFrameParserConfig *)config;
+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config;
+ (CoreTextData *)parseAttributeContent:(NSAttributedString *)content config:(CTFrameParserConfig *)config;

+ (NSAttributedString *)load:(NSData *) data config:(CTFrameParserConfig *)config imageArray:(NSMutableArray *)imageArray linkArray:(NSMutableArray *)linkArray;
@end

NS_ASSUME_NONNULL_END
