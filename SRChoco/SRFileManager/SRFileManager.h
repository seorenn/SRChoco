#import <Foundation/Foundation.h>

@class SRDirectory;
@class SRFile;

@interface SRFileManager : NSObject {
    NSFileManager *_sharedFM;
}

@property (nonatomic, readonly) NSArray *files;
@property (nonatomic, readonly) NSArray *directories;

- (id)init;
- (id)initWithPathString:(NSString *)path;
- (id)initWithURL:(NSURL *)url;

- (BOOL)refresh;


#pragma mark - Old

+ (SRFileManager *)sharedManager;

- (NSString *)pathForDownload;
- (NSString *)pathForMovie;
- (NSURL *)urlForDownload;
- (BOOL)isDirectory:(NSString *)path;

- (int)depthOfPath:(NSString *)path fromRootPath:(NSString *)rootPath;

- (NSArray *)walkPath:(NSString *)path;
- (NSArray *)walkPath:(NSString *)path withHidden:(BOOL)hidden;
- (NSArray *)walkPath:(NSString *)path withDepthLimit:(int)limit;
- (NSArray *)walkPath:(NSString *)path withDepthLimit:(int)limit withHidden:(BOOL)hidden;

- (BOOL)touchPath:(NSString *)path;

@end
