//
//  ViewController.m
//  QrCode
//
//  Created by xiangxiong on 2017/7/21.
//  Copyright © 2017年 xiangxiong. All rights reserved.
//

#import "ViewController.h"
#import "BDQRCode.h"
#import "NSData+Utility.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *taxNumberField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *bankNameField;
@property (weak, nonatomic) IBOutlet UITextField *bankAccountField;
@property (nonatomic, strong) UILabel *crcCodeLabel;
@property (nonatomic, strong) UIImageView *qrImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 100, 40)];
    [btn setTitle:@"生成二维码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(qrCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, btn.center.y);
    self.crcCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+5, CGRectGetMinY(btn.frame)+10, 100, 20)];
    [self.view addSubview:self.crcCodeLabel];
    self.crcCodeLabel.font = [UIFont systemFontOfSize:14];
    self.nameField.text = @"小米科技有限责任公司";
    self.taxNumberField.text = @"91110108551385082Q";
    self.addressField.text = @"北京市海淀区清河中街68号华润五彩城购物中心二期13层";
    self.phoneField.text = @"60606666-1000";
    self.bankNameField.text = @"平安银行股份有限公司北京花园路支行";
    self.bankAccountField.text = @"11013089998601";

    self.qrImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.bankAccountField.frame)+20, 200, 200)];
    [self.view addSubview:self.qrImageView];
}
/**
 *  获得到的crc码是默认小写的，通过安卓端的发票助手1.0来验证发现crc码不管大小写都是可以验证通过的。
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)qrCodeAction:(id)sender
{
    NSString *companyQrCode = [NSString stringWithFormat:@"%@</>%@</>%@%@</>%@%@</>",self.nameField.text,self.taxNumberField.text,self.addressField.text,self.phoneField.text,self.bankNameField.text,self.bankAccountField.text];
    NSData *qrCodeData = [companyQrCode dataUsingEncoding:NSUTF8StringEncoding];
    NSString *crc = [qrCodeData getCrc16Stringssss:qrCodeData];
    self.crcCodeLabel.text = crc;
    
    NSString *allStringCode = [NSString stringWithFormat:@"%@%@",companyQrCode,crc];
    NSData *allData = [allStringCode dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    allStringCode = [allData base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
    
    NSString *qrCode = [NSString stringWithFormat:@"$01%@$",allStringCode];
    
    self.qrImageView.image = [BDQRCode generateWithLogoQRCodeDataString:qrCode logoImageName:@""];
    [self.nameField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//}
@end
