//
//  ConfigMacro.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15/1/7.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

/**************************************************
 * 内容描述: 环境配置
 * 创 建 人: Tommy
 * 创建日期: 2015-01-07
 **************************************************/
#ifndef ____ConfigMacro_h
#define ____ConfigMacro_h

/**
 *环境配置开关,发布时请注释此宏
 */
#define DEBUG_FLAG

#ifdef DEBUG_FLAG
/***************开发环境*******************/
#define DLOG(...)           NSLog(__VA_ARGS__)

#else
/***************正式环境*******************/
#define DLOG(...)

#endif


#endif
