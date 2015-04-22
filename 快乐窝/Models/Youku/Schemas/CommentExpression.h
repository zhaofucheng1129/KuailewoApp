//
//  CommentExpression.h
//  快乐窝
//
//  Created by ZhaoFucheng on 15-1-9.
//  Copyright (c) 2015年 ZhaoFucheng. All rights reserved.
//

/**************************************************
 * 内容描述: YouKu评论表情
 * 创 建 人: Tommy
 * 创建日期: 2015-01-09
 **************************************************/

#import "BaseModel.h"

@interface CommentExpression : BaseModel
//字段	字段类型	允许为空	字段描述

//name	string	false	表情名称
@property (nonatomic, copy) NSString *name;

//icon	String	false	表情图片
@property (nonatomic, copy) NSString *icon;

@end
