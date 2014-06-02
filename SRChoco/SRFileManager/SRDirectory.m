#import "SRDirectory.h"

@interface SRDirectory (Private)
@property (nonatomic, strong) NSFileManager *fileManager;
@end

@implementation SRDirectory

- (id)init
{
    self = [super init];
    if (self) {
        self.fileManager = [NSFileManager defaultManager];
    }
    return self;
}

- (void)refresh
{
    // TODO
}

@end
