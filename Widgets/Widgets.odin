package widgets
import sdl "vendor:sdl2"
import sdl_ttf "vendor:sdl2/ttf"
import "core:fmt"
import img "vendor:sdl2/image"

@(private)
txtColor: sdl.Color

@(private)
text: cstring

@(private)
surface := sdl_ttf.RenderText_Solid(Font, text, txtColor)

@(private)
texture := sdl.CreateTextureFromSurface(renderer, surface)

@(private)
Fnt: cstring
@(private)
Font := sdl_ttf.OpenFont(Fnt, 80)

@(export)
NewText :: proc(font: cstring = Fnt, txt: cstring = text, color: sdl.Color = txtColor) {
    ttf := sdl_ttf.Init()
    assert(ttf != -1, sdl.GetErrorString())
    sdl_ttf.RenderUTF8_Blended(Font, txt, color)
    render: ^sdl.Renderer
    sdl.FreeSurface(surface)
}

WinTitle: cstring
XPos: i32
YPos: i32


@(private)
renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED)

@(private)
window := sdl.CreateWindow(
    WinTitle,
    sdl.WINDOWPOS_CENTERED,
    sdl.WINDOWPOS_CENTERED,
    XPos,
    YPos,
    window_flags,
)
@(private)
window_flags := sdl.WINDOW_RESIZABLE | sdl.WINDOW_SHOWN
@(export)
NewWindow :: proc(title: cstring = WinTitle, xAxis: i32 = XPos, yAxis: i32 = YPos) {
    
    /* window_flags := sdl.WINDOW_RESIZABLE | sdl.WINDOW_SHOWN */

    if (window == nil) {
        fmt.println("Failed to Open Window")
    }
    /* renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED) */
    event: sdl.Event
    assert(window != nil, sdl.GetErrorString())
    quit: bool = false
    loop : for {
        if sdl.PollEvent(&event) {
            if event.type == sdl.EventType.QUIT do quit = true
        }
        sdl.RenderCopy(renderer, texture, nil, nil)
        sdl.RenderPresent(renderer);

        sdl.Delay(1000) // Delay for 1 second
    }
    /* @(export=true)
    renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED) */
    sdl.RenderCopy(renderer, texture, nil, nil)
    sdl.RenderPresent(renderer);

    sdl_init := sdl.Init(sdl.INIT_EVERYTHING)
	defer sdl.Quit()
    NewWindow("Hi", 300, 300)
    /* @export renderer := sdl.CreateRenderer(window, -1, sdl.RENDERER_ACCELERATED) */
    assert(sdl_init == 0, sdl.GetErrorString())
}

@(export)
SetBgColor :: proc(color: sdl.Color = txtColor) {
    sdl.SetRenderDrawColor(renderer, color[0])
}

@(export)
NewImage :: proc(image: cstring) {
    img.Load(image)
    
}