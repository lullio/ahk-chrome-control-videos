#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
Menu, FileMenu, Add, &Open`tCtrl+O, MenuFileOpen 
Menu, FileMenu, Add, E&xit, MenuHandler

Menu, EditMenu, Add, Copy`tCtrl+C, MenuHandler
Menu, EditMenu, Add, Past`tCtrl+V, MenuHandler
Menu, EditMenu, Add ; with no more options, this is a seperator
Menu, EditMenu, Add, Delete`tDel, MenuHandler

Menu, HelpMenu, Add, &About, MenuHandler

; Attach the sub-menus that were created above.
Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, &Edit, :EditMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu
Gui, Menu, MyMenuBar ; Attach MyMenuBar to the GUI
gui, show, w400 h200
return

MenuHandler:
MsgBox, %A_ThisMenuItem%
return
MenuFileOpen:
MsgBox, Open Menu was clicked
return

GuiEscape:
GuiClose:
ExitApp
return