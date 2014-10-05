//
//  CouponDrawingTextLayer.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CouponDrawingBaseLayer.h"

@interface CouponDrawingTextLayer : CouponDrawingBaseLayer

@property (nonatomic, readonly) NSString* text;
@property (nonatomic, readonly) NSUInteger fontColorIntex;
@property (nonatomic, readonly) NSUInteger fontSizeIndex;

@property (nonatomic, readonly) CGPoint position;

- (id) initWithText:(NSString*) text textColorIndex:(NSUInteger) textColorIndex fontSizeIndex:(NSUInteger) fontSizeIndex withMaxLayerPositions:(CGSize) maxLayerPositions;

+ (NSInteger) maxNumberOfColorIndex;
+ (UIColor*) colorForRectIndex:(NSUInteger) rectIndex;

+ (NSInteger) maxNumberOfFontIndex;
+ (NSInteger) fontSizeForIndex:(NSUInteger) fontIndex;

- (void) setText:(NSString*) text;

- (void) setFontSizeIndex:(NSUInteger)fontSizeIndex;
- (CGFloat) fontSize;
- (void) setFontColorIntex:(NSUInteger)fontColorIntex;
- (UIColor*) fontColor;

- (NSDictionary*) attributedDictionary;

- (void) changePosition:(CGPoint) position;
- (CGRect) positionFrame;


@end
