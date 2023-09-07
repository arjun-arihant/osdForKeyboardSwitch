Loop {
    SetTimer, CheckKeyboardLayout, 1000
    Sleep, 1000
}

CheckKeyboardLayout:
    PrevLayout := CurrentLayout
    CurrentLayout := GetKeyboardLayout()

    if (PrevLayout != CurrentLayout)
    {
        file := "switched.png"
        if !FileExist(file)
        {
            MsgBox, File not found: %file%
            Gui, Destroy
            return
        }
        ; Create a GUI window with transparency
        Gui, +LastFound +AlwaysOnTop -Caption +ToolWindow
        Gui, Color, 000000
        Gui, Add, Picture, xm ym BackgroundTrans vMyPicture, %file%
        WinSet, TransColor, FFFFFF 150
        Gui, Show, Center

        ; Sleep for 2 seconds
        Sleep, 100
        ; Clean up
        Gui, Destroy
    }
return

GetKeyboardLayout() {
    hwnd := DllCall("GetForegroundWindow")
    id := DllCall("GetWindowThreadProcessId", "UInt", hwnd, "UInt", 0)
    hkl := DllCall("GetKeyboardLayout", "UInt", id)
return hkl
}
