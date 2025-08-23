package widgets

import "vendor:raylib"

buttons: [dynamic]Button

Button :: struct {
	// The name of the widget for identification
	Name:            string,
	// The position and size
	Position:        raylib.Rectangle,
	// The background color
	BackGroundColor: raylib.Color,
	// The background color when pressed
	PressedColor:    raylib.Color,
	// The text
	Text:            string,
	// The font size
	FontSize:        f32,
	// The font spacing
	FontSpacing:     f32,
	// The font color
	FontColor:       raylib.Color,
	// The font
	Font:            raylib.Font,
	// Boarder color
	BorderColor:     raylib.Color,
	// Boarder thickness
	BorderThickness: f32,
	// The Visible
	Visible:         bool,
	// The Enabled
	Enabled:         bool,
	// The Hovered
	Hovered:         bool,
	// The Pressed
	Pressed:         bool,
}


// Adds a Button to the array
AddButton :: proc(button: Button) {
	append(&buttons, button)
}

// Adds multiple Buttons to the array
AddButtons :: proc(buttons_to_add: []Button) {
	for &button in buttons_to_add {
		append(&buttons, button)
	}
}

RemoveButton :: proc {
	RemoveButton_by_index,
	RemoveButton_by_name,
}

RemoveButton_by_index :: proc(index: i32) {
	for _, i in buttons {
		if i32(i) == index {
			ordered_remove(&buttons, i)
			return
		}
	}
}

RemoveButton_by_name :: proc(name: string) {
	for &button, i in buttons {
		if button.Name == name {
			ordered_remove(&buttons, i)
			break
		}
	}
}

// Get the Button from the widget array
// This returns a pointer to the Button
GetButton :: proc {
	GetButton_by_index,
	GetButton_by_name,
}

GetPressedButtons :: proc {
	GetPressedButtons_by_index,
}

GetPressedButtons_by_index :: proc() -> (index: [dynamic]int) {
	for &button, i in buttons {
		if button.Pressed {
			append(&index, i)
		}
	}
	return
}

GetButton_by_index :: proc(id: int) -> ^Button {
	for &button, i in buttons {
		if i == id {
			return &buttons[i]
		}
	}
	return nil
}

GetButton_by_name :: proc(name: string) -> ^Button {
	for &button in buttons {
		if button.Name == name {
			return &button
		}
	}
	return nil
}
