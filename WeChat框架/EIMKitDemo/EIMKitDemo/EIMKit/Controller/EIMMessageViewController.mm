//
//  EIMMessageViewController.m
//  EIMKitDemo
//
//  Created by everettjf on 16/6/19.
//  Copyright © 2016年 everettjf. All rights reserved.
//

#import "EIMMessageViewController.h"
#import "EIMMultiSelectTableViewCell.h"
#import "EIMMessageNodeData.h"
#import "EIMTextMessageNodeView.h"
#import "EIMImageMessageNodeView.h"
#import "EIMMessageManager.h"
#import "EIMUtility.h"
#import <vector>
#import <list>

@interface EIMMessageViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIView *_bottomView;
    UITextField *_inputView;
    
    NSMutableArray<EIMMessageNodeData*> *_messageNodeData;
    //NSMutableArray<Class> *_messageNodeClass;
    std::vector<Class> _messageNodeClass ;
}

@end

@implementation EIMMessageViewController

- (void)_initMessageNodeClass{
    _messageNodeClass.push_back([EIMImageMessageNodeView class]);
    _messageNodeClass.push_back([EIMTextMessageNodeView class]);
//    _messageNodeClass = [NSMutableArray new];
//    [_messageNodeClass addObject:EIMTextMessageNodeView.class];
//    [_messageNodeClass addObject:EIMImageMessageNodeView.class];
}

- (void)_initMessageNodeData{
    _messageNodeData = [NSMutableArray new];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initMessageNodeClass];
    [self _initMessageNodeData];
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40)];
    [self.view addSubview:_bottomView];
    
    {
        _inputView = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-100, 40)];
        _inputView.backgroundColor = [UIColor grayColor];
        [_bottomView addSubview:_inputView];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-100,0,100, 40)];
        [button setTitle:@"Send" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor greenColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(_addItemTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:button];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 40)
                                             style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[EIMMultiSelectTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_tableView];
    
    [_tableView reloadData];
    [self _scrollTableViewToBottom];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self initHistroyMessageNodeData];
}

- (void)_addItemTapped:(id)sender{
    static int i =0 ,j = 0;
    
    EIMMessageWrap *msg;
    if(++i % 2==0)
        msg = [EIMMessageWrap createText:++j %2==0 text:@"Helloooooooooooooooooooooooooooooooooooooooooo"];
    else
        msg = [EIMMessageWrap createImage:++j % 2 ==0 image:@"image"];
    
    [self addMessageNode:msg];
    
    [_tableView reloadData];
    [self _scrollTableViewToBottom];
}

- (void)_scrollTableViewToBottom{
    if(!_messageNodeData)return;
    if(_messageNodeData.count==0)return;
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messageNodeData.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _messageNodeData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EIMMultiSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    EIMMessageNodeData *node = [_messageNodeData objectAtIndex:indexPath.row];
    [cell.contentView addSubview:node.view];
    
//    [UIView performWithoutAnimation:^{
//    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    EIMMessageNodeData *node = [_messageNodeData objectAtIndex:indexPath.row];
    return node.cellHeight;
}



- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    id value = notification.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    NSInteger option = [value integerValue];
    [UIView setAnimationCurve:(UIViewAnimationCurve)option];
    
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self _setBottomOffset:height];
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
    
    [self _scrollTableViewToBottom];
}

- (void)keyboardWillHide:(NSNotification*)notification{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    
    id value = notification.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    NSInteger option = [value integerValue];
    [UIView setAnimationCurve:(UIViewAnimationCurve)option];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self _setBottomOffset:0];
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
    
    [self _scrollTableViewToBottom];
}

- (void)_setBottomOffset:(CGFloat)offset{
    _bottomView.frame = CGRectMake(0, self.view.bounds.size.height - 40 - offset, self.view.bounds.size.width, 40);
    _tableView.frame = CGRectMake(0, -offset, self.view.bounds.size.width, self.view.bounds.size.height - 40);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_inputView resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define TYPE 0

- (void)preCreateMessageContentNode:(EIMMessageNodeData*)nodeData{
    if(nodeData.view)
        return;
    
    std::vector<Class>::iterator it;
#if TYPE
    for ( auto &&cls : _messageNodeClass){
        /*
         这是C++11中的语法，即：Range-based for loop。其中counts应满足：begin(counts), end(counts)是合法的。
         因此，它等价于for(some_iterator p = begin(counts); p != end(counts); ++p)且some_type count = *p。
         另外还可以是for(auto& count : counts), for(auto&& count: counts)。它们的区别在于count是值还是引用。
         
         最后，在c++14中还允许for(count : counts)，等价于for(auto&& count: counts)。
         */
        if(![cls canCreateMessageNodeViewInstanceWithMessageWrap:nodeData.messageWrap])
            continue;
        
        nodeData.view = [[cls alloc]initWithMessageWrap:nodeData.messageWrap];
    }
#else
    for (it = _messageNodeClass.begin(); it != _messageNodeClass.end(); it++) {
        /*
         iterator是一种抽象，用来封装对数据结构的遍历操作。比如你可以在不用知道数据结构实现的情况下，
         调用iterator来遍历。这样，我们可以用同一函数来对不同的数据结构进行遍历，因为函数只操作迭代器，不与具体的数据结构直接耦合。
         */
        Class cls = *it;
        if(![cls canCreateMessageNodeViewInstanceWithMessageWrap:nodeData.messageWrap])
            continue;
        
        nodeData.view = [[cls alloc]initWithMessageWrap:nodeData.messageWrap];
    }
#endif
    if(!nodeData.view){
        //Default to Text
        nodeData.view = [[EIMTextMessageNodeView alloc]initWithMessageWrap:nodeData.messageWrap];
    }
    
    nodeData.cellHeight = nodeData.view.bounds.size.height;
}

- (void)addMessageNode:(EIMMessageWrap*)messageWrap{
    EIMMessageNodeData *node = [EIMMessageNodeData new];
    node.messageWrap = messageWrap;
    
    [self preCreateMessageContentNode:node];
    
    [_messageNodeData addObject:node];
}

- (void)initHistroyMessageNodeData{
    // Read from db
    NSArray<EIMMessageWrap*> *arr = [[EIMMessageManager manager]getMessageArray];
    for (EIMMessageWrap *msg in arr) {
        [self addMessageNode:msg];
    }
    
    [_tableView reloadData];
    [self _scrollTableViewToBottom];
}

@end
