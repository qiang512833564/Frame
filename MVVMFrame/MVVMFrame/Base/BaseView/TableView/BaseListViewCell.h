//
//  BaseListViewCell.h
//  MVVMFrame
//
//  Created by lizhongqiang on 16/7/28.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListItemModel.h"

@interface BaseListViewCell : UITableViewCell

- (void)reloadCellWhenDataSource:(BaseListItemModel *)item;

@end
