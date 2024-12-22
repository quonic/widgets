package widgets

import "core:reflect"
import "core:slice"
import "core:strings"

// AddWidget adds a widget to the widgets list
AddTextBox :: proc(widget: ^TextBox) {
	widget.SetText = proc(textbox: ^TextBox, text: string) {
		textbox.Text = text
	}

	append(&textboxes, widget^)
}

// RemoveWidget removes a widget from the widgets list
RemoveWidget :: proc {
	RemoveWidget_by_id,
	RemoveWidget_by_name,
}

// RemoveWidget removes a widget from the widgets list by index
RemoveWidget_by_id :: proc(index: i32) {
	for widget, i in textboxes {
		if i32(i) == index {
			ordered_remove(&textboxes, i)
			return
		}
	}
}

// RemoveWidget removes a widget from the widgets list by name
RemoveWidget_by_name :: proc(name: string) -> ^TextBox {
	for &widget, i in textboxes {
		if widget.Name == name {
			ordered_remove(&textboxes, i)
			return &widget
		}
	}
	return nil
}
