//
//  InspectorStringSimple.h
//  CocosBuilder
//
//  Created by John Twigg on 2013-12-18.
//
//

#import "InspectorValue.h"

@interface InspectorStringSimple : InspectorValue<NSTextFieldDelegate>
@property (nonatomic) NSString * text;
@end
