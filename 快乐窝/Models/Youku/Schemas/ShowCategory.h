//
//  ShowCategory.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-9.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

/**************************************************
* 内容描述: YouKu节目分类
* 创 建 人: Tommy
* 创建日期: 2015-01-09
**************************************************/

#import "BaseModel.h"

@interface ShowCategory : BaseModel
//字段	字段类型	允许为空	字段描述

//term	string	false	视频分类标识
@property (nonatomic, copy) NSString *term;

//label	String	false	视频分类显示名称
@property (nonatomic, copy) NSString *label;

//lang	string	false	语言
@property (nonatomic, copy) NSString *lang;

//genre	String	false	类型
@property (nonatomic, copy) NSString *genre;

@end
