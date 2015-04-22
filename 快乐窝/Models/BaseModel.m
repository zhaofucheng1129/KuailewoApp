//
//  BaseModel.m
//  WeiboCloned
//
//  Created by 赵 福成 on 14-6-28.
//  Copyright (c) 2014年 ZhaoFucheng. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

NSString* const BaseModelErrorDomain = @"BaseModelErrorDomain";

typedef NS_ENUM(int, kJSONModelErrorTypes)
{
    kBaseModelErrorInvalidData = 1,
    kBaseModelErrorBadResponse = 2,
    kBaseModelErrorBadJSON = 3,
    kBaseModelErrorModelIsInvalid = 4,
    kBaseModelErrorNilInput = 5
};

@implementation BaseModel

-(id)initWithDictionary:(NSDictionary*)dict error:(NSError**)err{
    
    //check for nil input
    if (dict == nil) {
        if (err) *err = [NSError errorWithDomain:BaseModelErrorDomain
                                                   code:kBaseModelErrorNilInput
                                               userInfo:@{NSLocalizedDescriptionKey:@"Initializing model with nil input object."}];

        return nil;
    }
    
    //invalid input, just create empty instance
    if (![dict isKindOfClass:[NSDictionary class]]) {
        
        NSString *message = @"Attempt to initialize JSONModel object using initWithDictionary:error: but the dictionary parameter was not an 'NSDictionary'.";
        message = [NSString stringWithFormat:@"Invalid JSON data: %@", message];
        if (err) *err = [NSError errorWithDomain:BaseModelErrorDomain
                                             code:kBaseModelErrorInvalidData
                                         userInfo:@{NSLocalizedDescriptionKey:message}];
        return nil;
    }
    
    //create a class instance
    self = [self init];
    if (!self) {
        
        //super init didn't succeed
        if (err) *err = [NSError errorWithDomain:BaseModelErrorDomain
                                                   code:kBaseModelErrorModelIsInvalid
                                               userInfo:@{NSLocalizedDescriptionKey:@"Model does not validate. The custom validation for the input data failed."}];
        return nil;
    }
    
    [self setAttributes:dict];
    
    return self;
}


-(id)initWithJson:(NSString*)json error:(NSError **)err
{
    NSError* initError = nil;
    id objModel = [self initWithString:json usingEncoding:NSUTF8StringEncoding error:&initError];
    if (initError && err) *err = initError;
    return objModel;
}

-(id)initWithString:(NSString *)string usingEncoding:(NSStringEncoding)encoding error:(NSError**)err
{
    //check for nil input
    if (!string) {
        if (err) *err = [NSError errorWithDomain:BaseModelErrorDomain code:kBaseModelErrorNilInput userInfo:@{NSLocalizedDescriptionKey:@"Initializing model with nil input object."}];
        return nil;
    }
    
    //read the json
    NSError* initError = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:encoding]
                                             options:kNilOptions
                                               error:&initError];
    
    if (initError) {
        if (err) *err = [NSError errorWithDomain:BaseModelErrorDomain
                                                            code:kBaseModelErrorBadJSON
                                                        userInfo:@{NSLocalizedDescriptionKey:@"Malformed JSON. Check the Model data input."}];
        return nil;
    }
    
    //init with dictionary
    id objModel = [self initWithDictionary:obj error:&initError];
    if (initError && err) *err = initError;
    return objModel;
}

-(NSDictionary*)attributeMapDictionary{
    return nil;
}

-(SEL)getSetterSelWithAttibuteName:(NSString*)attributeName{
    NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
    NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
    return NSSelectorFromString(setterSelStr);
}
- (NSString *)customDescription{
    return nil;
}

- (NSString *)description{
    NSMutableString *attrsDesc = [NSMutableString stringWithCapacity:100];
    unsigned int nCount = 0;
    objc_property_t *popertylist = class_copyPropertyList([self class],&nCount);
    for (int i = 0; i < nCount; i++) {
        objc_property_t property = popertylist[i];
        NSString *methodName = [NSString stringWithFormat:@"%s", property_getName(property)];
        SEL getSel = NSSelectorFromString(methodName);
        if ([self respondsToSelector:getSel]) {
            id valueObj = [self valueForKey:methodName];
            if (valueObj) {
                [attrsDesc appendFormat:@" [%@=%@] ",methodName, valueObj];
                //[valueObj release];
            }else {
                [attrsDesc appendFormat:@" [%@=nil] ",methodName];
            }
        }
    }
    
    NSString *customDesc = [self customDescription];
    NSString *desc;
    
    if (customDesc && [customDesc length] > 0 ) {
        desc = [NSString stringWithFormat:@"%@:{%@,%@}",[self class],attrsDesc,customDesc];
    }else {
        desc = [NSString stringWithFormat:@"%@:{%@}",[self class],attrsDesc];
    }
    
    return desc;
}
-(void)setAttributes:(NSDictionary*)dataDic{
    NSDictionary *attrMapDic = [self attributeMapDictionary];
    if (attrMapDic == nil) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[dataDic count]];
        for (NSString *key in dataDic) {
            [dic setValue:dataDic[key] forKey:key];
            attrMapDic = dic;
        }
    }
    NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
    id attributeName;
    while ((attributeName = [keyEnum nextObject])) {
        //当前对象属性列表
        unsigned int selfCount = 0;
        objc_property_t *selfPropertylist = class_copyPropertyList([self class],&selfCount);
        for(int i = 0; i < selfCount; i++)
        {
            objc_property_t currProperty = selfPropertylist[i];
            NSString *currPropertyName = [NSString stringWithFormat:@"%s", property_getName(currProperty)];
            if ([[currPropertyName uppercaseString] isEqualToString:[attributeName uppercaseString]]) {
                id value = attrMapDic[attributeName];
                [self setProperty:value forKey:currPropertyName];
                break;
            }
        }
//        free(selfPropertylist);
    }
}
- (id)initWithCoder:(NSCoder *)decoder{
    if( self = [super init] ){
        NSDictionary *attrMapDic = [self attributeMapDictionary];
        if (attrMapDic == nil) {
            
        }
        unsigned int nCount = 0;
        objc_property_t *popertylist = class_copyPropertyList([self class],&nCount);
        for (int i = 0; i < nCount; i++) {
            objc_property_t property = popertylist[i];
            NSString *methodName = [NSString stringWithFormat:@"%s", property_getName(property)];
            SEL sel = [self getSetterSelWithAttibuteName:methodName];
            if ([self respondsToSelector:sel]) {
                id obj = [decoder decodeObjectForKey:methodName];
//                [self setValue:obj forKey: methodName];
                [self setProperty:obj forKey:methodName];
            }
            
        }
        free(popertylist);
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder{
    NSDictionary *attrMapDic = [self attributeMapDictionary];
    if (attrMapDic == nil) {
        
    }
    unsigned int nCount = 0;
    objc_property_t *popertylist = class_copyPropertyList([self class],&nCount);
    for (int i = 0; i < nCount; i++) {
        objc_property_t property = popertylist[i];
        NSString *methodName = [NSString stringWithFormat:@"%s", property_getName(property)];
        SEL getSel = NSSelectorFromString(methodName);
        if ([self respondsToSelector:getSel]) {
            id valueObj = [self valueForKey:methodName];            
            if (valueObj) {
                [encoder encodeObject:valueObj forKey:methodName];
            }
        }
    }
    free(popertylist);
}

- (NSData*)getArchivedData{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

- (NSString *)cleanString:(NSString *)str {
    if (str == nil) {
        return @"";
    }
    NSMutableString *cleanString = [NSMutableString stringWithString:str];
    [cleanString replaceOccurrencesOfString:@"\n" withString:@""
                                    options:NSCaseInsensitiveSearch
                                      range:NSMakeRange(0, [cleanString length])];
    [cleanString replaceOccurrencesOfString:@"\r" withString:@""
                                    options:NSCaseInsensitiveSearch
                                      range:NSMakeRange(0, [cleanString length])];
    return cleanString;
}


- (void)setProperty:(id)value forKey:(NSString *)key
{
    if (value != nil && ![value isKindOfClass:[NSNull class]])
    {
        [self setValue:value forKey:key];
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:[self getSetterSelWithAttibuteName:key] withObject:nil];
#pragma clang diagnostic pop
    }
}


#ifdef _FOR_DEBUG_
-(BOOL) respondsToSelector:(SEL)aSelector {
    //    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];  
}  
#endif


@end
