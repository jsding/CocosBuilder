/*
 * CocosBuilder: http://www.cocosbuilder.org
 *
 * Copyright (c) 2012 Zynga Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "InspectorFontTTF.h"
#import "TexturePropertySetter.h"
#import "CCBGlobals.h"
#import "ResourceManager.h"
#import "ResourceManagerUtil.h"
#import "AppDelegate.h"
#import "RMResource.h"
#import "ResourceTypes.h"


@implementation InspectorFontTTF

- (void) willBeAdded
{
    // Setup menu
    NSString* fnt = [TexturePropertySetter ttfForNode:selection andProperty:propertyName];
    
    //if ([[fnt lowercaseString] hasSuffix:@".ttf"])
    //{
    //    fnt = [ResourceManagerUtil relativePathFromAbsolutePath:fnt];
    //}
    
    [ResourceManagerUtil populateFontTTFPopup:popup selectedFont:fnt target:self];
}

- (void) selectedResource:(id)sender
{
    [[AppDelegate appDelegate] saveUndoStateWillChangeProperty:propertyName];
    
    id item = [sender representedObject];
    
    // Fetch info about the font name or file
    NSString* fntFile = NULL;
    
    if ([item isKindOfClass:[RMResource class]])
    {
        // This is a file resource
        RMResource* res = item;
        
        if (res.type == kCCBResTypeTTF)
        {
            fntFile = [ResourceManagerUtil relativePathFromAbsolutePath:res.filePath];
            [ResourceManagerUtil setTitle:fntFile forPopup:popup forceMarker:YES];
        }
    }
    else if ([item isKindOfClass:[NSString class]])
    {
        // This is a system font
        fntFile = item;
        [ResourceManagerUtil setTitle:fntFile forPopup:popup forceMarker:YES];
    }
    
    // Set the property
    if (fntFile)
    {
        [TexturePropertySetter setTtfForNode:selection andProperty:propertyName withFont:fntFile];
        //[self setPropertyForSelection:fntFile];
    }
    
    [self updateAffectedProperties];
}

@end
