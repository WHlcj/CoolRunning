//
//  AGCAlipayAuthProvider.h
//  Pods
//
//  Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved
//

#import <Foundation/Foundation.h>
#import "AGCAuthCredential.h"
/**
 * 支付宝凭证提供者
 */
NS_ASSUME_NONNULL_BEGIN

@interface AGCAlipayAuthProvider : NSObject
/**
 * 登录凭证构造器
 *
 * @param authCode 由支付宝 SDK授权后获得的authCode
 * @return 用于登录的凭证
 */
+ (AGCAuthCredential *)credentialWithAuthCode:(NSString *)authCode;
/**
 * 登录凭证构造器
 *
 * @param authCode 由支付宝 SDK授权后获得的authCode
 * @param autoCreateUser 是否创建账户
 * @return 用于登录的凭证
 */
+ (AGCAuthCredential *)credentialWithAuthCode:(NSString *)authCode autoCreateUser:(BOOL)autoCreateUser;

@end

NS_ASSUME_NONNULL_END
