//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved
//

#import <Foundation/Foundation.h>



/**
 * key返回结果
 *
 */
@interface AGCQuickLoginKeyResult : NSObject


/**
 * appkey
 */
@property(nonatomic, readonly) NSString *appKey;

/**
 * 请使用 initWithAppKey: 方法初始化
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 * 初始化方法
 * @param key 值
 * @return AGCQuickLoginKeyResult实例
 */
- (instancetype)initWithAppKey:(NSString *)key NS_DESIGNATED_INITIALIZER;

@end

