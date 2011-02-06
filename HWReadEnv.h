//
//  HWReadEnv.h
//  GitKit
//
//  Created by Hugo Wetterberg on 2011-02-06.
//  Copyright 2011 Hugo Wetterberg. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HWReadEnv : NSObject

+(NSDictionary*)readEnvironment;
+(NSArray*)splitPath:(NSString*)path;

@end
