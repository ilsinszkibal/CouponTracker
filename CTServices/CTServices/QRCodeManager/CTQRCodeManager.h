//
//  CTQRCodeManager.h
//  Coupon
//
//  Created by Teveli László on 17/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CTBaseManager.h"
#import <UIKit/UIKit.h>

@protocol CTCodeReaderDelegate <NSObject>

- (void)codeDidRead:(NSString*)code ofType:(NSString*)type;

@optional

- (void)readingDidStart;
- (void)readingDidStop;

@end

@interface CTQRCodeManager : CTBaseManager

@property (nonatomic, readonly, getter = isReading) BOOL reading;
@property (nonatomic, assign) BOOL stopsReadingWhenCodeIsFound;
@property (nonatomic, assign) BOOL beepsWhenCodeIsFound;

@property (nonatomic, strong) NSString* lastReadCode;
@property (nonatomic, strong) UIImage* lastReadImage;

@property (nonatomic, weak) UIView* previewView;//NOTE: have to use a view here...

@property (nonatomic, weak) id<CTCodeReaderDelegate> delegate;

- (BOOL)prepareForReading;
- (BOOL)startReading;
- (BOOL)stopReading;

- (UIImage*)generateQRCodeFromString:(NSString*)string size:(CGFloat)size;

@end
