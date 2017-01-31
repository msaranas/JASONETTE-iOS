//
//  UIView+Extension.m
//  Jasonette
//
//  Copyright © 2016 gliechtenstein. All rights reserved.
//
#import "UIView+JasonComponentPayload.h"

@implementation UIView (JasonComponentPayload)
static NSString *kStringTagKey = @"StringTagKey";
-(void)setPayload:(id)payload
{
    objc_setAssociatedObject( self, "_payload", payload, OBJC_ASSOCIATION_RETAIN_NONATOMIC ) ;
}

-(id)payload
{
    return objc_getAssociatedObject( self, "_payload" ) ;
}
- (NSString *)stringTag
{
    return objc_getAssociatedObject(self, CFBridgingRetain(kStringTagKey));
}
- (void)setStringTag:(NSString *)stringTag
{
    objc_setAssociatedObject(self, CFBridgingRetain(kStringTagKey), stringTag, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
