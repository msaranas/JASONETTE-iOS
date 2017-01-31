//
//  JasonLogAction.m
//  Jasonette
//
//  Copyright © 2016 seletz. All rights reserved.
//

#include <asl.h>
#import "JasonPaymentAction.h"
#import "ModelManager.h"
@implementation JasonPaymentAction
/*- (void)info {
    if(self.options){
        NSString *message = self.options[@"text"];
        asl_log(NULL, NULL, ASL_LEVEL_INFO, "%s", [message UTF8String]);
    }
    [[Jason client] success];
}
- (void)debug {
    if(self.options){
        NSString *message = self.options[@"text"];
        asl_log(NULL, NULL, ASL_LEVEL_DEBUG, "%s", [message UTF8String]);
        NSLog(@"DEBUG: %@", message);
    }
    [[Jason client] success];
}
- (void)error {
    if(self.options){
        NSString *message = self.options[@"text"];
        asl_log(NULL, NULL, ASL_LEVEL_ERR, "%s", [message UTF8String]);
        NSLog(@"ERROR: %@", message);
    }
    [[Jason client] success];
}
*/

- (void)onPay {
    NSString *cuId=[Globals sharedInstance].gUser.CustomerId;//@"CU000420";
    // [Globals sharedInstance].gUser.CustomerId = cuId;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSString *timedate = [dateFormatter stringFromDate:[NSDate date]];
    NSString *orderid = [NSString stringWithFormat:@"%@-%@",cuId,timedate];
    
    
    // accessCode=@"AVXI67DJ58CE81IXEC";
    //cancelUrl=@"https://lynk.co.in/cportal/Lynkcca/ccavResponseHandlertest.php";
    //NSString *urlAsString = [NSString stringWithFormat:@"https://test.ccavenue.com/transaction/initTrans"];
    // int timestamp = [[NSDate date] timeIntervalSince1970];
    // NSString *orderid=[NSString stringWithFormat:@"%@-%i",[Globals sharedInstance].gUser.CustomerId,timestamp];
    NSDictionary *dic=@{@"Amount":@"1",
                        @"CustomerId":cuId,
                        @"OrderId":orderid,
                        @"TrackingId":@""};
    [ModelManager CreatePaymentGatewayRequest:(NSDictionary *)dic withSuccess:^(NSDictionary *dict) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CCWebViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"CCWebViewController"];
       
        
        controller.accessCode = @"AVXI67DJ58CE81IXEC";
        controller.merchantId = @"113552";
        controller.amount = @"1";
        controller.currency = @"INR";
        
        controller.orderId = orderid;
        
        controller.redirectUrl = @"https://lynk.co.in/cportal/Lynkcca/ccavResponseHandlertest.php";
        controller.cancelUrl = @"https://lynk.co.in/cportal/Lynkcca/ccavResponseHandlertest.php";
        controller.rsaKeyUrl = @"https://lynk.co.in/cportal/Lynkcca/GetRSAtest.php";
        
        
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [[Jason client] goview:controller];
        [[Jason client] success];
        
    } failure:^(NSString *err) {
        
    } ];
    
    
   
  
    
}
@end
