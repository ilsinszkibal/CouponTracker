//
//  CTQRCodeManager.m
//  Coupon
//
//  Created by Teveli László on 17/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CTQRCodeManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import <iOS-QR-Code-Encoder/QRCodeGenerator.h>

@interface CTQRCodeManager () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic, strong) NSArray *availableCodeTypes;

@property (nonatomic, assign, getter = isPrepared) BOOL prepared;
@property (nonatomic, assign, getter = isFrontCamera) BOOL frontCamera;
@property (nonatomic, strong) AVCaptureInput* currentInput;

- (void)setReading:(BOOL)reading;

@end

@implementation CTQRCodeManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.availableCodeTypes = @[AVMetadataObjectTypeQRCode];
        self.stopsReadingWhenCodeIsFound = YES;
        self.beepsWhenCodeIsFound = YES;
        self.vibratesWhenCodeIsFound = YES;
        self.reading = NO;
        self.prepared = NO;
        self.frontCamera = NO;
    }
    return self;
}

- (BOOL)prepareForReading {
    if (!self.isPrepared) {
        self.captureSession = [[AVCaptureSession alloc] init];
        
        self.frontCamera = YES;
        [self switchCamera];
        
        AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
        @try {
            [self.captureSession addOutput:captureMetadataOutput];
            
            dispatch_queue_t dispatchQueue;
            dispatchQueue = dispatch_queue_create("CaptureQueue", NULL);
            [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
            [captureMetadataOutput setMetadataObjectTypes:self.availableCodeTypes];
            
            if (self.beepsWhenCodeIsFound && !self.audioPlayer) {
                [self loadBeepSound];
            }
            
            self.prepared = YES;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    return YES;
}

- (BOOL)startReading {
    if (![self prepareForReading]) {
        return NO;
    }
    
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.videoPreviewLayer setFrame:self.previewView.layer.bounds];
    [self.previewView.layer addSublayer:self.videoPreviewLayer];
    
    [self.captureSession startRunning];
    
    [self setReading:YES];
    
    return YES;
}

- (BOOL)stopReading {
    [self.captureSession stopRunning];
    [self.videoPreviewLayer removeFromSuperlayer];
    self.reading = NO;
    return YES;
}

- (void)switchCamera {
    if (self.currentInput) {
        [UIView animateWithDuration:0.4 animations:^{
            self.previewView.alpha = 0;
        } completion:^(BOOL finished) {
            [self addVideoInputCamera:!self.frontCamera];
            [UIView animateWithDuration:0.4 delay:0.3 options:0 animations:^{
                self.previewView.alpha = 1;
            } completion:nil];
        }];
    } else {
        [self addVideoInputCamera:!self.frontCamera];
    }
}

- (BOOL)addVideoInputCamera:(BOOL)isFrontCamera {
    NSArray *devices = [AVCaptureDevice devices];
    AVCaptureDevice *frontCamera;
    AVCaptureDevice *backCamera;
    
    for (AVCaptureDevice *device in devices) {
        if ([device hasMediaType:AVMediaTypeVideo]) {
            if ([device position] == AVCaptureDevicePositionBack) {
                backCamera = device;
            } else {
                frontCamera = device;
            }
        }
    }
    
    NSError *error = nil;
    
    if (isFrontCamera) {
        AVCaptureDeviceInput *frontFacingCameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:frontCamera error:&error];
        if (!error) {
            [[self captureSession] removeInput:self.currentInput];
            if ([[self captureSession] canAddInput:frontFacingCameraDeviceInput]) {
                [[self captureSession] addInput:frontFacingCameraDeviceInput];
                self.frontCamera = YES;
                self.currentInput = frontFacingCameraDeviceInput;
                return YES;
            } else {
                [[self captureSession] addInput:self.currentInput];
            }
        }
    } else {
        AVCaptureDeviceInput *backFacingCameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
        if (!error) {
            [[self captureSession] removeInput:self.currentInput];
            if ([[self captureSession] canAddInput:backFacingCameraDeviceInput]) {
                [[self captureSession] addInput:backFacingCameraDeviceInput];
                self.frontCamera = NO;
                self.currentInput = backFacingCameraDeviceInput;
                return YES;
            } else {
                [[self captureSession] addInput:self.currentInput];
            }
        }
    }
    
    return NO;
}

- (void)setReading:(BOOL)reading {
    _reading = reading;
    if (self.delegate) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (reading && [self.delegate respondsToSelector:@selector(readingDidStart)]) {
                [self.delegate readingDidStart];
            } else if (!reading && [self.delegate respondsToSelector:@selector(readingDidStop)]) {
                [self.delegate readingDidStop];
            }
        });
    }
}

- (BOOL)loadBeepSound {
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];

    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", error);
        return NO;
    } else {
        [self.audioPlayer prepareToPlay];
        return YES;
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        for (NSString* codeType in self.availableCodeTypes) {
            if ([[metadataObj type] isEqualToString:codeType]) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(codeDidRead:ofType:)]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.delegate codeDidRead:[metadataObj stringValue] ofType:codeType];
                    });
                }
                if (self.beepsWhenCodeIsFound && self.audioPlayer) {
                    [self.audioPlayer play];
                }
                if (self.vibratesWhenCodeIsFound) {
                    //AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);//plays audio on unsupported devices
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//does nothing on upsupported devices
                }
                if (self.stopsReadingWhenCodeIsFound) {
                    [self stopReading];
                    [self setReading:NO];
                }
                self.lastReadCode = [metadataObj stringValue];
                UIGraphicsBeginImageContext(self.videoPreviewLayer.bounds.size);
                [self.videoPreviewLayer renderInContext:UIGraphicsGetCurrentContext()];
                self.lastReadImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
        }
    }
}

- (UIImage*)generateQRCodeFromString:(NSString*)string size:(CGFloat)size {
    return [QRCodeGenerator qrImageForString:string imageSize:size];
}

@end
