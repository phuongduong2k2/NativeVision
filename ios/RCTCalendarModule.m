//
//  RCTCalendarModule.m
//  LinkingApp
//
//  Created by Duong Phuong on 24/7/25.
//

#import "RCTCalendarModule.h"  // Import your own header
#import <React/RCTLog.h>      // For logging
#import <UIKit/UIKit.h>       // <--- ADD THIS IMPORT!

@implementation RCTCalendarModule

// The RCT_EXPORT_MODULE() macro is typically placed right after @implementation
// to register the module.
// If no name is provided, React Native will use the class name,
// stripping "RCT" or "RK" prefixes. So this module will be "CalendarModule" in JS.
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(createCalendarEvent:(NSString *)name location:(NSString *)location)
{
  RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
  // Your actual native iOS code to create a calendar event would go here.
}

// Synchronous methods are generally discouraged in React Native
// as they can block the UI thread. Use with caution.
RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getName)
{
  return [[UIDevice currentDevice] name];
}

@end
