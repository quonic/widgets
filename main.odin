package main

import "core:fmt"
import "vendor:raylib"
import "widgets"

main :: proc() {
	raylib.InitWindow(800, 450, "Widgets - Example")

	// Move window to the center of the primary monitor. See monitor.odin
	SetWindowToPrimaryMonitor(true)

	// Define the TextField
	helloWorld := widgets.TextField {
		Name                         = "TextField1",
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
		EnterLoosesFocus             = true, // Enter key will cause TextField to loose focus
	}
	anotherWorld := widgets.TextField {
		Name                         = "TextField2",
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

	// Add the TextField to the widget manager
	// Old variables are not needed anymore
	widgets.AddTextField(helloWorld)
	widgets.AddTextField(anotherWorld)
	// Or add multiple TextFieldes at once
	// widgets.AddTextFieldes({helloWorld, anotherWorld})

	for raylib.WindowShouldClose() == false {
		raylib.BeginDrawing()
		raylib.ClearBackground(raylib.GRAY)

		// Draw the TextField
		widgets.DrawTextFieldes()

		// Get the text from the TextField by name:
		//   widgets.GetTextField("TextField1").Text
		raylib.DrawText(
			fmt.caprintf(widgets.GetTextField("TextField1").Text),
			10,
			60,
			20,
			raylib.BLACK,
		)

		raylib.EndDrawing()
	}

	raylib.CloseWindow()
}
