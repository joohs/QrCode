//
//  BDQRCode.h
//  pluto
//
//  Created by xiangxiong on 2017/7/20.
//  Copyright © 2017年 bertadata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BDQRCode : NSObject
+ (UIImage *)generateWithLogoQRCodeDataString:(NSString *)dataString logoImageName:(NSString *)logoImageName;
+ (UIImage *)generateWithLogoQRCodeDataString:(NSString *)dataString logoImageName:(NSString *)logoImageName logoScaleToSuperView:(CGFloat)logoScaleToSuperView;
@end
