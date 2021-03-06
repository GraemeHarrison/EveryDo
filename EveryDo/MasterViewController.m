//
//  MasterViewController.m
//  EveryDo
//
//  Created by Graeme Harrison on 2016-01-26.
//  Copyright © 2016 Graeme Harrison. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Todo.h"
#import "ToDoCell.h"
#import "InputViewController.h"

@interface MasterViewController () <InputViewControllerDelegate>

@property NSMutableArray *objects;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self.tableView addGestureRecognizer:self.swipe];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.objects = [[NSMutableArray alloc] init];
    Todo *partyHard = [[Todo alloc] initWithTitle:@"Party Hard" description:@"Just party, dude" priorityNum:@"1"];
    Todo *installHotTub = [[Todo alloc] initWithTitle:@"Install Hot Tub" description:@"Buy a hot tub and install it" priorityNum:@"2"];
    Todo *bossOut = [[Todo alloc] initWithTitle:@"Boss Out" description:@"Be a boss and boss out" priorityNum:@"3"];
    Todo *flossOnEm = [[Todo alloc] initWithTitle:@"Floss On Em" description:@"Keep flossin' on 'em" priorityNum:@"4"];
    Todo *moonWalk = [[Todo alloc] initWithTitle:@"Moon Walk" description:@"Walk on the moon" priorityNum:@"5"];
    Todo *walkDog = [[Todo alloc] initWithTitle:@"Walk Dog" description:@"Let dog out for poop" priorityNum:@"6"];

    [self.objects addObjectsFromArray:@[partyHard, installHotTub, bossOut, flossOnEm, moonWalk, walkDog]];


}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    [self performSegueWithIdentifier:@"showInput" sender:self];
}

- (IBAction)swipeGesture:(UISwipeGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    Todo *selectedToDo = self.objects[indexPath.row];
    
    if (selectedToDo.isComplete == NO) {
        selectedToDo.isComplete = YES;
    } else {
        selectedToDo.isComplete = NO;
    }
    [UIView transitionWithView:self.tableView
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void)
     {
         [self.tableView reloadData];
     }
                    completion:nil];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        // Get the selected index path
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        // Use the selected index path to get the object it was displaying
        Todo *selectedToDo = self.objects[indexPath.row];
        // Pass that to our new view controller
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem: selectedToDo];
        controller.detailItem = selectedToDo;
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        
    } else if ([[segue identifier] isEqualToString:@"showInput"]) {
        InputViewController *controller = (InputViewController *) [segue destinationViewController];
        controller.delegate = self;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];

    NSSortDescriptor *completedSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"isComplete" ascending:YES];
    self.objects = [[self.objects sortedArrayUsingDescriptors:@[completedSortDescriptor] ]mutableCopy];
    
//    NSDate *object = self.objects[indexPath.row];
//    cell.textLabel.text = [object description];

    Todo *currentToDo = self.objects[indexPath.row];
    if (currentToDo.isComplete == NO) {
        cell.titleLabel.text = currentToDo.title;
        cell.descriptionLabel.text = currentToDo.descript;
        cell.priorityLabel.text = currentToDo.priorityNum;
//        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        NSDictionary* attributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
        NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:currentToDo.title attributes:attributes];
        cell.titleLabel.attributedText = attributedString;
    }
    return cell;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - Input View Controller Delegate

-(void)updateInputInfo:(Todo*)newToDoObject {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject: newToDoObject atIndex: 0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


// Manually rearrange rows
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    if (fromIndexPath != toIndexPath ) {
        Todo *toDoObject = [self.objects objectAtIndex:fromIndexPath.row];
        [self.objects removeObjectAtIndex:fromIndexPath.row];
        [self.objects insertObject:toDoObject atIndex:toIndexPath.row];
        [tableView reloadData];
    }
}

@end
