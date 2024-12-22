# Widgets

Custom widgets written in Odin for raylib.

![Widgets Screenshot](images/widgets.png)

## Available Widgets

* TextBox - You can have more than one on screen!

## TODO

* [ ] Figure out other widgets to make
* [ ] Add text selection to TextBox
* [ ] Add copy and paste functionality to TextBox

## Example

```odin
package main

import "core:fmt"
import "vendor:raylib"
import "widgets"

main :: proc() {
    raylib.InitWindow(800, 450, "Widgets - Example")

    SetWindowToPrimaryMonitor(true)

    // Define the TextBox
    helloWorld := widgets.TextBox {
        Name                         = "TextBox",
        Visible                      = true,
        Enabled                      = true,
        Position                     = raylib.Rectangle{10, 10, 200, 20},
        FontSize                     = 18,
        FontSpacing                  = 2,
        FontColor                    = raylib.BLACK,
        Font                         = raylib.GetFontDefault(),
        Text                         = "Hello, World!",
        BorderColor                  = raylib.BLACK,
        BackGroundColor              = raylib.WHITE,
        CursorColor                  = raylib.GRAY,
        BorderThickness              = 1.0,
        TextPadding                  = 2.0,
    }

    // Add the TextBox to the widget manager
    widgets.AddTextBox(&helloWorld)

    for raylib.WindowShouldClose() == false {
        raylib.BeginDrawing()
        raylib.ClearBackground(raylib.GRAY)

        // Draw the TextBox
        widgets.DrawTextBoxes()

        raylib.EndDrawing()
    }

    raylib.CloseWindow()
}
```
