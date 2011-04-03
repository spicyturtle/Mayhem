//
//  main.m
//  Mayhem
//
//  Created by Tor Kreutzer on 4/3/11.
//  Copyright UiT 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate");
    [pool release];
    return retVal;
}
