//
//  JasonTextfieldComponent.m
//  Jasonette
//
//  Copyright © 2016 gliechtenstein. All rights reserved.
//
#import "JasonTextfieldComponent.h"
#import "Globals.h"
#import "LYNK-Swift.h"
@implementation JasonTextfieldComponent
+ (UIView *)build: (AnimatedTextInput *)component withJSON: (NSDictionary *)json withOptions: (NSDictionary *)options{
    if(!component){
        CGRect frame = CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width, 50);
        //component = [[UITextField alloc] initWithFrame:frame];
        component=[[AnimatedTextInput alloc] initWithFrame:frame];
    }
    if(options && options[@"value"])
    {
        component.text = options[@"value"];
    } else if(json && json[@"value"]){
        component.text = json[@"value"];
    }
    
    if(json && json[@"inputtype"]){
        component.inputType=json[@"inputtype"];
    }

    
    component.delegate = [self self];
    
    if(json[@"name"]){
        component.stringTag = json[@"name"];
    }
    NSMutableDictionary *payload = [[NSMutableDictionary alloc] init];
    if(json[@"name"]){
        payload[@"name"] = json[@"name"];
    }
    if(json[@"action"]){
        payload[@"action"] = json[@"action"];
    }
    if(json[@"bindable"]){
        payload[@"bindable"] = json[@"bindable"];
    }
    
    component.payload = payload;
   // [component addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // 1. Apply Common Style
    [self stylize:json component:component];
    
    // 2. Custom Style
    NSDictionary *style = json[@"style"];
    if(style){
        if(style[@"secure"] && [style[@"secure"] boolValue]){
          //  ((AnimatedTextInput *)component).secureTextEntry = YES;
        } else {
          //  ((AnimatedTextInput *)component).secureTextEntry = NO;
        }
    }
    if(json[@"placeholder"]){
        UIColor *placeholder_color;
        NSString *placeholder_raw_str = json[@"placeholder"];
        
        // Color
        if(style[@"placeholder_color"]){
            placeholder_color = [JasonHelper colorwithHexString:style[@"placeholder_color"] alpha:1.0];
        } else {
            placeholder_color = [UIColor grayColor];
        }
        NSMutableAttributedString *placeholderStr = [[NSMutableAttributedString alloc] initWithString:placeholder_raw_str];
        [placeholderStr addAttribute:NSForegroundColorAttributeName value:placeholder_color range:NSMakeRange(0,placeholderStr.length)];
        
        // Font
        NSString *font = @"HelveticaNeue";
        if(style[@"font"]){
            font = style[@"font"];
        }
        CGFloat size = 14.0;
        if(style[@"size"]){
            size = [style[@"size"] floatValue];
        }
        UIFont *f = [UIFont fontWithName:font size:size];
        [placeholderStr addAttribute:NSFontAttributeName value:f range:NSMakeRange(0, placeholderStr.length)];
        
        
        component.placeHolderText = placeholder_raw_str;
        //component.type=[AnimatedTextInputT]
        //AnimatedTextInputFieldConfigurator
        if(json[@"bindable"])
        {
      //  [[[NSUserDefaults standardUserDefaults]
          [[[Globals sharedInstance].viewModel rac_valuesForKeyPath:json[@"bindable"] observer:(NSObject *)self] subscribeNext:^(id value) {
            // [component se
            [(AnimatedTextInput *)component setText:value];
        }];
        }
    }
    
    return component;
}
+(BOOL)textFieldShouldBeginEditing:(UITextField*)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"adjustViewForKeyboard" object:nil userInfo:@{@"view": textField}];
    return YES;
}
+ (void)textFieldDidEndEditing:(UITextField *)textField
                        reason:(UITextFieldDidEndEditingReason)reason
{
    switch (reason) {
        case 0:
            if(textField.payload && textField.payload[@"bindable"]){
                
                [[Globals sharedInstance].viewModel setValue:textField.text forKey:textField.payload[@"bindable"]];
            }
            break;
        case 1:
            if(textField.payload && textField.payload[@"bindable"]){
                
                [[Globals sharedInstance].viewModel setValue:textField.text forKey:textField.payload[@"bindable"]];
            }

            break;
        default:
            break;
    }
}
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}
+ (void)textFieldDidChange:(UITextField *)textField{
    if(textField.payload && textField.payload[@"name"]){
      [self updateForm:@{textField.payload[@"name"]: textField.text}];
    }
    if(textField.payload && textField.payload[@"action"]){
        [[Jason client] call:textField.payload[@"action"]];
    }
    
}
+(BOOL)animatedtextFieldShouldBeginEditing:(AnimatedTextInput*)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"adjustViewForKeyboard" object:nil userInfo:@{@"view": textField}];
    return YES;
}
+ (void)animatedtextFieldDidEndEditing:(AnimatedTextInput *)textField
                        reason:(UITextFieldDidEndEditingReason)reason
    {
        switch (reason) {
            case 0:
            if(textField.payload && textField.payload[@"bindable"]){
                
                [[Globals sharedInstance].viewModel setValue:textField.text forKey:textField.payload[@"bindable"]];
            }
            break;
            case 1:
            if(textField.payload && textField.payload[@"bindable"]){
                
                [[Globals sharedInstance].viewModel setValue:textField.text forKey:textField.payload[@"bindable"]];
            }
            
            break;
            default:
            break;
        }
    }
+ (BOOL)animatedTextInput:(AnimatedTextInput *)animatedTextInput shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}
+ (void)animatedtextFieldDidChange:(AnimatedTextInput *)textField{
    if(textField.payload && textField.payload[@"name"]){
        [self updateForm:@{textField.payload[@"name"]: textField.text}];
    }
    if(textField.payload && textField.payload[@"action"]){
        [[Jason client] call:textField.payload[@"action"]];
    }
    
}
@end
