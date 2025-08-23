package widgets

// Adds a Button to the widget manager
AddButton :: proc(button: Button) {
	append(&buttons, button)
}

// Adds multiple Buttons to the widget manager
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

// Adds a TextField to the widget manager
AddTextField :: proc(textfield: TextField) {
	append(&textfieldes, textfield)
}

// Adds multiple TextFieldes to the widget manager
AddTextFieldes :: proc(textfields: []TextField) {
	for &textfield in textfieldes {
		append(&textfieldes, textfield)
	}
}

// Removes a TextField from the widget manager
RemoveTextField :: proc {
	RemoveTextField_by_index,
	RemoveTextField_by_name,
}

// Removes a TextField from the widget manager by index
RemoveTextField_by_index :: proc(index: i32) {
	for _, i in textfieldes {
		if i32(i) == index {
			ordered_remove(&textfieldes, i)
			return
		}
	}
}

// Removes a TextField from the widget manager by name
RemoveTextField_by_name :: proc(name: string) {
	for &textfield, i in textfieldes {
		if textfield.Name == name {
			ordered_remove(&textfieldes, i)
			break
		}
	}
}

// Get the TextField from the widget manager
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

// Get the Button from the widget manager
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
