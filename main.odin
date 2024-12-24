package main

import "core:fmt"
import "vendor:raylib"
import "widgets"

main :: proc() {
	raylib.InitWindow(800, 450, "Widgets - Example")

	// Move window to the center of the primary monitor. See monitor.odin
	SetWindowToPrimaryMonitor(true)

	// Define the TextBox
	helloWorld := widgets.TextBox {
		Name                         = "TextBox1",
		Visible                      = true,
		Enabled                      = true,
		Position                     = raylib.Rectangle{10, 10, 200, 20},
		FontSize                     = 20,
		FontSpacing                  = 2,
		FontColor                    = raylib.BLACK,
		Font                         = raylib.GetFontDefault(),
		Text                         = "Hello, World!",
		BorderColor                  = raylib.BLACK,
		BackGroundColor              = raylib.WHITE,
		CursorColor                  = raylib.GRAY,
		BorderThickness              = 1.0,
		TextPadding                  = 2.0,
		TextSelectionColor           = raylib.BLACK,
		TextSelectionBackgroundColor = raylib.GRAY,
	}
	anotherWorld := widgets.TextBox {
		Name                         = "TextBox2",
		Visible                      = true,
		Enabled                      = true,
		Position                     = raylib.Rectangle{10, 30, 200, 20},
		FontSize                     = 20,
		FontSpacing                  = 2,
		FontColor                    = raylib.BLACK,
		Font                         = raylib.GetFontDefault(),
		Text                         = "In another world...",
		BorderColor                  = raylib.BLACK,
		BackGroundColor              = raylib.WHITE,
		CursorColor                  = raylib.GRAY,
		BorderThickness              = 1.0,
		TextPadding                  = 2.0,
		TextSelectionColor           = raylib.BLACK,
		TextSelectionBackgroundColor = raylib.GRAY,
	}

	// Add the TextBox to the widget manager
	// Old variables are not needed anymore
	widgets.AddTextBox(helloWorld)
	widgets.AddTextBox(anotherWorld)
	// Or add multiple TextBoxes at once
	// widgets.AddTextBoxes({helloWorld, anotherWorld})

	for raylib.WindowShouldClose() == false {
		raylib.BeginDrawing()
		raylib.ClearBackground(raylib.GRAY)

		// Draw the TextBox
		widgets.DrawTextBoxes()

		// Get the text from the TextBox by name:
		//   widgets.GetTextBox("TextBox1").Text
		raylib.DrawText(
			fmt.caprintf(widgets.GetTextBox("TextBox1").Text),
			10,
			60,
			20,
			raylib.BLACK,
		)

		raylib.EndDrawing()
	}

	raylib.CloseWindow()
}
