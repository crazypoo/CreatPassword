//
//  ViewController.m
//  CreatPassword
//
//  Created by crazypoo on 13-7-23.
//  Copyright (c) 2013年 crazypoo. All rights reserved.
//

#import "ViewController.h"
#import "GADBannerView.h"
#define RANDOM_SEED() srandom(time(NULL))
#define RANDOM_INT(__MIN__, __MAX__) ((__MIN__) + random() % ((__MAX__+1) - (__MIN__)))

@interface ViewController ()
@property (nonatomic, retain) UITextField *inputpasswordlenght;
@property (nonatomic, retain) UISwitch *showword;
@property (nonatomic, retain) UISwitch *wordlower;
@property (nonatomic, retain) UISwitch *worduper;
@property (nonatomic, retain) UISwitch *number;
@property (nonatomic, retain) UISwitch *punctuation;
@property (nonatomic, retain) UILabel *showpassword;
@property (nonatomic, retain) UILabel *showwords;
@property (nonatomic, retain) GADBannerView *banner;

@end

@implementation ViewController
@synthesize inputpasswordlenght = _inputpasswordlenght;
@synthesize showword = _showword;
@synthesize wordlower = _wordlower;
@synthesize worduper = _worduper;
@synthesize number = _number;
@synthesize punctuation = _punctuation;
@synthesize showpassword = _showpassword;
@synthesize showwords = _showwords;
@synthesize banner = _banner;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view, typically from a nib.
    UILabel *inputpassword = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 150, 20)];
    inputpassword.text = @"請輸入密碼長度";
    inputpassword.textColor = [UIColor blueColor];
    [self.view addSubview:inputpassword];
    
    _inputpasswordlenght = [[UITextField alloc] initWithFrame:CGRectMake(160, 30, 150, 20)];
    _inputpasswordlenght.text = @"8";
    _inputpasswordlenght.returnKeyType = UIReturnKeyDone;
    _inputpasswordlenght.delegate = self;
    _inputpasswordlenght.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.inputpasswordlenght];
    
    UILabel *show = [[UILabel alloc] initWithFrame:CGRectMake(10, 63, 150, 20)];
    show.text = @"顯示單詞";
    show.textColor = [UIColor blueColor];
    [self.view addSubview:show];
    
    _showword = [[UISwitch alloc] initWithFrame:CGRectMake(160, 60, 150, 10)];
    [self.view addSubview:self.showword];
    
    UILabel *lower = [[UILabel alloc] initWithFrame:CGRectMake(10, 96, 150, 20)];
    lower.text = @"字母小寫";
    lower.textColor = [UIColor blueColor];
    [self.view addSubview:lower];
    
    _wordlower = [[UISwitch alloc] initWithFrame:CGRectMake(160, 93, 150, 10)];
    [self.view addSubview:self.wordlower];
    
    UILabel *uper = [[UILabel alloc] initWithFrame:CGRectMake(10, 129, 150, 20)];
    uper.text = @"字母大寫";
    uper.textColor = [UIColor blueColor];
    [self.view addSubview:uper];
    
    _worduper = [[UISwitch alloc] initWithFrame:CGRectMake(160, 126, 150, 10)];
    [self.view addSubview:self.worduper];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(10, 162, 150, 20)];
    num.text = @"數字";
    num.textColor = [UIColor blueColor];
    [self.view addSubview:num];
    
    _number = [[UISwitch alloc] initWithFrame:CGRectMake(160, 159, 150, 10)];
    [self.view addSubview:self.number];

    UILabel *biaodian = [[UILabel alloc] initWithFrame:CGRectMake(10, 195, 150, 20)];
    biaodian.text = @"標點符號";
    biaodian.textColor = [UIColor blueColor];
    [self.view addSubview:biaodian];
    
    _punctuation = [[UISwitch alloc] initWithFrame:CGRectMake(160, 192, 150, 10)];
    [self.view addSubview:self.punctuation];
    
    UIButton *creatpassword = [UIButton buttonWithType:UIButtonTypeCustom];
    creatpassword.frame = CGRectMake(0 , 225, self.view.bounds.size.width, 40);
    [creatpassword setTitle:@"生成密碼" forState:UIControlStateNormal];
    [creatpassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [creatpassword setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [creatpassword setBackgroundColor:[UIColor blueColor]];
    [creatpassword addTarget:self action:@selector(creat:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creatpassword];
    
    _showpassword = [[UILabel alloc] initWithFrame:CGRectMake(0, 265, self.view.bounds.size.width, 30)];
    _showpassword.backgroundColor = [UIColor greenColor];
    _showpassword.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:self.showpassword];
    
    _showwords = [[UILabel alloc] initWithFrame:CGRectMake(0, 295, self.view.bounds.size.width, 79)];
    _showwords.backgroundColor = [UIColor brownColor];
    _showwords.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _showwords.layer.borderWidth = 1.0;
    _showwords.numberOfLines = 0;
    [self.view addSubview:self.showwords];
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake(0 , 374, self.view.bounds.size.width, 40);
    [share setTitle:@"分享密碼" forState:UIControlStateNormal];
    [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [share setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [share setBackgroundColor:[UIColor blueColor]];
    [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:share];
    
    _banner = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 414, 320, 50)];
    _banner.adUnitID = @"a1503661b65b289";
    _banner.rootViewController = self;
    [self.view addSubview:_banner];
    [_banner loadRequest:[GADRequest request]];
}
-(void)creat:(id)sender
{
    NSArray *keys = [NSArray arrayWithObjects:
                     @"a", @"b", @"c", @"d", @"e",
                     @"f", @"g", @"h", @"i", @"j",
                     @"k", @"l", @"m", @"n", @"o",
                     @"p", @"q", @"r", @"s", @"t",
                     @"u", @"v", @"w", @"x", @"y", @"z",
                     
                     @"A", @"B", @"C", @"D", @"E",
                     @"F", @"G", @"H", @"I", @"J",
                     @"K", @"L", @"M", @"N", @"O",
                     @"P", @"Q", @"R", @"S", @"T",
                     @"U", @"V", @"W", @"X", @"Y", @"Z",
                     
                     @"0", @"1", @"2", @"3", @"4", 
                     @"5", @"6", @"7", @"8", @"9",
                     
                     @"~", @"!", @"?", @"#", @"%", 
                     @"^", @"&", @"*", @"(", @")",nil];
    
    NSArray *objects = [NSArray arrayWithObjects:
                        @"aa", @"bb", @"cc", @"dd", @"ee",
                        @"ff", @"gg", @"hh", @"ii", @"jj",
                        @"kk", @"l", @"mm", @"nn", @"oo",
                        @"pp", @"qq", @"rr", @"ss", @"tt",
                        @"uu", @"vv", @"ww", @"xx", @"yy", @"zz",
						
                        @"AA", @"BB", @"CC", @"DD", @"EE",
                        @"FF", @"GG", @"HH", @"II", @"JJ",
                        @"KK", @"LL", @"MM", @"NN", @"OO",
                        @"PP", @"QQ", @"RR", @"SS", @"TT",
                        @"UU", @"VV", @"WW", @"XX", @"YY", @"ZZ",
						
                        @"Zero", @"One", @"Two", @"Three", @"Four",
                        @"Five", @"Six", @"Seven", @"Eight", @"Nine",
            
                        @"波浪", @"感嘆號", @"問號", @"井號", @"百分號",
                        @"上三角", @"and", @"星號", @"左括號", @"右括號",nil];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    NSInteger mypassswordlength = [self.inputpasswordlenght.text intValue];
    BOOL bShowPhonetics = self.showword.on;
	BOOL bIncludeLowerCase = self.wordlower.on;
	BOOL bIncludeUpperCase = self.worduper.on;
	BOOL bIncludeNumbers = self.number.on;
	BOOL bIncludePunctuation = self.punctuation.on;
    
    NSString* passwordText = @"";
	NSString* phoneticText = @"";
    
	NSString* lowercaseChars = @"abcdefghijklmnopqrstuvwxyz";
	NSString* uppercaseChars = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	NSString* numbersChars = @"0123456789";
	NSString* punctuationChars = @"~!?#%^&*()";
    
    RANDOM_SEED();
    
    if(!bIncludeLowerCase && !bIncludeUpperCase && !bIncludeNumbers && !bIncludePunctuation)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Opps!" message:@"生成不了，請重新選擇！"
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
		return;
	}
    
    NSString* passwordChars = @"";
	
	if(bIncludeLowerCase)
    {
		passwordChars = [NSString stringWithFormat:@"%@%@", passwordChars, lowercaseChars];
	}
	if(bIncludeUpperCase)
    {
		passwordChars = [NSString stringWithFormat:@"%@%@", passwordChars, uppercaseChars];
	}
	if(bIncludeNumbers)
    {
		passwordChars = [NSString stringWithFormat:@"%@%@", passwordChars, numbersChars];
	}
	if(bIncludePunctuation)
    {
		passwordChars = [NSString stringWithFormat:@"%@%@", passwordChars, punctuationChars];
    }
    for(NSInteger i=0; i<mypassswordlength; i++)
    {
		
		int index = RANDOM_INT(0, [passwordChars length]-1);
        
		NSRange range = NSMakeRange(index, 1);
		NSString *passwordChar = [passwordChars substringWithRange:range];
		
		passwordText = [NSString stringWithFormat:@"%@%@", passwordText, passwordChar];
		
		
		if(i>0)
			phoneticText = [NSString stringWithFormat:@"%@, %@", phoneticText, [dictionary valueForKey:passwordChar]];
		else
			phoneticText = [dictionary valueForKey:passwordChar];
	}
    self.showpassword.text = @"";
	self.showpassword.text = passwordText;
	self.showwords.text = @"";
    if(bShowPhonetics)
    {
		self.showwords.text = phoneticText;
    }
}

-(void)share:(id)sender
{
    NSArray *activityItems = [[NSArray alloc]initWithObjects:
                              @"密碼生成",
                              self.showpassword.text,@"weibo.com/273277355",nil];
    
    // 初始化一個UIActivityViewController
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:Nil];
    
    // 寫一個bolck，用於completionHandler初始化
    UIActivityViewControllerCompletionHandler myBlock = ^(NSString *activityType, BOOL completed)
    {
        if (completed)
        {
        }
        else
        {
        }
        [activityVC dismissViewControllerAnimated:YES completion:Nil];
    };
    
    // 初始化completionHandler，當post結束之後（無論是done還是cancell）該blog都會被調用
    activityVC.completionHandler = myBlock;
    
    // 以模擬方式展現出UIActivityViewController
    [self presentViewController:activityVC animated:YES completion:Nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.inputpasswordlenght resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
