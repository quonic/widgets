package widgets

import "vendor:raylib"

textfieldes: [dynamic]TextField

TextField :: struct {
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

// Adds a TextField to the array
AddTextField :: proc(textfield: TextField) {
	append(&textfieldes, textfield)
}

// Adds multiple TextFieldes to the array
AddTextFieldes :: proc(textfields: []TextField) {
	for &textfield in textfieldes {
		append(&textfieldes, textfield)
	}
}

// Removes a TextField from the array
RemoveTextField :: proc {
	RemoveTextField_by_index,
	RemoveTextField_by_name,
}

// Removes a TextField from the array by index
RemoveTextField_by_index :: proc(index: i32) {
	for _, i in textfieldes {
		if i32(i) == index {
			ordered_remove(&textfieldes, i)
			return
		}
	}
}

// Removes a TextField from the array by name
RemoveTextField_by_name :: proc(name: string) {
	for &textfield, i in textfieldes {
		if textfield.Name == name {
			ordered_remove(&textfieldes, i)
			break
		}
	}
}

// Get the TextField from the array
// This returns a pointer to the TextField
GetTextField :: proc {
	GetTextField_by_index,
	GetTextField_by_name,
}

GetTextField_by_index :: proc(id: int) -> ^TextField {
	for &textfield, i in textfieldes {
		if i == id {
			return &textfieldes[i]
		}
	}
	return nil
}

GetTextField_by_name :: proc(name: string) -> ^TextField {
	for &textfield in textfieldes {
		if textfield.Name == name {
			return &textfield
		}
	}
	return nil
}
