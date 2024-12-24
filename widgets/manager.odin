package widgets

// Adds a TextBox to the widget manager
AddTextBox :: proc(textbox: TextBox) {
	append(&textboxes, textbox)
}

// Adds multiple TextBoxes to the widget manager
AddTextBoxes :: proc(textboxs: []TextBox) {
	for &textbox in textboxes {
		append(&textboxes, textbox)
	}
}

// Removes a TextBox from the widget manager
RemoveTextBox :: proc {
	RemoveTextBox_by_index,
	RemoveTextBox_by_name,
}

// Removes a TextBox from the widget manager by index
RemoveTextBox_by_index :: proc(index: i32) {
	for _, i in textboxes {
		if i32(i) == index {
			ordered_remove(&textboxes, i)
			return
		}
	}
}

// Removes a TextBox from the widget manager by name
RemoveTextBox_by_name :: proc(name: string) {
	for &textbox, i in textboxes {
		if textbox.Name == name {
			ordered_remove(&textboxes, i)
			break
		}
	}
}

// Get the TextBox from the widget manager
// This returns a pointer to the TextBox
GetTextBox :: proc {
	GetTextBox_by_index,
	GetTextBox_by_name,
}

GetTextBox_by_index :: proc(id: i32) -> ^TextBox {
	for &textbox, i in textboxes {
		return &textboxes[i]
	}
	return nil
}

GetTextBox_by_name :: proc(name: string) -> ^TextBox {
	for &textbox in textboxes {
		if textbox.Name == name {
			return &textbox
		}
	}
	return nil
}
