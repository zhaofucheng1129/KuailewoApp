
/*
 反射工具类 old code
 */

#import <Foundation/Foundation.h>

@interface AdMoGoClassWrapper : NSObject {
	Class theClass;
}

- (id)initWithClass:(Class)c;

@property (nonatomic, readonly) Class theClass;

@end
