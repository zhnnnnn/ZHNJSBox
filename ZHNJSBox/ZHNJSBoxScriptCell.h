//
//  ZHNJSBoxScriptCell.h
//  ZHNJSBox
//
//  Created by zhn on 2018/6/6.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZHNJSBoxScriptCellDelegate
- (void)ZHNJSBoxScriptCellSelectToRun:(NSString *)scriptName;
@end

@interface ZHNJSBoxScriptCell : UITableViewCell
+ (ZHNJSBoxScriptCell *)createCellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) NSString *scriptName;
@property (nonatomic, weak) id <ZHNJSBoxScriptCellDelegate> delegate;
@end
