//
//  StepLoadImageView.h
//  StepLoadImageViewDemo
//
//  Created by Victor Ji on 16/7/26.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StepLoadImageView;
@protocol StepLoadImageViewDelegate <NSObject>

@optional
- (void)stepLoadImageView:(StepLoadImageView *)imageView downloadProgress:(CGFloat)progress atIndex:(NSInteger)index;

@end

@interface StepLoadImageView : UIImageView

@property (weak, nonatomic) id <StepLoadImageViewDelegate> delegate;

@property (copy, nonatomic) NSArray *imageUrlStrings;
@property (assign, nonatomic) NSInteger downloadedCount;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) UIImage *placeholderImage;

- (void)toNextPage;
- (void)toPreviousPage;
- (void)startUpDowloadImages;

@end
