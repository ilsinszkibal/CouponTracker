//
//  CardDrawingOperationEditProtocol.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CardDrawingOperationEditProtocol <NSObject>

- (void) commmitEdit;
- (void) presentImagePicker:(UIImagePickerController*) imagePicker;

@end

