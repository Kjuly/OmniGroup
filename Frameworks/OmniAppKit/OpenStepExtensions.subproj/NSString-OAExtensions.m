// Copyright 1997-2005, 2007-2008, 2010-2011, 2013 Omni Development, Inc. All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.

#import <OmniAppKit/NSString-OAExtensions.h>

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <OmniBase/OmniBase.h>
#import <OmniFoundation/OmniFoundation.h>
#import <OmniAppKit/NSAttributedString-OAExtensions.h>
#import <OmniAppKit/OAApplication.h>

RCS_ID("$Id$")

@implementation NSString (OAExtensions)

+ (NSString *)stringForKeyEquivalent:(NSString *)equivalent andModifierMask:(NSUInteger)mask;
{
    NSString *fullString = [NSString commandKeyIndicatorString];

    if (mask & NSControlKeyMask)
        fullString = [[NSString controlKeyIndicatorString] stringByAppendingString:fullString];
    if (mask & NSAlternateKeyMask)
        fullString = [[NSString alternateKeyIndicatorString] stringByAppendingString:fullString];
    if (mask & NSShiftKeyMask)
        fullString = [[NSString shiftKeyIndicatorString] stringByAppendingString:fullString];

    fullString = [fullString stringByAppendingString:[equivalent uppercaseString]];
    return fullString;
}

// String drawing

- (void)drawWithFontAttributes:(NSDictionary *)attributes alignment:(NSTextAlignment)alignment verticallyCenter:(BOOL)verticallyCenter inRectangle:(NSRect)rectangle;
{
    NSAttributedString *attributedString;
    
    attributedString = [[NSAttributedString alloc] initWithString:self attributes:attributes];
    [attributedString drawInRectangle:rectangle alignment:alignment verticallyCentered:verticallyCenter];
    [attributedString release];
}

- (void)drawWithFont:(NSFont *)font color:(NSColor *)color alignment:(NSTextAlignment)alignment verticallyCenter:(BOOL)verticallyCenter inRectangle:(NSRect)rectangle;
{
    NSMutableDictionary *attributes;

    attributes = [[NSMutableDictionary alloc] initWithCapacity:2];
    if (font)
        [attributes setObject:font forKey:NSFontAttributeName];
    if (color)
        [attributes setObject:color forKey:NSForegroundColorAttributeName];

    [self drawWithFontAttributes:attributes alignment:alignment verticallyCenter:verticallyCenter inRectangle:rectangle];
    [attributes release];
}

- (void)drawWithFontAttributes:(NSDictionary *)attributes alignment:(NSTextAlignment)alignment rectangle:(NSRect)rectangle;
{
    [self drawWithFontAttributes:attributes alignment:alignment verticallyCenter:NO inRectangle:rectangle];
}

- (void)drawWithFont:(NSFont *)font color:(NSColor *)color alignment:(NSTextAlignment)alignment rectangle:(NSRect)rectangle;
{
    [self drawWithFont:font color:color alignment:alignment verticallyCenter:NO inRectangle:rectangle];
}

- (void)drawInRect:(NSRect)rectangle xOffset:(CGFloat)xOffset yOffset:(CGFloat)yOffset attributes:(NSDictionary *)attributes;
{
    rectangle.origin.x += xOffset;
    rectangle.origin.y += yOffset;
    [self drawInRect:rectangle withAttributes:attributes];
}

@end
