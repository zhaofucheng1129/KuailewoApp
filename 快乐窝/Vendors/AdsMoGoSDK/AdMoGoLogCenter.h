//
//  AdMoGoLogCenter.h
//  AdsMogo
//
//  Created by Daxiong on 14-2-21.
//
//

#import <Foundation/Foundation.h>

#ifndef MGLog
#define MGLog(lv,fmt, ...) \
if([[AdMoGoLogCenter shareInstance]canLog:lv]){\
    AdMoGoLogLeve logleve = [[AdMoGoLogCenter shareInstance]getLogLeveFlag];\
    if((logleve & AdMoGoLogError)==AdMoGoLogError && lv ==MGE){\
        NSLog((@"ADSMOGO-Log Error: " fmt), ##__VA_ARGS__);\
    }\
    if((logleve & AdMoGoLogDebug)==AdMoGoLogDebug && lv == MGD){\
        NSLog((@"ADSMOGO-Log Debug" "<FUNCTION:%s>: " fmt),__FUNCTION__, ##__VA_ARGS__);\
    }\
    if((logleve & AdMoGoLogTemp)==AdMoGoLogTemp && lv == MGT){\
        NSLog((@"ADSMOGO-Log Warning: " fmt), ##__VA_ARGS__);\
    }\
    if((logleve & AdMoGoLogProduction)==AdMoGoLogProduction && lv == MGP){\
        NSLog((@"ADSMOGO-Log Info" "<FUNCTION:%s>: " fmt),__FUNCTION__, ##__VA_ARGS__);\
    }\
}

//        NSLog((@"ADSMOGO-" "<FUNCTION:%s>-" "<LINE:%d>: " fmt),__FUNCTION__, __LINE__, ##__VA_ARGS__);
#endif


typedef enum {
    AdMoGoLogProduction = 1<<0,
    AdMoGoLogDebug      = 1<<1,
    AdMoGoLogNone       = 1<<2,
    AdMoGoLogTemp       = 1<<3,
    AdMoGoLogError      = 1<<4
}AdMoGoLogLeve;

typedef enum {
    MGP      = 1<<0,
    MGD      = 1<<1,
    MGN      = 1<<2,
    MGT      = 1<<3,
    MGE      = 1<<4
}AdMoGoLogLeveSample;

@interface AdMoGoLogCenter : NSObject

+ (AdMoGoLogCenter *)shareInstance;
- (BOOL)canLog:(int)levelFlag;
- (void)setLogLeveFlag:(AdMoGoLogLeve)levelFlag;
- (AdMoGoLogLeve)getLogLeveFlag;
@end
