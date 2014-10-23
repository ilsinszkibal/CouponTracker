//
//  CTTemplateDataSource.m
//  CTServices
//
//  Created by Teveli László on 23/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTTemplateDataSource.h"
#import "CTNetworkingManager.h"
#import "Model.h"
#import "CTTemplateCell.h"

@interface CTTemplateDataSource ()

@property (nonatomic, strong) NSArray* templates;

@end

@implementation CTTemplateDataSource

- (void)setTemplateType:(CTTemplateType)templateType {
    _templateType = templateType;
    
    if (templateType == CTMyTemplates) {
        [[CTNetworkingManager sharedManager] getMyTemplates:^(NSArray* templates, NSError* error){
            if (!error) {
                self.templates = templates.copy;
            }
            [self.collectionView reloadData];
        }];
    } else {
        [[CTNetworkingManager sharedManager] getPopularTemplates:^(NSArray* templates, NSError* error){
            if (!error) {
                self.templates = templates.copy;
            }
            [self.collectionView reloadData];
        }];
    }
}

- (Model_CardTemplate*)templateForIndexPath:(NSIndexPath*)indexPath {
    if (self.templates.count < indexPath.row) {
        return self.templates[indexPath.row];
    }
    return nil;
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CTTemplateCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.template = [self templateForIndexPath:indexPath];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.templates.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

@end
