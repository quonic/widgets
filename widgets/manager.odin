package widgets

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

GetTextField_by_index :: proc(id: i32) -> ^TextField {
	for &textfield, i in textfieldes {
		return &textfieldes[i]
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
