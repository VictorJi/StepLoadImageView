//
//  StepLoadImageView.m
//  StepLoadImageViewDemo
//
//  Created by Victor Ji on 16/7/26.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "StepLoadImageView.h"
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/UIImageView+WebCache.h>

typedef NS_ENUM(NSUInteger, SLImageDownloadStatus) {
    SLImageDownloadStatusNone = 0,
    SLImageDownloadStatusDownloading,
    SLImageDownloadStatusSuccess,
    SLImageDownloadStatusFail
};

@interface StepLoadImageView ()

@property (strong, nonatomic) SDWebImageManager *manager;
@property (assign, nonatomic) SDWebImageOptions options;

@property (strong, nonatomic) NSMutableArray *downloadFlags;

@end

@implementation StepLoadImageView

#pragma mark - init

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupDefault];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDefault];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefault];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        [self setupDefault];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    self = [super initWithImage:image highlightedImage:highlightedImage];
    if (self) {
        [self setupDefault];
    }
    return self;
}

- (void)setupDefault {
    self.manager = [SDWebImageManager sharedManager];
    self.options = SDWebImageRetryFailed | SDWebImageContinueInBackground | SDWebImageAvoidAutoSetImage;
    
    self.currentIndex = 0;
    self.downloadedCount = 5;
    self.downloadFlags = [[NSMutableArray alloc] init];
}


#pragma mark - set

- (void)setImageUrlStrings:(NSArray *)imageUrlStrings {
    _imageUrlStrings = imageUrlStrings;
    
    for (NSInteger i = 0; i < imageUrlStrings.count; i ++) {
        [self.downloadFlags addObject:[NSNumber numberWithInteger:SLImageDownloadStatusNone]];
    }
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    _placeholderImage = placeholderImage;
    
    [self setImage:placeholderImage];
}

#pragma mark - download

- (void)startUpDowloadImages {
    NSInteger downloadEndIndex = self.currentIndex + self.downloadedCount <= self.imageUrlStrings.count - 1 ? self.currentIndex + self.downloadedCount : self.imageUrlStrings.count - 1;
    
    for (NSInteger i = self.currentIndex; i < downloadEndIndex; i ++) {
        if ([self.downloadFlags[i] integerValue] == SLImageDownloadStatusNone || [self.downloadFlags[i] integerValue] == SLImageDownloadStatusFail) {
            [self.downloadFlags setObject:[NSNumber numberWithInteger:SLImageDownloadStatusDownloading] atIndexedSubscript:i];
            
            NSString *imageUrlString = self.imageUrlStrings[i];
            StepLoadImageView * __weak weakSelf = self;
            [self downloadImageWithUrl:[NSURL URLWithString:imageUrlString] index:i completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                StepLoadImageView * __strong strongSelf = weakSelf;
                if (finished && image) {
                    [strongSelf.downloadFlags setObject:[NSNumber numberWithInteger:SLImageDownloadStatusSuccess] atIndexedSubscript:i];
                    if (i == 0) {
                        [strongSelf setImage:image];
                    }
                } else {
                    [strongSelf.downloadFlags setObject:[NSNumber numberWithInteger:SLImageDownloadStatusFail] atIndexedSubscript:i];
                }
            }];
        }
    }
}

- (void)downloadImageWithUrl:(NSURL *)url index:(NSInteger)index completed:(SDWebImageCompletionWithFinishedBlock)completeBlock {
    StepLoadImageView * __weak weakSelf = self;
    [self.manager downloadImageWithURL:url options:self.options progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        StepLoadImageView * __strong strongSelf = weakSelf;
        if ([strongSelf.delegate respondsToSelector:@selector(stepLoadImageView:downloadProgress:atIndex:)]) {
            CGFloat percent = receivedSize / expectedSize;
            [strongSelf.delegate stepLoadImageView:strongSelf downloadProgress:percent atIndex:index];
        }
    } completed:completeBlock];
}

#pragma mark - actions 

- (void)toNextPage {
    if (self.currentIndex < self.imageUrlStrings.count - 1) {
        NSInteger nextIndex = self.currentIndex + 1;
        self.currentIndex = nextIndex;
        NSURL *imageUrl = [NSURL URLWithString:self.imageUrlStrings[nextIndex]];
        [self sd_setImageWithURL:imageUrl placeholderImage:self.placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // do sth
        }];
        [self startUpDowloadImages];
    } else {
        NSLog(@"current is last page");
    }
}

- (void)toPreviousPage {
    if (self.currentIndex > 0) {
        NSInteger previousIndex = self.currentIndex - 1;
        self.currentIndex = previousIndex;
        NSURL *imageUrl = [NSURL URLWithString:self.imageUrlStrings[previousIndex]];
        [self sd_setImageWithURL:imageUrl placeholderImage:self.placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // do sth
        }];
    } else {
        NSLog(@"current is first page");
    }
}

@end
