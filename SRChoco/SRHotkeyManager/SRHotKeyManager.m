//
//  SRHotKeyManager.m
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 11. 10..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

#import "SRHotKeyManager.h"
#import <Carbon/Carbon.h>

#pragma mark - SRHotKey Class

@interface SRHotKey ()
@property (nonatomic, readonly) UInt32 modifiers;
@end

@implementation SRHotKey

- (id)initWithKeyCode:(UInt32)keyCode command:(BOOL)command control:(BOOL)control option:(BOOL)option shift:(BOOL)shift handler:(SRHotKeyHandler)handler {
    self = [super init];
    if (self) {
        self.keyCode = keyCode;
        self.command = command;
        self.control = control;
        self.option = option;
        self.shift = shift;
        self.handler = handler;
    }
    return self;
}

- (UInt32)modifiers {
    UInt32 result = 0;
    
    if (self.command) result += shiftKey;
    if (self.control) result += cmdKey;
    if (self.option) result += optionKey;
    if (self.shift) result += shiftKey;
    
    return result;
}

@end

#pragma mark - SRGlobalHotKeyManager Class

@interface SRGlobalHotKeyManager ()
@property (nonatomic, strong) SRHotKey *hotKey;
@end

OSStatus SRGlobalHotKeyManagerHandler(EventHandlerCallRef nextHandler, EventRef theEvent, void *userData) {
    SRGlobalHotKeyManager *manager = [SRGlobalHotKeyManager sharedManager];
    if (manager.hotKey && manager.hotKey.handler) {
        manager.hotKey.handler(manager.hotKey);
    }

    return noErr;
}

EventHotKeyRef g_hotKeyRef;

@implementation SRGlobalHotKeyManager

+ (SRGlobalHotKeyManager *)sharedManager {
    static SRGlobalHotKeyManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SRGlobalHotKeyManager alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        EventTypeSpec eventType;
        eventType.eventClass = kEventClassKeyboard;
        eventType.eventKind = kEventHotKeyPressed;
        
        InstallApplicationEventHandler(&SRGlobalHotKeyManagerHandler, 1, &eventType, NULL, NULL);
    }
    return self;
}

- (void)registerWithHotKey:(SRHotKey *)hotKey {
    self.hotKey = hotKey;
    
    EventHotKeyID hotKeyID;
    hotKeyID.signature = 'srgh';
    hotKeyID.id = 0;
    
    RegisterEventHotKey(hotKey.keyCode, hotKey.modifiers, hotKeyID, GetApplicationEventTarget(), 0, &g_hotKeyRef);
}

- (void)unregisterHotKey {
    UnregisterEventHotKey(g_hotKeyRef);
    self.hotKey = nil;
}

@end

#pragma mark - SRHotKeyManager Class

@implementation SRHotKeyManager
// TODO
@end
