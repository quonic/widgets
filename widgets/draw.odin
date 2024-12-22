package widgets

import "core:fmt"
import "core:strings"
import "core:unicode/utf8"
import "vendor:raylib"

DrawTextBoxes :: proc() {
	for &textbox in textboxes {
		DrawTextBox(&textbox)
	}
}

@(private)
DrawTextBox :: proc(textbox: ^TextBox) {
	if textbox.Enabled && textbox.Visible {
		raylib.BeginScissorMode(
			i32(textbox.Position.x),
			i32(textbox.Position.y),
			i32(textbox.Position.width),
			i32(textbox.Position.height),
		)
		defer raylib.EndScissorMode()
		// Check if the textbox is hovered
		if raylib.CheckCollisionPointRec(raylib.GetMousePosition(), textbox.Position) {
			textbox.Hovered = true
			raylib.SetMouseCursor(raylib.MouseCursor.IBEAM)
		} else {
			textbox.Hovered = false
			raylib.SetMouseCursor(raylib.MouseCursor.DEFAULT)
		}

		// Check if the textbox is focused
		if raylib.IsMouseButtonPressed(raylib.MouseButton.LEFT) {
			if raylib.CheckCollisionPointRec(raylib.GetMousePosition(), textbox.Position) {
				textbox.Focused = true
			} else {
				textbox.Focused = false

			}
		}

		// Check if the textbox is focused
		if textbox.Focused {

			if raylib.IsKeyPressed(raylib.KeyboardKey.BACKSPACE) {
				if len(textbox.Text) > 0 && textbox.TextCursor > 0 {
					first: string = textbox.Text[:textbox.TextCursor - 1]
					second: string = textbox.Text[textbox.TextCursor:]
					textbox.Text = strings.concatenate({first, second})
					if textbox.TextCursor > 0 {
						textbox.TextCursor -= 1
					}
				}
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.ENTER) && textbox.EnterLoosesFocus {
				textbox.Focused = false
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.ESCAPE) {
				textbox.Focused = false
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.LEFT) {
				if textbox.TextCursor > 0 {
					textbox.TextCursor -= 1
				}
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.RIGHT) {
				if textbox.TextCursor < i32(len(textbox.Text)) {
					textbox.TextCursor += 1
				}
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.HOME) {
				textbox.TextCursor = 0
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.END) {
				textbox.TextCursor = i32(len(textbox.Text))
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.DELETE) {
				if textbox.TextCursor < i32(len(textbox.Text)) {
					textbox.Text = fmt.aprintf(
						"%s%s",
						textbox.Text[:textbox.TextCursor],
						textbox.Text[textbox.TextCursor + 1:],
					)
				}
			}
			pressed := raylib.GetCharPressed()
			if pressed != 0 {
				first: string = textbox.Text[:textbox.TextCursor]
				second: string = textbox.Text[textbox.TextCursor:]
				b, w := utf8.encode_rune(pressed)
				char := string(b[:w])
				textbox.Text = strings.concatenate({first, char, second})
				textbox.TextCursor += 1
			}

			// Draw the TextBox
			raylib.DrawRectangleRec(textbox.Position, textbox.BackGroundColor)
			raylib.DrawRectangleLinesEx(
				textbox.Position,
				textbox.BorderThickness,
				textbox.BorderColor,
			)

			// Draw the text
			raylib.DrawTextEx(
				raylib.GetFontDefault(),
				strings.clone_to_cstring(textbox.Text),
				{
					textbox.Position.x + textbox.TextPadding,
					textbox.Position.y + textbox.TextPadding / 2,
				},
				textbox.FontSize,
				textbox.FontSpacing,
				raylib.Color{0, 0, 0, 255},
			)
			cursorPosRec := raylib.MeasureTextEx(
				raylib.GetFontDefault(),
				strings.clone_to_cstring(textbox.Text[:textbox.TextCursor]),
				textbox.FontSize,
				textbox.FontSpacing,
			)
			// Draw the cursor
			raylib.DrawLineEx(
				{
					textbox.Position.x +
					textbox.TextPadding +
					textbox.FontSpacing / 2 +
					cursorPosRec.x,
					textbox.Position.y + textbox.TextPadding / 2,
				},
				{
					textbox.Position.x +
					textbox.TextPadding +
					textbox.FontSpacing / 2 +
					cursorPosRec.x,
					textbox.Position.y + textbox.TextPadding / 2 + textbox.FontSize,
				},
				1,
				textbox.CursorColor,
			)
		} else {
			// Draw the TextBox
			raylib.DrawRectangleRec(textbox.Position, textbox.BackGroundColor)
			raylib.DrawRectangleLinesEx(
				textbox.Position,
				textbox.BorderThickness,
				textbox.BorderColor,
			)

			// Draw the text
			raylib.DrawTextEx(
				raylib.GetFontDefault(),
				strings.clone_to_cstring(textbox.Text),
				{
					textbox.Position.x + textbox.TextPadding,
					textbox.Position.y + textbox.TextPadding / 2,
				},
				textbox.FontSize,
				textbox.FontSpacing,
				raylib.Color{0, 0, 0, 255},
			)

			cursorPosRec := raylib.MeasureTextEx(
				raylib.GetFontDefault(),
				strings.clone_to_cstring(textbox.Text[:textbox.TextCursor]),
				textbox.FontSize,
				textbox.FontSpacing,
			)
			// Draw the cursor
			raylib.DrawLineEx(
				{
					textbox.Position.x +
					textbox.TextPadding +
					textbox.FontSpacing / 2 +
					cursorPosRec.x,
					textbox.Position.y + textbox.TextPadding / 2,
				},
				{
					textbox.Position.x +
					textbox.TextPadding +
					textbox.FontSpacing / 2 +
					cursorPosRec.x,
					textbox.Position.y + textbox.TextPadding / 2 + textbox.FontSize,
				},
				1,
				textbox.CursorColor,
			)
		}

	} else if !textbox.Enabled && textbox.Visible {
		raylib.DrawRectangleRec(textbox.Position, raylib.GRAY)
		raylib.DrawRectangleLinesEx(textbox.Position, textbox.BorderThickness, textbox.BorderColor)
		raylib.DrawTextEx(
			raylib.GetFontDefault(),
			strings.clone_to_cstring(textbox.Text),
			{
				textbox.Position.x + textbox.TextPadding,
				textbox.Position.y + textbox.TextPadding / 2,
			},
			textbox.FontSize,
			textbox.FontSpacing,
			raylib.Color{0, 0, 0, 255},
		)
	}
}
