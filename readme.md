# Widgets

Custom widgets written in Odin for raylib.

![Widgets Screenshot](images/widgets.png)

## Available Widgets

* TextField - You can have more than one on screen!

## TODO

* [ ] Figure out other widgets to make
* [x] TextField
  * [x] Keyboard inputs
  * [x] Mouse position selection
  * [x] Text selection
  * [x] Copy and paste
  * [ ] Textured boarders and background
  * [ ] Alignment to a point: left, right, top, bottom
  * [ ] Width auto adjust: text longer than field, window shrinking/expanding, max width

## Example

```odin
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
        Name                         = "TextField",
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

    // Add the TextField to the widget manager
    widgets.AddTextField(&helloWorld)

    for raylib.WindowShouldClose() == false {
        raylib.BeginDrawing()
        raylib.ClearBackground(raylib.GRAY)

        // Draw the TextField
        widgets.DrawTextFieldes()

        raylib.EndDrawing()
    }

    raylib.CloseWindow()
}
```
