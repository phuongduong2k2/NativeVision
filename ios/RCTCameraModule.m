//
//  RCTTimeModule.m
//  LinkingApp
//
//  Created by Duong Phuong on 24/7/25.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RCTCameraModule, NSObject)

RCT_EXTERN_METHOD(openCamera:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(nativePrinter: (NSString *)message)
RCT_EXTERN_METHOD(playMusic:(NSString)url resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
@end
