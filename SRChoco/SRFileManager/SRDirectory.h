#import <Foundation/Foundation.h>

@class SRFile;

@interface SRDirectory : NSObject

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSURL *url;

@property (nonatomic, readonly) NSArray *files;
@property (nonatomic, readonly) NSArray *directories;

- (void)refresh;

@end