//
//  ORIndicatorView.m
//  ORead
//
//  Created by noname on 14-7-26.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "ORIndicatorView.h"
#import "ORLoadingIndicator.h"
#import "ViewUtil.h"

#define ORIndictorViewPlayDuration 2.0f


@interface ORIndicatorView()

//@property (atomic, assign) CGSize size;

@end

@implementation ORIndicatorView

//@synthesize size;

- (id)initWithView:(UIView *)aView
{
    if (aView == nil)
    {
        aView = [ViewUtil mainWindow];
    }
    
    [ORIndicatorView hideAllHUDsForView:aView animated:NO];
    
    self = [super initWithView:aView];
    self.color = [UIColor colorWithWhite:1 alpha:1.0];
    //    [self setOpacity:0.72];
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOpacity = 0.6;
    self.layer.cornerRadius = 7;
    self.layer.shadowRadius = 2.0;
    self.minSize = CGSizeMake(65, 65);
    [aView addSubview:self];
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //	CGContextRef context = UIGraphicsGetCurrentContext();
    //	UIGraphicsPushContext(context);
    //
    //    // Set background rect color
    //    if (self.color) {
    //        CGContextSetFillColorWithColor(context, self.color.CGColor);
    //    } else {
    //        CGContextSetGrayFillColor(context, 0.0f, self.opacity);
    //    }
    //
    //	// Center HUD
    //	CGRect allRect = self.bounds;
    //	// Draw rounded HUD backgroud rect
    //	CGRect boxRect = CGRectMake(roundf((allRect.size.width - size.width) / 2) + self.xOffset,
    //								roundf((allRect.size.height - size.height) / 2) + self.yOffset, size.width, size.height);
    //	float radius = 4.0f;
    //	CGContextBeginPath(context);
    //	CGContextMoveToPoint(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect));
    //	CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMinY(boxRect) + radius, radius, 3 * (float)M_PI / 2, 0, 0);
    //	CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMaxY(boxRect) - radius, radius, 0, (float)M_PI / 2, 0);
    //	CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMaxY(boxRect) - radius, radius, (float)M_PI / 2, (float)M_PI, 0);
    //	CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect) + radius, radius, (float)M_PI, 3 * (float)M_PI / 2, 0);
    //	CGContextClosePath(context);
    //	CGContextFillPath(context);
    
    UIGraphicsPopContext();
}


#pragma mark - loading
+ (ORIndicatorView *)showLoading
{
    ORIndicatorView *HUD = [[ORIndicatorView alloc] initWithView:nil];
    
    [HUD setMode:MBProgressHUDModeCustomView];
    [HUD setRemoveFromSuperViewOnHide:YES];
    ORLoadingIndicator *indicator = [ORLoadingIndicator indicator];
    [indicator startAnimating];
    [HUD setCustomView:indicator];
    [HUD show:YES];
    
    return HUD;
}

+ (ORIndicatorView *)showLoadingInView:(UIView *)aView
{
    //    return [ORIndicatorView showLoadingString:@"正在处理..." inView:aView];
    
    ORIndicatorView *HUD = [[ORIndicatorView alloc] initWithView:aView];
    [HUD setMode:MBProgressHUDModeCustomView];
    [HUD setRemoveFromSuperViewOnHide:YES];
    
    ORLoadingIndicator *indicator = [ORLoadingIndicator indicator];
    [indicator startAnimating];
    [HUD setCustomView:indicator];
    [HUD show:YES];
    
    return HUD;
}

+ (void)hideLoading
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [ORIndicatorView hideAllHUDsForView:[ViewUtil mainWindow] animated:YES];
    });
}

+ (ORIndicatorView *)showLoadingString:(NSString *)aString
{
    ORIndicatorView *HUD = [self showLoadingString:aString inView:nil];
    return HUD;
}

+ (ORIndicatorView *)showLoadingString:(NSString *)aString inView:(UIView *)aView
{
    ORLoadingIndicator *indicator = [ORLoadingIndicator indicator];
    
    [indicator startAnimating];
    
    UIView *customView = [[UIView alloc] initWithFrame:indicator.bounds];
    
    UILabel *label = [[UILabel alloc] initWithFrame:indicator.bounds];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1]];
    [label setText:aString];
    [label setFont:[UIFont systemFontOfSize:15.0f]];
    [label sizeToFit];
    [label setTag:111];
    
    [ViewUtil resetView:customView ofWidth:indicator.bounds.size.width + label.bounds.size.width + 12.0f];
    [customView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
    [customView addSubview:indicator];
    [customView addSubview:label];
    [label setCenter:CGPointMake(customView.bounds.size.width - label.bounds.size.width/2.0f, customView.bounds.size.height/2.0f)];
    ORIndicatorView *HUD = [[ORIndicatorView alloc] initWithView:aView];
    [HUD setMode:MBProgressHUDModeCustomView];
    [HUD setRemoveFromSuperViewOnHide:YES];
    [HUD setMargin:20.0f];
    [HUD setCustomView:customView];
    [HUD show:YES];
    return HUD;
}

- (void)updateLoadingString:(NSString *)aString
{
    UILabel *label = (UILabel *)[self.customView viewWithTag:111];
    [label setText:aString];
    [label sizeToFit];
}

+ (ORIndicatorView *)showString:(NSString *)aString
{
    ORIndicatorView *HUD = [[ORIndicatorView alloc] initWithView:nil];
    [HUD setMode:MBProgressHUDModeText];
    
    [HUD setDetailsLabelText:aString];
    HUD.detailsLabelColor = [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1];
    
    [HUD setDetailsLabelFont:[UIFont systemFontOfSize:15.0f]];
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(ORIndictorViewPlayDuration);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
    
    return HUD;
}

+ (ORIndicatorView *)showCustomView:(UIView *)aCustomView inView:(UIView *)aView
{
    ORIndicatorView *HUD = [[ORIndicatorView alloc] initWithView:aView];
    
    [HUD setMode:MBProgressHUDModeCustomView];
    [HUD setMargin:0.0f];
    [HUD setRemoveFromSuperViewOnHide:YES];
    [HUD setColor:[UIColor clearColor]];
    [HUD setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.3f]];
    [HUD setCustomView:aCustomView];
    [HUD show:YES];
    
    return HUD;
}

+ (ORIndicatorView *)showCustomView:(UIView *)aCustomView inView:(UIView *)aView hideAfterDelay:(CGFloat)aDelay
{
    ORIndicatorView *HUD = [[ORIndicatorView alloc] initWithView:aView];
    
    [HUD setMode:MBProgressHUDModeCustomView];
    [HUD setMargin:0.0f];
    [HUD setRemoveFromSuperViewOnHide:YES];
    [HUD setColor:[UIColor clearColor]];
    [HUD setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.3f]];
    [HUD setCustomView:aCustomView];
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(aDelay);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
    
    return HUD;
}

+ (void)hideAllInView:(UIView *)aView
{
    if (aView == nil)
    {
        aView = [ViewUtil mainWindow];
    }
    [ORIndicatorView hideAllHUDsForView:aView animated:YES];
}


@end
