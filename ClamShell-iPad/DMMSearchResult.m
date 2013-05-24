//
//  DMMSearchResult.m
//  ClamShell
//
//  Created by Delisa Mason on 1/24/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import "DMMSearchResult.h"
#import "DMMTokenStore.h"

@interface DMMSearchResult ()

@property (nonatomic, strong) NSString *delimiter;

@end

@implementation DMMSearchResult

- (id) initWithName: (NSString *) name path: (NSString *) path type: (NSString *) type
{
  self = [super init];
  if (self) {
    self.name = name;
    self.type = type;

    NSString *itemPath = [NSString stringWithFormat:@"Contents/Resources/Documents/%@", path];
    self.path = [NSURL URLWithString:itemPath relativeToURL:[DMMTokenStore docSetDirectory]];

    [self parseHTMLFileName];
    [self parseImageFromType];
  }
  return self;
}

- (void) parseHTMLFileName
{
  NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:@"\\/([A-Za-z0-9]+)\\.html" options:NSRegularExpressionDotMatchesLineSeparators error:nil];

  NSString *pathString = [self.path absoluteString];
  NSArray *matches = [exp matchesInString:pathString
                                  options:0
                                    range:NSMakeRange(0, pathString.length)];

  if (matches.count > 0) {
    NSTextCheckingResult *match = matches[0];
    NSRange matchRange = [match rangeAtIndex:1];

    NSString *fileName = [pathString substringWithRange:matchRange];
    if (![fileName isEqualToString:self.name]) {
      self.htmlFileName = fileName;
    }
  }
}

- (void) parseImageFromType
{
  UIImage *image;
  if ([self.type isEqualToString:@"clm"]) {
    image = [UIImage imageNamed:@"script-attribute-m"];
  } else if ([self.type isEqualToString:@"clconst"]) {
    image = [UIImage imageNamed:@"script-block"];
  } else if ([self.type isEqualToString:@"intf"]) {
    image = [UIImage imageNamed:@"script-attribute-i"];
  } else {
    image = [UIImage imageNamed:@"script-attribute-c"];
  }
  self.icon = image;
}

@end
