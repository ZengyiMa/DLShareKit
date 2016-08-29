//
//  UIImage+DLShareKit.m
//  Niupu_SNS
//
//  Created by famulei on 8/29/16.
//  Copyright © 2016 WE. All rights reserved.
//

#import "UIImage+DLShareKit.h"

@implementation UIImage (DLShareKit)


- (UIImage *)dl_imageByResizeToSize:(CGSize)size {
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
