//
//  FunctionsViewController.h
//  AwesomeVKClient
//
//  Created by Никита on 25/12/2018.
//  Copyright © 2018 Никита. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    __weak IBOutlet UITableView *tableView;
}

@end
