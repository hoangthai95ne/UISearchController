//
//  TableViewController.m
//  SearchBar
//
//  Created by Hoàng Thái on 3/14/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

#import "TableViewController.h"
#import "Animal.h"

@interface TableViewController () <UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController* searchController;

@end

@implementation TableViewController {
    NSDictionary* dictAnimals;
    NSArray* arrayKeys;
    NSMutableArray* filteredNames;
    UITableViewController *searchResultsController;
    //    NSMutableArray *arrayDetailsViewController;
    NSMutableArray *filteredAnimals;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    filteredNames = [[NSMutableArray alloc] init];
    filteredAnimals = [[NSMutableArray alloc] init];
    //    arrayDetailsViewController = [[NSMutableArray alloc] init];
    
    searchResultsController = [[UITableViewController alloc] init];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
        
    self.definesPresentationContext = YES;
    
    Animal *Bear = [[Animal alloc] initWithName:@"Bear" photo:[UIImage imageNamed:[self getImageFileName:@"Bear"]]];
    Animal *BlackSwan = [[Animal alloc] initWithName:@"Black Swan" photo:[UIImage imageNamed:[self getImageFileName:@"Black Swan"]]];
    Animal *Buffalo = [[Animal alloc] initWithName:@"Buffalo" photo:[UIImage imageNamed:[self getImageFileName:@"Buffalo"]]];
    Animal *Camel = [[Animal alloc] initWithName:@"Camel" photo:[UIImage imageNamed:[self getImageFileName:@"Camel"]]];
    Animal *Cockatoo = [[Animal alloc] initWithName:@"Cockatoo" photo:[UIImage imageNamed:[self getImageFileName:@"Cockatoo"]]];
    Animal *Dog = [[Animal alloc] initWithName:@"Dog" photo:[UIImage imageNamed:[self getImageFileName:@"Dog"]]];
    Animal *Donkey = [[Animal alloc] initWithName:@"Donkey" photo:[UIImage imageNamed:[self getImageFileName:@"Donkey"]]];
    Animal *Emu = [[Animal alloc] initWithName:@"Emu" photo:[UIImage imageNamed:[self getImageFileName:@"Emu"]]];
    Animal *Giraffe = [[Animal alloc] initWithName:@"Giraffe" photo:[UIImage imageNamed:[self getImageFileName:@"Giraffe"]]];
    Animal *Hippopotamus = [[Animal alloc] initWithName:@"Hippopotamus" photo:[UIImage imageNamed:[self getImageFileName:@"Hippopotamus"]]];
    Animal *Koala = [[Animal alloc] initWithName:@"Koala" photo:[UIImage imageNamed:[self getImageFileName:@"Koala"]]];
    
    dictAnimals = @{@"B" : @[Bear, BlackSwan, Buffalo],
                    @"C" : @[Camel, Cockatoo],
                    @"D" : @[Dog, Donkey],
                    @"E" : @[Emu],
                    @"G" : @[Giraffe],
                    @"H" : @[Hippopotamus],
                    @"K" : @[Koala]};
    
    arrayKeys = [dictAnimals allKeys];
    arrayKeys = [arrayKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (NSString*) getImageFileName: (NSString*)string {
    NSString* fileName = string.lowercaseString;
    fileName = [fileName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    fileName = [fileName stringByAppendingString:@".jpg"];
    return fileName;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.searchController.searchBar.text.length > 0) {
        if (filteredNames.count > 0) {
            return 1;
        }
        else {
            return 0;
        }
    }
    return arrayKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.searchController.searchBar.text.length > 0) {
        if (filteredNames.count > 0) {
            return filteredNames.count;
        }
        else {
            return 0;
        }
    }
    
    NSArray *animalsInSection = dictAnimals[arrayKeys[section]];
    
    return animalsInSection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (self.searchController.searchBar.text.length > 0 && filteredNames.count > 0) {
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:filteredNames[indexPath.row]];
        NSRange range = [filteredNames[indexPath.row] rangeOfString:self.searchController.searchBar.text options:NSCaseInsensitiveSearch];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        
        cell.textLabel.attributedText = attributedString;
        cell.textLabel.text = filteredNames[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[self getImageFileName:filteredNames[indexPath.row]]];
        return cell;
    }
    
    cell.textLabel.attributedText = nil;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSArray *arrayAnimalsInSection = dictAnimals[arrayKeys[indexPath.section]];
    Animal *animalInSection = arrayAnimalsInSection[indexPath.row];
    cell.textLabel.text = animalInSection.name;
    cell.imageView.image = animalInSection.photo;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.searchController.searchBar.text.length > 0) {
        return nil;
    }
    return arrayKeys[section];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.searchController.searchBar.text.length > 0) {
        return nil;
    }
    return arrayKeys;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [filteredNames removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [c] %@", self.searchController.searchBar.text];
    
    for (NSString* key in arrayKeys) {
        NSArray* animals = dictAnimals[key];
        NSMutableArray* animalNames = [NSMutableArray new];
        for (int i = 0; i < animals.count; i++) {
            [animalNames addObject:((Animal*)animals[i]).name];
        }
        NSArray* matches = [animalNames filteredArrayUsingPredicate:predicate];
        [filteredNames addObjectsFromArray:matches];
    }
    
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.searchController.searchBar.text.length > 0) {
        if (filteredNames.count > 0) {
            //            return 1; -- 1 section
            NSString* animalName = filteredNames[indexPath.row];
            DetailsViewController* detail = [[DetailsViewController alloc] initWithImage:[UIImage imageNamed:[self getImageFileName:animalName]] andAnimalName:animalName];
            
            
            [self.navigationController pushViewController:detail animated:YES];
        }
    }else {
        NSArray *arrayAnimalsInSection = dictAnimals[arrayKeys[indexPath.section]];
        Animal *animalInSection = arrayAnimalsInSection[indexPath.row];
        animalInSection.detailViewController = [[DetailsViewController alloc] initWithImage:animalInSection.photo andAnimalName:animalInSection.name];
        [self.navigationController pushViewController:animalInSection.detailViewController animated:YES];
    }
}




/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
