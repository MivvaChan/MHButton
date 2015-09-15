//
//  ViewController.m
//  MHButton
//  https://github.com/huazaiCee/MHButton
//  Created by hua on 15/8/15.
//  Copyright (c) 2015年 MHCompany. All rights reserved.
//

#import "ViewController.h"
#import "MHToolbar.h"
#import "MHButton.h"

#define kToolbarHeight (60)

typedef NS_ENUM(NSInteger, MHTableViewType) {
    MHTableViewTypeButtonContentType,
    MHTableViewTypeButtonContentStyle
};

@interface ViewController () <MHToolbarDelegate, UIAlertViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) MHToolbar *toolbar;
@property (nonatomic, strong) MHToolbar *demoToolbar;
@property (nonatomic, strong) NSArray *buttonTypeArray;
@property (nonatomic, strong) NSArray *buttonStyleArray;
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) NSArray *demoTitlesArray;
@end

@implementation ViewController

- (NSArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = [NSArray arrayWithObjects:@"语音", @"视频", @"广告", @"百度", nil];
    }
    return _titlesArray;
}

- (NSArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [NSArray arrayWithObjects:@"consult_voice_icon_cur", @"consult_voice_icon_cur", @"consult_voice_icon_cur", @"consult_voice_icon_cur",nil];
    }
    return _imagesArray;
}

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

- (NSArray *)demoTitlesArray {
    if (!_demoTitlesArray) {
        _demoTitlesArray = [NSArray arrayWithObjects:@"按钮内容类型", @"按钮内容样式", nil];
    }
    return _demoTitlesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义按钮标签栏";
    [self setupToolbar];
    [self setupTableView];
}

- (void)setupToolbar {
    _toolbar = [self setupToolbarWithTitlesArray:self.titlesArray imagesArray:self.imagesArray y:120 contentType:MHButtonContentTypeDefault];
    _demoToolbar = [self setupToolbarWithTitlesArray:self.demoTitlesArray imagesArray:nil y:200 contentType:MHButtonContentTypeOnlyTitleLabel];
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
    myTableView.layer.borderWidth = 0.5f;
    [self.view addSubview:myTableView];
    return myTableView;
}

- (MHToolbar *)setupToolbarWithTitlesArray:(NSArray *)titlesArray imagesArray:(NSArray *)imagesArray y:(CGFloat)y contentType:(MHButtonContentType)contenType {
    MHToolbar *toolbar = [[MHToolbar alloc] initWithFrame:CGRectMake(0, y, KScreenW, kToolbarHeight) contentType:contenType contentStyle:MHButtonContentStyleDefault titleLabelScale:0.6f border:3 midBorder:1 titlesArray:titlesArray imagesArray:imagesArray];
    toolbar.delegate = self;
    toolbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolbar];
    return toolbar;
}

- (MHToolbar *)setupToolbarWithTitlesArray:(NSArray *)titlesArray imagesArray:(NSArray *)imagesArray y:(CGFloat)y contentStyle:(MHButtonContentStyle)contenStyle {
    MHToolbar *toolbar = [[MHToolbar alloc] initWithFrame:CGRectMake(0, y, KScreenW, kToolbarHeight) contentType:MHButtonContentTypeDefault contentStyle:contenStyle titleLabelScale:0.6f border:3 midBorder:1 titlesArray:titlesArray imagesArray:imagesArray];
    toolbar.delegate = self;
    toolbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolbar];
    return toolbar;
}

#pragma mark MHToolbarDelegate
- (void)toolbar:(MHToolbar *)toolbar didClickButton:(UIButton *)button {
    NSLog(@"第%ld个按钮被点击了", (long)button.tag);
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
        [self setupToolbarWithTitlesArray:self.titlesArray imagesArray:self.imagesArray y:120 contentType:indexPath.row];
    } else {
        [self setupToolbarWithTitlesArray:self.titlesArray imagesArray:self.imagesArray y:120 contentStyle:indexPath.row];
    }
}

@end
