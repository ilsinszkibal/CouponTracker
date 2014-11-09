//
//  CardDrawingLayerView.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardDrawingLayerView.h"

#import "CouponDrawingData.h"
#import "CouponDrawingBaseLayer.h"

@interface CardDrawingLayerView ()<UITableViewDataSource, UITableViewDelegate> {
    
    id<CouponCardDrawerManagerProtocol> _listener;
    
    CouponDrawingData* _drawingData;
    
    UIButton* _editButton;
    UITableView* _tableView;
    BOOL addNewLayerMode;
    
}

@end

@implementation CardDrawingLayerView

- (id) init
{
    self = [super init];
    
    if ( self )
    {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [_editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editButton addTarget:self action:@selector(editRowOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_editButton];
        
        _tableView = [[UITableView alloc] init];
        [_tableView setBackgroundColor:[UIColor clearColor] ];
        [_tableView setSeparatorColor:[UIColor clearColor] ];
        _tableView.rowHeight = 50;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
        addNewLayerMode = YES;
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [_editButton setFrame:CGRectMake(0, 0, self.bounds.size.width, 44) ];
    [_tableView setFrame:CGRectMake(0, 44, self.bounds.size.width, self.bounds.size.height - 44)];
    
}

#pragma mark - Private

- (NSString*) tableCellIdentifier
{
    return @"LayerCellId";
}

#pragma mark -UITableView moving

- (void) editRowOrderAction:(UIButton*) button
{
    BOOL editing = ![_tableView isEditing];
    
    addNewLayerMode = !editing;
    [_tableView reloadData];
    
    [_tableView setEditing:editing animated:YES];
    
    if ( editing == NO )
    {
        [_listener resetPresenting];
    }
    
}

- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ( [self isNewLayerCandidate:indexPath.row] )
        return NO;
    
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    CouponDrawingBaseLayer* layer = [_drawingData removeLayerAtIndex:sourceIndexPath.row];
    [_drawingData addLayer:layer AtIndex:proposedDestinationIndexPath.row];
    
    // Allow the proposed destination.
    return proposedDestinationIndexPath;
}

#pragma mark - UITableView

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ( [_drawingData layerCount] == 0 )
        return 1;
    
    if ( [_drawingData canAddMoreLayers] == NO || addNewLayerMode == NO )
        return [_drawingData layerCount];
    
    return 2 * [_drawingData layerCount] + 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[self tableCellIdentifier] ];
    
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self tableCellIdentifier] ];
        [cell setBackgroundColor:[UIColor clearColor] ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [UIFactory setBordersAndCornerToButton:cell];
    }
    
    UIImage* imageToPresent = [self imageForIndex:indexPath.row];
    [cell.imageView setImage:imageToPresent ];
    
    return cell;
}

- (void) tableView:(UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( [self isNewLayerCandidate:indexPath.row] )
    {
        NSUInteger candidateIndex = [self candidateLayerIndexForTableIndex:indexPath.row];
        [_listener layerCandidateAtIndex:candidateIndex ];
    }
    else
    {
        NSUInteger layerIndex = [self existingLayerIndexForTableIndex:indexPath.row];
        [_listener startEditingLayerAtIndex:layerIndex];
    }
}

#pragma mark - Rows

- (UIImage*) imageForIndex:(NSUInteger) index
{
    //No image
    if ( [_drawingData layerCount] == 0 )
        return [self addImage];
    
    //Every image is rendered
    if ( [_drawingData canAddMoreLayers] == NO || addNewLayerMode == NO )
        return [[_drawingData layerAtIndex:index ] renderedImage];
    
    if ( index % 2 == 0 )
        return [self addImage];
    
    CouponDrawingBaseLayer* layer = [_drawingData layerAtIndex:( ( index - 1 ) / 2 ) ];
    return [layer renderedImage];
}

- (UIImage*) addImage
{
    return [UIFactory imageWhiteNamed:@"add"];
}

- (BOOL) isNewLayerCandidate:(NSUInteger) tableIndex
{
    
    if ( [_drawingData layerCount] == 0 )
        return YES;
    
    if ( [_drawingData canAddMoreLayers] == NO || addNewLayerMode == NO )
        return NO;
    
    if ( tableIndex % 2 == 0 )
        return YES;
    
    return NO;
}

- (NSUInteger) candidateLayerIndexForTableIndex:(NSUInteger) tableIndex
{
    if ( [_drawingData layerCount] == 0 )
        return 0;
    
    return tableIndex / 2;
}

- (NSUInteger) existingLayerIndexForTableIndex:(NSUInteger) tableIndex
{
    
    //Return invalid
    if ( [_drawingData layerCount] == 0 )
        return tableIndex;
    
    //Same as tableIndex
    if ( [_drawingData canAddMoreLayers] == NO || addNewLayerMode == NO )
        return tableIndex;
    
    //Return invalid
    if ( tableIndex % 2 == 0 )
        return [_drawingData layerCount] +1;
    
    
    return ( tableIndex - 1 ) / 2;
}

- (NSUInteger) tableViewIndexForLayerIndex:(NSUInteger) layerIndex
{
    
    if ( [_drawingData layerCount] == 0 )
        return 0;
    
    if ( [_drawingData canAddMoreLayers] == NO )
        return layerIndex;
    
    return layerIndex * 2 + 1;
}

#pragma mark - Public

- (void) setDrawerListener:(id<CouponCardDrawerManagerProtocol>) drawerListener
{
    _listener = drawerListener;
}

- (void) setDrawingData:(CouponDrawingData*) drowingData
{
    _drawingData = drowingData;
}

- (void) updateStateIfNeeded
{
    
    switch ( [_drawingData state] ) {
        default:
        case CouponDrawingStateUnkown:
            break;
            
        case CouponDrawingStatePresent:
            [self reloadData];
            break;
            
        case CouponDrawingStateEdit:
            [self reloadData];
            break;
            
        case CouponDrawingStateCommitEdit:
            [self reloadData];
            break;
    }
    
}

#pragma mark - Private

- (void) reloadData
{
    [_tableView reloadData];
}

- (void) scrollToDataLayerIndex
{
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[self tableViewIndexForLayerIndex:[_drawingData layerIndex] ] inSection:0];
    [_tableView selectRowAtIndexPath:indexPath animated:indexPath scrollPosition:UITableViewScrollPositionMiddle];
}

@end
