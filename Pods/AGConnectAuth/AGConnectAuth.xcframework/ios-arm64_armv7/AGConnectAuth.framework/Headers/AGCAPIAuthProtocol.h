//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved
//

#import <UIKit/UIKit.h>
#import <HMFoundation/HMFoundation.h>
#import "AGCAuthCredential.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AGCAPIAuthProtocol <NSObject>

- (HMFTask<AGCAuthCredential *> *)login:(UIViewController *)viewController;
- (void)logout;
- (AGCAuthProviderType)provider;

@end

NS_ASSUME_NONNULL_END
