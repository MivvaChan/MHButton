//
//  ViewController.m
//  MHButton
//
//  Created by hua on 15/8/15.
//  Copyright (c) 2015年 MHCompany. All rights reserved.
//

#import "ViewController.h"
#import "MHToolbar.h"
#import "MHButton.h"

#define kToolbarHeight (45)

typedef NS_ENUM(NSInteger, MHTableViewType) {
    MHTableViewTypeButtonContentType,
    MHTableViewTypeButtonContentStyle
};

typedef NS_ENUM(NSInteger, MHToolbarType) {
    MHToolbarTypeDefault,
    MHToolbarTypeClass
};

@interface ViewController () <MHToolbarDelegate, UIAlertViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) MHToolbar *toolbar;
@property (nonatomic, strong) MHToolbar *demoToolbar;
@property (nonatomic, strong) NSArray *buttonTypeArray;
@property (nonatomic, strong) NSArray *buttonStyleArray;
@end

@implementation ViewController

- (NSArray *)buttonTypeArray {
    if (!_buttonTypeArray) {
        _buttonTypeArray = [NSArray arrayWithObjects:@"图片和文字", @"文字", @"图片", nil];
    }
    return _buttonTypeArray;
}

- (NSArray *)buttonStyleArray {
    if (!_buttonStyleArray) {
        _buttonStyleArray = [NSArray arrayWithObjects:@"左图右字", @"左字右图", @"上图下字", @"上字下图", nil];
    }
    return _buttonStyleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义按钮工具条";
    self.view.backgroundColor = MHColor(121, 141, 116);
    [self setupToolbar];
    [self setupTableView];
}

- (void)setupToolbar {
    _toolbar = [self setupToolbarWithCount:4 y:120 contentType:MHButtonContentTypeDefault toolbarType:MHToolbarTypeDefault];
    _demoToolbar = [self setupToolbarWithCount:2 y:200 contentType:MHButtonContentTypeOnlyTitleLabel toolbarType:MHToolbarTypeClass];
    for (UIButton *btn in self.demoToolbar.subviews) {
        [btn setTitle:@"按钮内容类型" forState:UIControlStateNormal];
        if (btn.tag == 1) {
            [btn setTitle:@"按钮内容样式" forState:UIControlStateNormal];
        }
    }
}

- (void)setupTableView {
    [self setupTableViewWithX:_toolbar.frame.origin.x type:MHTableViewTypeButtonContentType];
    [self setupTableViewWithX:_toolbar.center.x type:MHTableViewTypeButtonContentStyle];
}

- (UITableView *)setupTableViewWithX:(CGFloat)x type:(MHTableViewType)tableViewType{
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_demoToolbar.frame), _toolbar.bounds.size.width/2, 120) style:UITableViewStylePlain];
    myTableView.tag = tableViewType;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.layer.borderColor = MHColor_(240).CGColor;
    myTableView.layer.borderWidth = 0.5f;
    [self.view addSubview:myTableView];
    return myTableView;
}

- (MHToolbar *)setupToolbarWithCount:(int)count y:(CGFloat)y contentType:(MHButtonContentType)contenType toolbarType:(MHToolbarType)toolbarType{
    MHToolbar *toolbar = [[MHToolbar alloc] initWithFrame:CGRectMake(0, y, KScreenW, kToolbarHeight) contentType:contenType contentStyle:MHButtonContentStyleDefault titleLabelScale:0.6f border:3 midBorder:1 tabCount:count];
    toolbar.delegate = self;
    toolbar.tag = toolbarType;
    toolbar.backgroundColor = MHColor_(250);
    [self.view addSubview:toolbar];
    return toolbar;
}

- (MHToolbar *)setupToolbarWithCount:(int)count y:(CGFloat)y contentStyle:(MHButtonContentStyle)contenStyle {
    MHToolbar *toolbar = [[MHToolbar alloc] initWithFrame:CGRectMake(0, y, KScreenW, kToolbarHeight) contentType:MHButtonContentTypeDefault contentStyle:contenStyle titleLabelScale:0.6f border:3 midBorder:1 tabCount:count];
    toolbar.delegate = self;
    toolbar.backgroundColor = MHColor_(250);
    [self.view addSubview:toolbar];
    return toolbar;
}

#pragma mark MHToolbarDelegate
- (void)toolbar:(MHToolbar *)toolbar didClickButton:(UIButton *)button {
    NSLog(@"第%ld个按钮被点击了", (long)button.tag);
    if (toolbar.tag == MHToolbarTypeDefault) {
        [self showAlert];
    }
}

- (void)showAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入要修改的标签个数" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *field = [alert textFieldAtIndex:0];
    field.keyboardType = UIKeyboardTypeNumberPad;
    [alert show];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (!buttonIndex) return;
    UITextField *field = [alertView textFieldAtIndex:0];
    if (![field.text intValue]) return;
    [self.toolbar removeFromSuperview];
    [self setupToolbarWithCount:[field.text intValue] y:120 contentType:MHButtonContentTypeDefault toolbarType:MHToolbarTypeDefault];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (tableView.tag == MHTableViewTypeButtonContentType) {
        cell.textLabel.text = self.buttonTypeArray[indexPath.row];
    } else {
        cell.textLabel.text = self.buttonStyleArray[indexPath.row];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == MHTableViewTypeButtonContentType) {
        return self.buttonTypeArray.count;
    } else {
        return self.buttonStyleArray.count;
    }
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == MHTableViewTypeButtonContentType) {
        [self setupToolbarWithCount:4 y:120 contentType:indexPath.row toolbarType:MHToolbarTypeDefault];
    } else {
        [self setupToolbarWithCount:4 y:120 contentStyle:indexPath.row];
    }
}

@end
