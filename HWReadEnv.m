//
//  HWReadEnv.m
//  GitKit
//
//  Created by Hugo Wetterberg on 2011-02-06.
//  Copyright 2011 Hugo Wetterberg. All rights reserved.
//

#import "HWReadEnv.h"


@implementation HWReadEnv

+(NSDictionary*)readEnvironment {
    NSPipe *outPipe = [NSPipe pipe];
    NSFileHandle *outHandle = nil;
	NSPipe *inPipe = [NSPipe pipe];
    NSFileHandle* inHandle = nil;
    NSTask *task = [[NSTask alloc] init];
    NSData *result = nil;
    NSString *output = nil;
    NSArray *lines = nil;
    NSMutableDictionary *env = [[NSMutableDictionary alloc] init];
    // We're using a separator to safeguard against any output from profile files
    NSString *separator = @"---BEGIN-PRINTENV---";
    BOOL separatorFound = NO;
    NSString *line = nil;
    NSRange equalsRange;
    
    NSString *profileScript = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HWReadEnv" ofType:@"sh"] encoding:NSUTF8StringEncoding error:nil];
    
	[task setLaunchPath:@"/bin/bash"];
	[task setStandardOutput:outPipe];
	[task setStandardInput:inPipe];
	
    // Send our environment setup and reading script to bash stdin.
	inHandle = [inPipe fileHandleForWriting];
	[inHandle writeData:[profileScript dataUsingEncoding:NSUTF8StringEncoding]];
	[inHandle closeFile];
	
	[task launch];
	
    // Read bash output.
	outHandle = [outPipe fileHandleForReading];
	result = [outHandle readDataToEndOfFile];
    [outHandle closeFile];
    [task release];
    
	output = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    lines = [output componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]; 
	
    // Locate the separator and separate the subsequent strings to get a key & value.
    for (line in lines) {
        if (separatorFound) {
            equalsRange = [line rangeOfString:@"="];
            if (equalsRange.location != NSNotFound) {
                [env setObject:[line substringWithRange:NSMakeRange(equalsRange.location + 1, [line length] - equalsRange.location - 1)]
                        forKey:[line substringWithRange:NSMakeRange(0, equalsRange.location)]];
            }
        }
        separatorFound = separatorFound || [line isEqualToString:separator];
    }
    
    
    return [env autorelease];
}

+(NSArray*)splitPath:(NSString*)path {
    return [path componentsSeparatedByString:@":"];
}

@end
