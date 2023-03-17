//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif
#import <AGConnectCore/AGConnectCore.h>
#import "AGCAuthCredential.h"
#import "AGCSignInResult.h"
#import "AGCTokenSnapshot.h"
#import "AGCUser.h"
#import "AGCVerifyCodeSettings.h"
NS_ASSUME_NONNULL_BEGIN
/**
 * 认证服务入口类
 */
@interface AGCAuth : NSObject

/**
 * 获取当前登录的用户信息，如果未登录则返回null
 */
@property(nonatomic, strong, nullable, readonly) AGCUser *currentUser;

/**
 * 获取默认配置的AGCAuth的实例
 *
 * @return AGCAuth实例
 */
+ (instancetype)getInstance NS_SWIFT_NAME(instance());

/**
 * 获取自定义配置的AGCAuth的实例
 *
 * @param app 自定义配置
 * @return AGCAuth实例
 */
+ (instancetype)getInstance:(AGCInstance *)app NS_SWIFT_NAME(instance(app:));

/**
 * 获取支持的第三方登录方式，需要配合聚合登录的第三方适配层使用
 *
 * @return 支持的AGCAuthProviderType的列表
 */
#if TARGET_OS_IPHONE
- (NSArray <NSNumber *> *)supportAuthProviders;
#endif
/**
 * 登录接口，通过第三方认证来登录AGConnect平台
 *
 * @param credential 第三方OAuth2认证的凭证，需要通过对应的AuthProvider去创建。
 * @return 登录结果异步任务, 在任务成功后通过getUser获取登录的用户信息。
 */
- (HMFTask<AGCSignInResult *> *)signIn:(AGCAuthCredential *)credential
    NS_SWIFT_NAME(signIn(credential:));

/**
 * 登录接口，仅支持第三方登录，需要配合聚合登录的第三方适配层使用
 * @param provider 第三方方式
 * @param controller 用于弹出第三方登录授权界面的控制器
 * @result 登录结果异步任务, 在任务成功后通过getUser获取登录的用户信息。
 */
#if TARGET_OS_IPHONE
- (HMFTask<AGCSignInResult *> *)signIn:(AGCAuthProviderType)provider controller:(UIViewController *)controller
    NS_SWIFT_NAME(signIn(provider:controller:));
#endif
/**
 * 匿名登录
 *
 * @return 登录结果异步任务, 在任务成功后通过<code>getUser</code>获取登录的用户信息。
 */
- (HMFTask<AGCSignInResult *> *)signInAnonymously;

/**
 * 在AGConnect服务器侧删除当前用户信息同时清除缓存信息
 * @return 删除结果异步任务, 
 */
- (HMFTask *)deleteUser;

/**
 * 登出接口
 * 退出登录状态，删除缓存数据
 */
- (void)signOut;

/**
 * 添加token变更监听，可以同时添加多个监听对象，监听回调在UI线程调用
 *
 * @param listener 监听者
 */
- (void)addTokenListener:(void (^)(AGCTokenSnapshot *tokenSnapshot))listener;

/**
 * 移除token变更监听
 *
 * @param listener 监听者
 */
- (void)removeTokenListener:(void (^)(AGCTokenSnapshot *tokenSnapshot))listener;
/**
 * 是否自动上传用户的aaId
 *
 * @param enable 用于开发者配置是否上传aaid
 */
-(void)setAutoCollectionAAID:(BOOL)enable;

/**
 * 获取是否自动上传用户的aaId的值
 *
 * 本地存储的是否自动上传aaId的值
 */
-(BOOL)isAutoCollectionAAID;

/**
 * 获取是Config
 *
 *
 */
-(AGCServicesConfig *)getConfig;

/**
 * 邮箱创建账户
 *
 * @param email 邮箱
 * @param password 密码
 * @param verifyCode 验证码
 * @return 登录结果异步任务, 在任务成功后通过<code>getUser</code>获取登录的用户信息。
 */
- (HMFTask<AGCSignInResult *> *)createUserWithEmail:(NSString *)email
                                           password:(NSString *_Nullable)password
                                         verifyCode:(NSString *)verifyCode;

/**
 * 手机创建账户
 *
 * @param countryCode 国家码
 * @param phoneNumber 手机号
 * @param password 密码
 * @param verifyCode 验证码
 * @return 登录结果异步任务, 在任务成功后通过<code>getUser</code>获取登录的用户信息。
 */
- (HMFTask<AGCSignInResult *> *)createUserWithCountryCode:(NSString *)countryCode
                                              phoneNumber:(NSString *)phoneNumber
                                                 password:(NSString *_Nullable)password
                                               verifyCode:(NSString *)verifyCode;

/**
 * 利用邮箱重置密码
 *
 * @param email 邮箱
 * @param password 新密码
 * @param verifyCode 邮箱获取的验证码
 * @return 重置结果异步任务, 在任务成功后通过signIn重新登录。
 */
- (HMFTask *)resetPasswordWithEmail:(NSString *)email
                        newPassword:(NSString *)password
                         verifyCode:(NSString *)verifyCode;

/**
 * 利用手机重置密码
 *
 * @param countryCode 国家码
 * @param phoneNumber 手机号
 * @param password 新密码
 * @param verifyCode 验证码
 * @return 重置结果异步任务, 在任务成功后通过signIn重新登录。
 */
- (HMFTask *)resetPasswordWithCountryCode:(NSString *)countryCode
                              phoneNumber:(NSString *)phoneNumber
                              newPassword:(NSString *)password
                               verifyCode:(NSString *)verifyCode;

/**
 * 手机申请验证码
 *
 * @param countryCode 国际区号
 * @param phoneNumber 手机号码
 * @param settings 验证码参数
 * @return 申请验证码异步任务
 */
- (HMFTask<AGCVerifyCodeResult *> *)requestVerifyCodeWithCountryCode:(NSString *)countryCode
                                                         phoneNumber:(NSString *)phoneNumber
                                                            settings:(AGCVerifyCodeSettings *)settings;

/**
 * 邮箱申请验证码
 *
 * @param email 邮箱地址
 * @param settings 验证码参数
 * @return 申请验证码异步任务
 */
- (HMFTask<AGCVerifyCodeResult *> *)requestVerifyCodeWithEmail:(NSString *)email
                                                      settings:(AGCVerifyCodeSettings *)settings;



@end

NS_ASSUME_NONNULL_END
