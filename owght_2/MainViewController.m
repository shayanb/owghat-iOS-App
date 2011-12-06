//
//  MainViewController.m
//  owght_2
//
//  Created by Bashir on 12/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize pkveiw,ctArr ,currentCT, wv ,indc ;
@synthesize button_1,button_2,button_3 ;


NSString *const PPRWebViewControllerFadeIn  = @"PPRWebViewControllerFadeIn";
const float PPRWebViewControllerFadeDuration = 1;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
 
[super viewDidLoad];
   
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *DefCt = [prefs stringForKey:@"Def"];
    if (DefCt ==nil)
        DefCt = @"" ;
    
    
    //[self  GetDataByPr:@""] ;
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"city.plist"];
    NSDictionary *ctDict = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    NSArray * ct=  [ctDict objectForKey:@"Root"];
   
    
  
    self.ctArr =  ct ;  
    
    [self  GetDataByPr:DefCt];
    
// release ?? 
    
    
    
    
    
    
   

}



- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    controller.delegate = self;
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
    
    [controller release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pkview {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pkview numberOfRowsInComponent:(NSInteger)component {
    
    return [self.ctArr count] ; 
}

- (NSString *)pickerView:(UIPickerView *)pkview titleForRow:(NSInteger)row forComponent:(NSInteger)component {
   
   
    
    return [self.ctArr objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pkview didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
   NSString * itm =  (NSString *)  [ctArr objectAtIndex:row] ; 
    
    [self  GetDataByPr: itm] ;
    
    
    
    
    
}

- (void)GetDataByPr:(NSString * ) prName
{
    currentCT = prName ; 
    self.view.backgroundColor = [UIColor whiteColor];
    self.wv.alpha = 0.0;
    NSString * BaseUrl = @"http://www.owghat.com/owghat.png.aspx?Province=" ;
    NSString * prFinalUrl = [BaseUrl stringByAppendingString:prName];
    NSString * FinalUrl = [prFinalUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:FinalUrl];
    NSURLRequest * urReq = [NSURLRequest requestWithURL:url];
    
    [wv loadRequest:urReq];
    
    
    
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot connect to server" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
	[alert show];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[alert autorelease];
}


- (void)fadeWebViewIn {
    [UIView beginAnimations:PPRWebViewControllerFadeIn context:nil];
    [UIView setAnimationDuration:PPRWebViewControllerFadeDuration];
    self.wv.alpha = 1.0;
    self.view.backgroundColor = [UIColor blackColor] ;
    
    //button_1.alpha = 1 ;
    //button_2.alpha = 1 ;
    //button_3.alpha = 1 ;
    
    [UIView commitAnimations];    
}


- (void)webViewDidFinishLoad:(UIWebView *)wv {
    
    
    [self fadeWebViewIn];
    [indc stopAnimating];
    pkveiw.userInteractionEnabled = true ;
}


- (void)webViewDidStartLoad:(UIWebView *)wv {
    
    [indc startAnimating];    
    
    pkveiw.userInteractionEnabled = false ;
}


-(void) ImgSave
{
    
    
    UIImage *viewImage = nil ; 
    
    button_1.alpha = 0 ;
    button_2.alpha = 0 ;
    button_3.alpha = 0 ;
    
    UIGraphicsBeginImageContext(CGSizeMake(320, 240));
    {
        
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
	viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
	}
    UIGraphicsEndImageContext();
	UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
    button_1.alpha = 1 ;
    button_2.alpha = 1 ;
    button_3.alpha = 1 ;
    
    self.wv.alpha = 0.0 ;
    [self fadeWebViewIn] ;
    
}

-(void)SetDefCT
{

    
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:currentCT forKey:@"Def"];
    [prefs synchronize];
    
    
    
}


@end
