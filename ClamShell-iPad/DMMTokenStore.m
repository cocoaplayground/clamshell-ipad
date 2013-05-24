//
//  DMMTokenStore.m
//  ClamShell
//
//  Created by Delisa Mason on 1/24/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import "DMMTokenStore.h"
#import "DMMSearchResult.h"
#import "DMMAppDelegate.h"
#import "FMDatabase.h"

static int MaxSearchResults    = 20;
static NSString *DATABASE_PATH = @"Contents/Resources/docSet.dsidx";
static NSString *DOCSET_NAME   = @"RubyMotion";

@implementation DMMTokenStore

+ (NSString *) databasePath
{
  return [[[self docSetDirectory] path] stringByAppendingPathComponent:DATABASE_PATH];
}

+ (NSURL *) docSetDirectory
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *fileName = [NSString stringWithFormat:@"%@.docset", DOCSET_NAME];
    return [NSURL fileURLWithPath:[path stringByAppendingPathComponent:fileName]];
}

+ (BOOL) hasDataStoreFile
{
  return [[NSFileManager defaultManager] fileExistsAtPath:[self databasePath]];
}

+ (NSArray *) tokensWithText:(NSString *) text {

  if (![self hasDataStoreFile]) [self copyDocSetIntoDocuments];
  if (![self hasDataStoreFile]) {
    NSLog(@"Data Store not found at %@", [self databasePath]);
    return @[];
  }

  NSString *query = @"SELECT name,type,path FROM searchIndex WHERE name LIKE :text ORDER BY name LIMIT :max COLLATE NOCASE";
  NSDictionary *params = @{@"text" : [NSString stringWithFormat:@"%@%%", text], @"max" : @(MaxSearchResults) };

  NSArray *results = [self runQuery:query withParameters:params];

  // Make a second pass with a slower query if no results are found
  if (results.count == 0) {
    params = @{@"text" : [NSString stringWithFormat:@"%%%@%%", text], @"max" : @(MaxSearchResults) };
    results = [self runQuery:query withParameters:params];
  }
  return results;
}

+ (NSArray *) runQuery:(NSString *) query withParameters:(NSDictionary *) params
{
  NSMutableArray *results = [NSMutableArray arrayWithCapacity:MaxSearchResults];
  FMDatabase *db = [FMDatabase databaseWithPath:[self databasePath]];
  db.logsErrors = YES;
  //  db.traceExecution = YES;
  if ([db open]) {
    FMResultSet *rows = [db executeQuery:query withParameterDictionary:params];
    while ([rows next]) {
      NSString *name = [rows stringForColumn:@"name"];
      NSString *type = [rows stringForColumn:@"type"];
      NSString *api  = [rows stringForColumn:@"path"];

      [results addObject:[[DMMSearchResult alloc] initWithName:name path:api type:type]];
    }
    [db close];
  }
  return results;
}


+ (void) copyDocSetIntoDocuments
{
  NSString *bundleDocSetPath = [[NSBundle mainBundle] pathForResource:DOCSET_NAME ofType:@"docset"];
  [[NSFileManager defaultManager] copyItemAtPath:bundleDocSetPath toPath:[[self docSetDirectory] path] error:nil];
}
@end
