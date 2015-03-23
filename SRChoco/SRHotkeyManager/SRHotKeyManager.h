//
//  SRHotKeyManager.h
//  SRChoco
//
//  Created by Heeseung Seo on 2014. 11. 10..
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SRHotKey;
typedef void (^SRGlobalHotKeyHandler)();

/* The Key Code (from HITookbox/Events.h)
 ANSI Characters = kVK_ANSI_?
 eg. 'A' is kVK_ANSI_A
 
 Another Key Codes = kVK_?????
 eg. RETURN in kVK_Return
 */
@interface SRHotKey: NSObject
@property (nonatomic, assign) BOOL command;
@property (nonatomic, assign) BOOL control;
@property (nonatomic, assign) BOOL option;
@property (nonatomic, assign) BOOL shift;
@property (nonatomic, assign) UInt32 keyCode;
- (id)initWithKeyCode:(UInt32)keyCode command:(BOOL)command control:(BOOL)control option:(BOOL)option shift:(BOOL)shift;
@end

@interface SRGlobalHotKeyManager: NSObject
+ (SRGlobalHotKeyManager *)sharedManager;
- (void)registerWithHotKey:(SRHotKey *)hotKey handler:(SRGlobalHotKeyHandler)handler;
@end

@interface SRHotKeyManager : NSObject
// TODO
@end
