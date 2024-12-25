package widgets

import "core:fmt"
import "core:strings"
import "core:unicode/utf8"
import "vendor:raylib"

DrawTextFieldes :: proc() {
	for &textfield in textfieldes {
		DrawTextField(&textfield)
	}
}

@(private)
DrawTextField :: proc(textfield: ^TextField) {
	if textfield.Enabled && textfield.Visible {
		// Limit the drawing to the textfield
		raylib.BeginScissorMode(
			i32(textfield.Position.x),
			i32(textfield.Position.y),
			i32(textfield.Position.width),
			i32(textfield.Position.height),
		)
		defer raylib.EndScissorMode()

		// Check if the textfield is hovered
		if raylib.CheckCollisionPointRec(raylib.GetMousePosition(), textfield.Position) {
			textfield.Hovered = true
		} else {
			textfield.Hovered = false
		}
		// Check if the textfield is focused
		if raylib.IsMouseButtonPressed(raylib.MouseButton.LEFT) {
			if raylib.CheckCollisionPointRec(raylib.GetMousePosition(), textfield.Position) {
				textfield.Focused = true

				// Get the cursor position relitive to the text
				x := raylib.GetMousePosition().x - textfield.Position.x - textfield.TextPadding

				// Find the nearest x point inbetween characters
				for _, i in textfield.Text {
					after_x: f32 = textfield.Position.x - textfield.TextPadding

					cur_x :=
						raylib.MeasureTextEx(textfield.Font, strings.clone_to_cstring(textfield.Text[:i]), textfield.FontSize, textfield.FontSpacing).x

					if i < len(textfield.Text) {
						after_x =
							raylib.MeasureTextEx(textfield.Font, strings.clone_to_cstring(textfield.Text[:i + 1]), textfield.FontSize, textfield.FontSpacing).x
					}

					// Figure out the nearest point between the two characters
					if x > cur_x && x < after_x {
						if x - cur_x < after_x - x {
							textfield.TextCursor = i32(i)
							break
						} else {
							textfield.TextCursor = i32(i) + 1
							break
						}
					}

				}
			} else {
				textfield.Focused = false
			}
		}

		// Check if the textfield is focused
		if textfield.Focused {

			// Handle the keyboard inputs
			if raylib.IsKeyPressed(raylib.KeyboardKey.BACKSPACE) {
				if len(textfield.Text) > 0 && textfield.TextCursor > 0 {
					first: string = textfield.Text[:textfield.TextCursor - 1]
					second: string = textfield.Text[textfield.TextCursor:]
					textfield.Text = strings.concatenate({first, second})
					if textfield.TextCursor > 0 {
						textfield.TextCursor -= 1
					}
				}
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.ENTER) && textfield.EnterLoosesFocus {
				textfield.Focused = false
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.ESCAPE) {
				textfield.Focused = false
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.LEFT) {
				if textfield.TextCursor > 0 {
					textfield.TextCursor -= 1
				}
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.RIGHT) {
				if textfield.TextCursor < i32(len(textfield.Text)) {
					textfield.TextCursor += 1
				}
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.HOME) {
				textfield.TextCursor = 0
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.END) {
				textfield.TextCursor = i32(len(textfield.Text))
			}
			if raylib.IsKeyPressed(raylib.KeyboardKey.DELETE) {
				if textfield.TextCursor < i32(len(textfield.Text)) {
					textfield.Text = fmt.aprintf(
						"%s%s",
						textfield.Text[:textfield.TextCursor],
						textfield.Text[textfield.TextCursor + 1:],
					)
				}
			}

			// Handle the text input
			pressed := raylib.GetCharPressed()
			if pressed != 0 {
				first: string = textfield.Text[:textfield.TextCursor]
				second: string = textfield.Text[textfield.TextCursor:]
				b, w := utf8.encode_rune(pressed)
				char := string(b[:w])
				textfield.Text = strings.concatenate({first, char, second})
				textfield.TextCursor += 1
			}

			// Draw the TextField shape
			raylib.DrawRectangleRec(textfield.Position, textfield.BackGroundColor)
			raylib.DrawRectangleLinesEx(
				textfield.Position,
				textfield.BorderThickness,
				textfield.BorderColor,
			)

			// Draw the text
			raylib.DrawTextEx(
				raylib.GetFontDefault(),
				strings.clone_to_cstring(textfield.Text),
				{
					textfield.Position.x + textfield.TextPadding,
					textfield.Position.y + textfield.TextPadding / 2,
				},
				textfield.FontSize,
				textfield.FontSpacing,
				raylib.Color{0, 0, 0, 255},
			)

			// Set our cursor position on the screen
			cursor_x: f32
			if textfield.TextCursor < i32(len(textfield.Text)) {
				// Get the cursor position
				cursor_x =
					raylib.MeasureTextEx(textfield.Font, strings.clone_to_cstring(textfield.Text[:textfield.TextCursor]), textfield.FontSize, textfield.FontSpacing).x
			} else if textfield.TextCursor >= i32(len(textfield.Text)) {
				// Get the cursor position
				cursor_x =
					raylib.MeasureTextEx(textfield.Font, strings.clone_to_cstring(textfield.Text), textfield.FontSize, textfield.FontSpacing).x
			} else {
				cursor_x = 0
			}

			// Draw the cursor
			{
				cursor_x = cursor_x + 1
				// Draw top of the cusor line
				raylib.DrawLineEx(
					{
						textfield.Position.x +
						textfield.TextPadding +
						cursor_x -
						textfield.TextPadding -
						1,
						textfield.Position.y + textfield.TextPadding * 2,
					},
					{
						textfield.Position.x +
						textfield.TextPadding +
						cursor_x +
						textfield.TextPadding,
						textfield.Position.y + textfield.TextPadding * 2,
					},
					1,
					textfield.CursorColor,
				)
				// Draw the vertical line
				raylib.DrawLineEx(
					{
						textfield.Position.x + textfield.TextPadding + cursor_x,
						textfield.Position.y + textfield.TextPadding / 2 + textfield.TextPadding,
					},
					{
						textfield.Position.x + textfield.TextPadding + cursor_x,
						textfield.Position.y + textfield.FontSize - textfield.TextPadding,
					},
					1,
					textfield.CursorColor,
				)
				// Draw the bottom of the cursor line
				raylib.DrawLineEx(
					{
						textfield.Position.x +
						textfield.TextPadding +
						cursor_x -
						textfield.TextPadding -
						1,
						textfield.Position.y + textfield.FontSize - textfield.TextPadding,
					},
					{
						textfield.Position.x +
						textfield.TextPadding +
						cursor_x +
						textfield.TextPadding,
						textfield.Position.y + textfield.FontSize - textfield.TextPadding,
					},
					1,
					textfield.CursorColor,
				)
			}
		} else {
			// Draw the TextField
			raylib.DrawRectangleRec(textfield.Position, textfield.BackGroundColor)
			raylib.DrawRectangleLinesEx(
				textfield.Position,
				textfield.BorderThickness,
				textfield.BorderColor,
			)

			// Draw the text
			raylib.DrawTextEx(
				raylib.GetFontDefault(),
				strings.clone_to_cstring(textfield.Text),
				{
					textfield.Position.x + textfield.TextPadding,
					textfield.Position.y + textfield.TextPadding / 2,
				},
				textfield.FontSize,
				textfield.FontSpacing,
				raylib.Color{0, 0, 0, 255},
			)
		}

	} else if !textfield.Enabled && textfield.Visible {
		// Draw the TextField shape
		raylib.DrawRectangleRec(textfield.Position, raylib.GRAY)
		raylib.DrawRectangleLinesEx(
			textfield.Position,
			textfield.BorderThickness,
			textfield.BorderColor,
		)

		// Draw the text
		raylib.DrawTextEx(
			raylib.GetFontDefault(),
			strings.clone_to_cstring(textfield.Text),
			{
				textfield.Position.x + textfield.TextPadding,
				textfield.Position.y + textfield.TextPadding / 2,
			},
			textfield.FontSize,
			textfield.FontSpacing,
			raylib.Color{0, 0, 0, 255},
		)
	}
}
