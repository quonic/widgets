package widgets

import "core:strings"
import "vendor:raylib"

SetClipboard :: proc(text: string) {
	raylib.SetClipboardText(strings.clone_to_cstring(text))
}

GetClipboard :: proc() -> string {
	return string(raylib.GetClipboardText())
}
