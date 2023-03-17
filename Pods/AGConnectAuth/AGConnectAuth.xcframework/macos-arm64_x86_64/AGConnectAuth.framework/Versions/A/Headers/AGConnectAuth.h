//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved
//

#ifndef AGCConnectAuth_H
#define AGCConnectAuth_H

#import "AGCAuth.h"
#import "AGCAuthCredential.h"
#import "AGCUser.h"
#import "AGCUserExtra.h"
#import "AGCVerifyCodeSettings.h"
#import "AGCAuthError.h"
#import "AGCProfileRequest.h"
#import "AGCSignInResult.h"
#import "AGCTokenSnapshot.h"
#import "AGCQuickLoginKeyResult.h"
#import "AGCEmailAuthProvider.h"
#import "AGCPhoneAuthProvider.h"
#import "AGCSelfBuildAuthProvider.h"
#import "AGCAppleIDAuthProvider.h"
#import "AGCQuickLoginAuthProvider.h"
#import "AGCTokenResult.h"
#if TARGET_OS_IPHONE
#import "AGCTwitterAuthProvider.h"
#import "AGCWeiXinAuthProvider.h"
#import "AGCWeiboAuthProvider.h"
#import "AGCFacebookAuthProvider.h"
#import "AGCQQAuthProvider.h"
#import "AGCGoogleAuthProvider.h"
#import "AGCQuickLoginAuthProvider.h"
#import "AGCAlipayAuthProvider.h""
#endif

#if TARGET_OS_IPHONE
#import "AGCAuthThirdPartyConfig.h"
#import "AGCAPIAuthProtocol.h"
#endif

#endif
