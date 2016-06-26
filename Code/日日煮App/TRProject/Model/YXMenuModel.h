//
//  YXMenuModel.h
//  TRProject
//
//  Created by 李晨 on 16/6/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Parse.h"
@class MenuDataModel;
@interface YXMenuModel : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) NSArray<MenuDataModel *> *data;

@property (nonatomic, copy) NSString *code;

@end
@interface MenuDataModel : NSObject

@property (nonatomic, copy) NSString *detailsUrl;

@property (nonatomic, assign) NSInteger clickCount;

@property (nonatomic, copy) NSString *difficulty;
//id -> ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *categoryID;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *imageUrlFlow;

@property (nonatomic, copy) NSString *lable;

@property (nonatomic, copy) NSString *nivoRelId;

@property (nonatomic, copy) NSString *taste;

@property (nonatomic, assign) NSInteger deleteStatus;
//description -> desc
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, strong) NSArray *screList;

@property (nonatomic, copy) NSString *technology;

@property (nonatomic, copy) NSString *peopleEat;

@property (nonatomic, copy) NSString *releaseDate;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *loadContent;

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *screeningId;

@property (nonatomic, copy) NSString *indexUrl;

@property (nonatomic, copy) NSString *imageHeight;

@property (nonatomic, copy) NSString *parentCategoryId;

@property (nonatomic, copy) NSString *shareUrl;

@property (nonatomic, copy) NSString *maketime;

@property (nonatomic, copy) NSString *pageInfo;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger shareCount;

@property (nonatomic, assign) BOOL favorite;

@property (nonatomic, copy) NSString *releasePlat;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) long long modifyDate;

@property (nonatomic, copy) NSString *imageWidth;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *videoRelId;

@property (nonatomic, copy) NSString *displayState;

@end

