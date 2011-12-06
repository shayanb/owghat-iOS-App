//
//  MainViewController.h
//  owght_2
//
//  Created by Bashir on 12/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"



@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
    
      UIActivityIndicatorView * indc ; 
      UIWebView * wv ;
      UIPickerView * pkveiw ;
      NSArray * ctArr ; 
    
    
    
     NSString * currentCT ; 
    
    
    
     

}

@property (nonatomic,retain) IBOutlet UIActivityIndicatorView * indc ; 
@property (nonatomic,retain) IBOutlet UIWebView * wv ; 
@property (nonatomic,retain) IBOutlet UIPickerView * pkveiw ; 
@property (nonatomic,retain) NSArray * ctArr ; 
@property (nonatomic,retain) NSString * currentCT ; 

@property (nonatomic,retain) IBOutlet UIButton * button_1 ; 
@property (nonatomic,retain) IBOutlet UIButton * button_2 ; 
@property (nonatomic,retain) IBOutlet UIButton * button_3 ; 



- (IBAction)showInfo:(id)sender;
- (IBAction) ImgSave;
- (IBAction) SetDefCT;


- (void)GetDataByPr:(NSString * ) prName;

- (void)fadeWebViewIn;

@end
