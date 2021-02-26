#import "UniversalGoogleAnalytics.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "GAIEcommerceFields.h"
#import "GAIEcommerceProduct.h"
#import "GAIEcommerceProductAction.h"
#import "GAIEcommercePromotion.h"
#import <React/RCTConvert.h>

@implementation UniversalGoogleAnalytics


RCT_EXTERN void RCTRegisterModule(Class);

+ (NSString *)moduleName {
    return @"UniversalGoogleAnalytics";
}

+ (void)load {
    RCTRegisterModule(self);
}

RCT_EXPORT_METHOD(setUniversalGAId:(NSString *)accountId)
{
    [GAI sharedInstance].dispatchInterval = 10;

    [[GAI sharedInstance] trackerWithTrackingId:accountId];

    [GAI sharedInstance].defaultTracker.allowIDFACollection = NO;
}

RCT_EXPORT_METHOD(trackEvent:(NSString *)category action:(NSString *)action label:(NSString *)label value:(nonnull NSNumber *)value)
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];

    [tracker send:[[GAIDictionaryBuilder
    createEventWithCategory: category
         action: action
          label: label
          value: value] build]];
}

RCT_EXPORT_METHOD(trackScreen:(NSString *)screenName)
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];

    [tracker set:kGAIScreenName value:screenName];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

RCT_EXPORT_METHOD(setCustomDimension:(nonnull NSNumber *)key value:(NSString *)value)
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];

    [tracker set:[GAIFields customDimensionForIndex:[key intValue]]
       value:value];
}

RCT_EXPORT_METHOD(trackProductImpression:(NSArray *)products list:(NSString *)list screenName:(NSString *)screenName)
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];

    GAIDictionaryBuilder *builder = nil;
    GAIEcommerceProduct *product = nil;

    if (products != nil) {
        builder = [GAIDictionaryBuilder createScreenView];

        for (NSDictionary *item in products) {

            product = [[GAIEcommerceProduct alloc] init];
            [product setId:[item objectForKey:@"id"]];
            [product setName:[item objectForKey:@"name"]];
            [product setCategory:[item objectForKey:@"category"]];
            [product setPrice:[item objectForKey:@"price"]];
            [product setPosition:[item objectForKey:@"position"]];
            [product setVariant:[item objectForKey:@"variant"]];

            [builder addProductImpression:product
                           impressionList:list
                         impressionSource:@""];
        }

        if (screenName != nil) {
            [tracker set:kGAIScreenName value:screenName];
        }
        [tracker send:[builder build]];
    }
}

RCT_EXPORT_METHOD(trackProductClick:(NSArray *)products list:(NSString *)list)
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];

    GAIDictionaryBuilder *builder = nil;
    GAIEcommerceProduct *product = nil;
    GAIEcommerceProductAction *action = nil;

    if (products != nil) {
        builder = [GAIDictionaryBuilder createEventWithCategory:@"Ecommerce"
                                                         action:@"Product Click"
                                                          label:nil
                                                          value:nil];

        action = [[GAIEcommerceProductAction alloc] init];
        [action setAction:kGAIPAClick];
        [action setProductActionList:list];
        [builder setProductAction:action];


        for (NSDictionary *item in products) {

            product = [[GAIEcommerceProduct alloc] init];
            [product setId:[item objectForKey:@"id"]];
            [product setName:[item objectForKey:@"name"]];
            [product setCategory:[item objectForKey:@"category"]];
            [product setPrice:[item objectForKey:@"price"]];
            [product setPosition:[item objectForKey:@"position"]];
            [product setVariant:[item objectForKey:@"variant"]];

            [builder addProduct:product];
        }

        [tracker send:[builder build]];
    }
}

RCT_EXPORT_METHOD(trackAddToCart:(NSArray *)products list:(NSString *)list)
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];

    GAIDictionaryBuilder *builder = nil;
    GAIEcommerceProduct *product = nil;
    GAIEcommerceProductAction *action = nil;

    if (products != nil) {
        builder = [GAIDictionaryBuilder createEventWithCategory:@"Ecommerce"
                                                         action:@"Add To Cart"
                                                          label:nil
                                                          value:nil];

        action = [[GAIEcommerceProductAction alloc] init];
        [action setAction:kGAIPAAdd];
        [action setProductActionList:list];
        [builder setProductAction:action];


        for (NSDictionary *item in products) {

            product = [[GAIEcommerceProduct alloc] init];
            [product setId:[item objectForKey:@"id"]];
            [product setName:[item objectForKey:@"name"]];
            [product setCategory:[item objectForKey:@"category"]];
            [product setPrice:[item objectForKey:@"price"]];
            [product setQuantity:[item objectForKey:@"quantity"]];
            [product setPosition:[item objectForKey:@"position"]];
            [product setVariant:[item objectForKey:@"variant"]];

            [builder addProduct:product];
        }

        [tracker send:[builder build]];
    }
}

RCT_EXPORT_METHOD(trackPurchase:(NSArray *)products list:(NSString *)list transactionId:(NSString *)transactionId 
    affiliation:(NSString *)affiliation couponCode:(NSString *)couponCode 
    revenue:(nonnull NSNumber *) revenue shipping:(nonnull NSNumber *) shipping tax:(nonnull NSNumber *) tax)
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];

    GAIDictionaryBuilder *builder = nil;
    GAIEcommerceProduct *product = nil;
    GAIEcommerceProductAction *action = nil;

    if (products != nil) {
        builder = [GAIDictionaryBuilder createEventWithCategory:@"Ecommerce"
                                                         action:@"Purchase"
                                                          label:nil
                                                          value:nil];
        action = [[GAIEcommerceProductAction alloc] init];
        [action setAction:kGAIPAPurchase];
        [action setTransactionId:transactionId];
        [action setRevenue:revenue];
        if (tax != nil) {
            [action setTax:tax];
        }
        if (affiliation != nil) {
            [action setAffiliation:affiliation];
        }
        if (shipping != nil) {
            [action setShipping:shipping];
        }
        if (couponCode != nil) {
            [action setCouponCode:couponCode];
        }
        [action setProductActionList:list];
        [builder setProductAction:action];

        for (NSDictionary *item in products) {

            product = [[GAIEcommerceProduct alloc] init];
            [product setId:[item objectForKey:@"id"]];
            [product setName:[item objectForKey:@"name"]];
            [product setCategory:[item objectForKey:@"category"]];
            [product setPrice:[item objectForKey:@"price"]];
            [product setQuantity:[item objectForKey:@"quantity"]];
            [product setPosition:[item objectForKey:@"position"]];
            [product setVariant:[item objectForKey:@"variant"]];

            [builder addProduct:product];
        }

        [tracker send:[builder build]];
    }
}

@end
