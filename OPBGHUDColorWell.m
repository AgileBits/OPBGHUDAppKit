//
//  OPBGHUDColorWell.m
//  OPBGHUDAppKit
//
//  Created by BinaryGod on 8/9/08.
//
//  Copyright (c) 2008, Tim Davis (BinaryMethod.com, binary.god@gmail.com)
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//
//		Redistributions of source code must retain the above copyright notice, this
//	list of conditions and the following disclaimer.
//
//		Redistributions in binary form must reproduce the above copyright notice,
//	this list of conditions and the following disclaimer in the documentation and/or
//	other materials provided with the distribution.
//
//		Neither the name of the BinaryMethod.com nor the names of its contributors
//	may be used to endorse or promote products derived from this software without
//	specific prior written permission.
//
//	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS AS IS AND
//	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//	IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//	INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
//	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
//	OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
//	WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
//	POSSIBILITY OF SUCH DAMAGE.

#import "OPBGHUDColorWell.h"


@implementation OPBGHUDColorWell

@synthesize themeKey;

#pragma mark Init/Dealloc Methods

-(id)init {
	
	self = [super init];
	
	if(self) {
		
		self.themeKey = @"gradientTheme";
	}
	
	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder: aDecoder];
	
	if(self) {
		
		if([aDecoder containsValueForKey: @"themeKey"]) {
			
			self.themeKey = [aDecoder decodeObjectForKey: @"themeKey"];
		} else {
			
			self.themeKey = @"gradientTheme";
		}
	}
	
	[self setUseTransparentWell: [aDecoder decodeBoolForKey: @"useTransparentWell"]];
	
	return self;
}

-(void)encodeWithCoder: (NSCoder *)coder {
	
	[super encodeWithCoder: coder];
	
	[coder encodeObject: self.themeKey forKey: @"themeKey"];
	[coder encodeBool: [self useTransparentWell] forKey: @"useTransparentWell"];
}

-(void)dealloc {
	
	[super dealloc];
}

#pragma mark -
#pragma mark Drawing Methods

- (void)drawRect:(NSRect) rect {

	if([self isActive]) {
		
		[[[[OPBGThemeManager keyedManager] themeForKey: self.themeKey] highlightGradient] drawInRect: rect angle: 270];
	} else {
		
		[[[[OPBGThemeManager keyedManager] themeForKey: self.themeKey] normalGradient] drawInRect: rect angle: 270];
	}
	
	[[[[OPBGThemeManager keyedManager] themeForKey: self.themeKey] strokeColor] set];
	NSFrameRect(rect);
	
	[self drawWellInside: rect];
}

- (void)drawWellInside:(NSRect) rect {
	
	if([self isBordered]) {
	
		rect = NSInsetRect(rect, 5, 5);
	} else {
		
		rect = NSInsetRect(rect, 2, 2);
	}
	
	if([self useTransparentWell]) {
		
		NSColor *newColor = [NSColor colorWithDeviceRed: [[self color] redComponent]
												  green: [[self color] greenComponent]  
												   blue: [[self color] blueComponent] 
												  alpha: [[[OPBGThemeManager keyedManager] themeForKey: self.themeKey] alphaValue]];
		[newColor set];
	} else {
		
		[[self color] set];
	}

	NSRectFill(rect);
}

#pragma mark -
#pragma mark Helper Methods

- (BOOL)useTransparentWell {
	
	return useTransparentWell;
}

- (void)setUseTransparentWell:(BOOL) flag {
	
	useTransparentWell = flag;
	
	[self drawRect: [self frame]];
}

#pragma mark -

@end
