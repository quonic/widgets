package widgets

import "vendor:raylib"

textboxes: [dynamic]TextBox

TextBox :: struct {
	// The name of the widget for identification
	Name:                         string,
	// The position and size
	Position:                     raylib.Rectangle,
	// The background color
	BackGroundColor:              raylib.Color,
	// The Visible
	Visible:                      bool,
	// The Enabled
	Enabled:                      bool,
	// The Hovered
	Hovered:                      bool,
	// The Focused
	Focused:                      bool,
	// The text
	Text:                         string,
	// The font size
	FontSize:                     f32,
	// The font spacing
	FontSpacing:                  f32,
	// The font color
	FontColor:                    raylib.Color,
	// The font
	Font:                         raylib.Font,
	// Boarder color
	BorderColor:                  raylib.Color,
	// Boarder thickness
	BorderThickness:              f32,
	// The text padding
	TextPadding:                  f32,
	// The text cursor position
	TextCursor:                   i32,
	// The text cursor color
	CursorColor:                  raylib.Color,
	// The text selection start
	TextSelectionStart:           i32,
	// The text selection end
	TextSelectionEnd:             i32,
	// The text selection color
	TextSelectionColor:           raylib.Color,
	// The text selection background color
	TextSelectionBackgroundColor: raylib.Color,
	// The text selection active
	TextSelectionActive:          bool,
	// Enter Looses Focus
	EnterLoosesFocus:             bool,
}
