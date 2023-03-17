//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved
//

#import <Foundation/Foundation.h>
#import "AGCAuthCredential.h"
#import <HMFoundation/HMFoundation.h>
#import "AGCQuickLoginKeyResult.h"
#import <AGConnectCore/AGConnectCore.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * iTA凭证提供者
 */
@interface AGCQuickLoginAuthProvider : NSObject
/**
 * 登录凭证构造器
 *
 * @param token 由iTA SDK授权后获得的token
 * @param appId  由项目id
 * @return 用于登录的凭证
 */
+ (AGCAuthCredential *)credentialWithToken:(NSString *)token appId:(NSString *)appId;
/**
 * 登录凭证构造器
 *
 * @param token 由iTA SDK授权后获得的token
 * @param appId 项目id
 * @param autoCreateUser 是否创建账户
 * @return 用于登录的凭证
 */
+ (AGCAuthCredential *)credentialWithToken:(NSString *)token
                                     appId:(NSString *)appId
                            autoCreateUser:(BOOL)autoCreateUser;

/**
 * 获取快速登录的appKey
 *
 * @return 对应的value值返回key
 * @return app对象
 */
+ (HMFTask<AGCQuickLoginKeyResult *> *) getQuickLoginAppKeyInstance:(AGCInstance *)app;
@end

NS_ASSUME_NONNULL_END
