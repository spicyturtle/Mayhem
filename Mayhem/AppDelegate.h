//
//  AppDelegate.h
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright UiT 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
