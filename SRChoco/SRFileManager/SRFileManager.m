#import "SRFileManager.h"
#import "SRFile.h"

@implementation SRFileManager

#pragma mark - Old

+ (SRFileManager *)sharedManager
{
    static SRFileManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SRFileManager alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _sharedFM = [NSFileManager defaultManager];
    }
    return self;
}

- (NSString *)pathForDownload
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    if (!paths || [paths count] <= 0) return nil;
    return [paths objectAtIndex:0];
}

- (NSString *)pathForMovie
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSMoviesDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    if (!paths || [paths count] <= 0) return nil;
    return [paths objectAtIndex:0];
}

- (NSURL *)urlForDownload
{
    NSArray *urls = [_sharedFM URLsForDirectory:NSDownloadsDirectory
                                     inDomains:NSUserDomainMask];
    if (!urls || [urls count] <= 0) return nil;
    return [urls objectAtIndex:0];
}

- (BOOL)isDirectory:(NSString *)path
{
    BOOL isDirectory = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    return isDirectory;
}

- (int)depthOfPath:(NSString *)path fromRootPath:(NSString *)rootPath
{
    if ([path hasPrefix:rootPath] == NO) {
        return -1;
    }
    
    NSArray *rootItems = [rootPath componentsSeparatedByString:@"/"];
    NSArray *items = [path componentsSeparatedByString:@"/"];
    
    int depth = (int)[items count] - (int)[rootItems count] - 1;
    if (depth < 0) depth = 0;
    return depth;
}

- (NSArray *)walkSingleDepthPath:(NSString *)path
{
    NSArray *files = [_sharedFM contentsOfDirectoryAtPath:path error:nil];
    if ([files count] <= 0) return nil;
    
    NSMutableArray *res = [[NSMutableArray alloc] init];
    for (NSString *file in files) {
        NSString *fullpath = [path stringByAppendingPathComponent:file];
        SRFile *f = [[SRFile alloc] initWithPath:fullpath];
        [res addObject:f];
    }

    return res;
}

- (NSArray *)walkPath:(NSString *)path
{
    return [self walkPath:path withDepthLimit:-1];
}

- (NSArray *)walkPath:(NSString *)path withHidden:(BOOL)hidden
{
    return [self walkPath:path withDepthLimit:-1 withHidden:hidden];
}

- (NSArray *)walkPath:(NSString *)path withDepthLimit:(int)limit;
{
    return [self walkPath:path withDepthLimit:limit withHidden:YES];
}

- (NSArray *)walkPath:(NSString *)path withDepthLimit:(int)limit withHidden:(BOOL)hidden
{
    NSMutableArray *remainDirs = [[NSMutableArray alloc] init];
    NSMutableArray *result = [[NSMutableArray alloc] init];

    NSArray *current = [self walkSingleDepthPath:path];
    if (!current) return nil;
    
    while (current) {
        for (SRFile *file in current) {
            if (!hidden && [file isHidden]) continue;
            [result addObject:file];
            
            if ([file isDirectory]) {
                int depth = [self depthOfPath:file.path fromRootPath:path];
                if (limit < 0 || depth < limit) {
                    [remainDirs addObject:file.path];
                }
            }
        }
        
        if ([remainDirs count] > 0) {
            current = [self walkSingleDepthPath:[remainDirs objectAtIndex:0]];
            [remainDirs removeObjectAtIndex:0];
        } else {
            break;
        }
    }

    return result;
}

/***
 * Function for create empty file which similars of UNIX touch utility
 * But, this method will fail when path already exists
 */
- (BOOL)touchPath:(NSString *)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        return NO;
    }
    
    if (![fm createFileAtPath:path contents:nil attributes:nil]) {
        return NO;
    }
    
    return YES;
}

@end
