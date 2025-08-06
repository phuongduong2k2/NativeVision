//
//  RCTAudioModule.m
//  NativeVision
//
//  Created by Duong Phuong on 6/8/25.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RCTAudioModule, NSObject)

RCT_EXTERN_METHOD(playMusic:(NSString)url
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

@end
