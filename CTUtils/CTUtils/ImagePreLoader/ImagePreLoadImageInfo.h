//
//  ImagePreLoadImageInfo.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ImageInfoStateUnkown = 0,
    ImageInfoStateMeasured,
    ImageInfoStateDownloadFail,
    ImageInfoStateNoURL
} ImageInfoState;

@interface ImagePreLoadImageInfo : NSObject

@property (nonatomic, readonly) NSURL* url;
@property (nonatomic, readonly) CGSize imageSize;
@property (nonatomic, readonly) ImageInfoState imageInfoState;

+ (instancetype) createImageInfo:(NSURL*) url withImage:(UIImage*) image;
+ (instancetype) createFailedImageInfo:(ImageInfoState) state;

@end
