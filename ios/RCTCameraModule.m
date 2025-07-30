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
@end
