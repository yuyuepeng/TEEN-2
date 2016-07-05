//
//  AllUrls.h
//  IOS1560玉岳鹏考试
//
//  Created by 扶摇先生 on 16-1-4.
//  Copyright (c) 2016年 SingleProgrammers. All rights reserved.
//

#ifndef IOS1560______AllUrls_h
#define IOS1560______AllUrls_h
#define FirstUrl @"http://sns.maimaicha.com/api?apikey=b4f4ee31a8b9acc866ef2afb754c33e6&format=json&method=news.getSlideshow"
#define HeadUrl  @"http://sns.maimaicha.com/api?apikey=b4f4ee31a8b9acc866ef2afb754c33e6&format=json&method=news.getHeadlines"
#define OtherUrl @"http://sns.maimaicha.com/api?apikey=b4f4ee31a8b9acc866ef2afb754c33e6&format=json&method=news.getListByType"
#define SearchUrl @"http://sns.maimaicha.com/api?apikey=b4f4ee31a8b9acc866ef2afb754c33e6&format=json&method=news.searcListByTitle"

//详情接口(传入id)
#define Detailurl @"http://sns.maimaicha.com/api?method=news.getNewsContent&id=5610&apikey=b4f4ee31a8b9acc866ef2afb754c33e6&format=json"
#define BOUNDS self.view.bounds
#define KscreenSize ([UIScreen mainScreen].bounds.size)

#define KscreenWidth (KscreenSize.width)

#define KscreenWidth (KscreenSize.width)

#define KscreenHeight (KscreenSize.height)

#endif
