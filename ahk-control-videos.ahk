#Include, <Default_Settings>
; #SingleInstance, force
; #Include, C:\Users\%A_UserName%\Downloads\Chrome.ahk
#Include, C:\Program Files\AutoHotkey\Lib\Chromev3.ahk

; if not A_IsAdmin
;    Run *RunAs "%A_ScriptFullPath%"

full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}

   ; Variables
   chPath := "C:\Program Files\Google\Chrome\Application\chrome.exe"
   IfNotExist, %chPath%
      chPath := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
   profileName := "C:\Users\felipe\Desktop\ChromeProfile"
   IfNotExist %profileName%
      profileName := "C:\Users\Felipe\Desktop\ChromeProfile"
   IfNotExist %profileName%
      profileName := "C:\Users\Estudos\Desktop\ChromeProfile"
   IfNotExist %profileName%
      profileName := "C:\Users\Estudos\AppData\Local\Google\Chrome\User Data"

/* ESTILO E ICONE DO SCRIPT
*/
Menu, Tray, Icon, C:\Windows\system32\shell32.dll,116 ;Set custom Script icon

DLLPath=C:\Users\%A_UserName%\Documents\Github\AHK\secondary-scripts\ahk-styles\styles\USkin.dll ;Location to the USkin.dll file
StylesPath=C:\Users\%A_UserName%\Documents\Github\AHK\secondary-scripts\ahk-styles\styles ;location where you saved the .msstyles files

; melhores dark: cosmo, lakrits
; melhores light: MacLion3, Milikymac, Panther, Milk, Luminous, fanta, invoice
SkinForm(DLLPath,Apply, StylesPath "\Panther.msstyles") ; cosmo. msstyles


	; Gosub, Gui
; SkinForm(DLLPath,"0", StylesPath . CurrentStyle)	

SkinForm(DLLPath,Param1 = "Apply", SkinName = ""){
	if(Param1 = Apply){
		DllCall("LoadLibrary", str, DLLPath)
		DllCall(DLLPath . "\USkinInit", Int,0, Int,0, AStr, SkinName)
	}else if(Param1 = 0){
		DllCall(DLLPath . "\USkinExit")
	}
}

/* SCRIPT COMEÇA AQUI
*/

Gui, Destroy
Gui,+AlwaysOnTop ; +Owner
gui, font, S11 ;Change font size to 12
/*
MENU BAR
*/
Menu, FileMenu, Add, &Novo Curso`tCtrl+N, MenuFileOpen 
Menu, FileMenu, Add, &Sair, MenuHandler

Menu, EditMenu, Add, Copy`tCtrl+C, MenuHandler
Menu, EditMenu, Add, Past`tCtrl+V, MenuHandler
Menu, EditMenu, Add ; with no more options, this is a seperator
Menu, EditMenu, Add, Delete`tDel, MenuHandler

Menu, HelpMenu, Add, &Sobre o programa, MenuHandler
Menu, HelpMenu, Add, &Desenvolvedor, MenuHandler

; Attach the sub-menus that were created above.
Menu, MyMenuBar, Add, &Arquivo, :FileMenu
Menu, MyMenuBar, Add, &Editar, :EditMenu
Menu, MyMenuBar, Add, &Ajuda, :HelpMenu
Gui, Menu, MyMenuBar ; Attach MyMenuBar to the GUI
/*
LINHA 1 - SEPARADO - PRINCIPAIS CURSOS
*/
; dropdown 1 - principais cursos
Gui Add, Text,section y+10 , Main Courses / Top Rated
Gui, Add, ComboBox, Multi x10 y+10 w510 vCurso gCursos hwndCursosIDMain, 

/*
COLUNA 1
*/
; dropdown 2 - web dev cursos
Gui Add, Text, section x10, Web Developer
Gui, Add, ComboBox, Multi vCursoWebDev gCursos hwndCursosIDDev w250, 
; dropdown 3 - Cursos Analytics
Gui Add, Text,, Analytics / Marketing
Gui, Add, ComboBox, Multi vCursoMkt gCursos w250 hwndCursosIDAll, 

/*
COLUNA 2
*/
; dropdown 4 - javascript cursos
Gui Add, Text, ys, JavaScript All
Gui, Add, ComboBox, Multi w250 vCursoJavaScript gCursos hwndCursosIDMkt, 
; dropdown 5 - sql banco de dados cursos
Gui Add, Text,, SQL
Gui, Add, ComboBox, Multi vCursoSQL gCursos hwndCursosIDOutros w250, 

/*
COLUNA 3
*/
; dropdown 4 - linux cursos
Gui Add, Text, , Linux Courses
Gui, Add, ComboBox , Multi w250 vCursoLinux gCursos hwndCursosIDMkt, 
; dropdown 5 - backend
Gui Add, Text, xs ys+112, Backend / Web Server
Gui, Add, ComboBox, Multi vCursoWebServer gCursos hwndCursosIDOutros w250, 

; gui, font, S7 ;Change font size to 12
; 2º dropdown js courses
Gui, Add, GroupBox, xs cBlack r13 w560, TODOS OS CURSOS
Gui Add, Text, yp+25 xp+11 center, Cursos em Andamento
Gui Font, S10

Gui Add, ComboBox, Multi xs+10 yp+20 w372 center vTemplateDimensoes hwndDimensoesID ,Versão 1 - Parâmetros de Elemento (pt-br-new)||Versão 2 - Parâmetros de Blog (en-us-old)|Versão 3 - Parâmetros Antigos Flow Step (pt-br-old)|Template Vazio
Gui Add, Button, x+20  w135 h24, Atualizar Tabela
Gui Font,

Gui Add, ListView, altsubmit vCursoDaLista gListaDeCursos w530 r10 xs+10 y+10 -readonly grid sort, Curso|URL|Categories|Provider|Notion|Length|Rating
; LV_Modify()
Gui Font, S6.5
Gui Add, Link, w120 y+3 xp+200 vTotalCursos center,

; CARREGAR OS DADOS DOS CURSOS DA PLANILHA ANTES DE EXIBIR A GUI, NÃO VAI TER DELAY
GoSub, getData

; Botões
gui, font, S11
gui, Add, Button, y+25 xs+15 w250 h35 gAbrirCurso Default, &Abrir Curso
gui, Add, Button, w150 h35 x+10 gAbrirNotion, &Abrir Notion
gui, Add, Button, w95 h35 x+10 gCancel Cancel, &Cancelar

; EXIBIR E ATIVAR GUI
GuiControl,Focus,Curso
Gui, Show,, Abrir Curso e Controlar Video - Felipe Lulio

; GoSub, controlVideos
; Ignorar o erro que o ahk dá e continuar executando o script
ComObjError(false)

; EXECUTAR LOGO AO ABRIR A GUI, PARA EU PODER USAR OS COMANDOS DE VÍDEO MESMO SEM SELECIONAR UM CURSO.
 ; se não encontrar aba chrome com remote debug
 if !(PageInst := Chrome.GetPageByURL(website, "contains"))
   {
      ; Sleep, 500
      ; aqui está o fix pra esperar a página carregar
      ; PageInst := Chrome.GetPageByURL(website, "contains")
      ; Sleep, 500
      /*
      SUPER IMPORTANTE, ATIVAR A TAB/PÁGINA, ACTIVATE, FOCUS
      */
      ; PageInst.Call("Page.bringToFront")
      ; GoSub, controlVideos
      Return
   }else{
      ; Gosub, controlVideos
      Return
   }
Return



/* TRATAMENTO DOS DROPDOWN, PARA QUANDO VC ESCREVER O NOME DO CURSO JÁ PREENCHER O CURSO AUTOMATICAMENTE NO DROPDOWN
*/
; RESOLVI CRIAR UMA FUNÇÃO PARA NÃO TER QUE DUPLICAR ESSE CÓDIGO VÁRIAS VEZES PARA OS DROPDOWNS
DropDownComplete(cursoID)
{
   ControlGetText, Eingabe,, ahk_id %cursoID%
   ControlGet, Liste, List, , , ahk_id %cursoID%
   ; msgbox %Liste%
   ; msgbox %Eingabe%
   ; If ( !GetKeyState("Delete") && !GetKeyState("BackSpace") && RegExMatch(Liste, "`nmi)^(www\.)?(\Q" . Eingabe . "\E.*)$", Match)) {
   If ( !GetKeyState("Delete") && !GetKeyState("BackSpace") && RegExMatch(Liste, "`nmi)^(\Q" . Eingabe . "\E.*)$", Match)) {
      ; msgbox %match%
      ; msgbox %match1% ; armazena o www.
      ; msgbox %match2% ; armazena o restante sem o www.
      ControlSetText, , %Match%, ahk_id %cursoID% ; insere o texto no combobox
      Selection := StrLen(Eingabe) | 0xFFFF0000 ; tamanho do texto do match
      ; msgbox %Selection%
      SendMessage, CB_SETEDITSEL := 0x142, , Selection, , ahk_id %cursoID% ; colocar o cursor do mouse selecionando o texto do match
   } Else {
      CheckDelKey = 0
      CheckBackspaceKey = 0
   }
   ; GuiControl,Focus,Curso
}

Cursos:
      ; Capturar qual o control que está ativo, com foco
      GuiControlGet, focused_control, Focus
      ; msgbox %focused_control%
      Switch focused_control
      {
      Case "Edit1":
         DropDownComplete(CursosIDMain)
      Case "Edit2":
         DropDownComplete(CursosIDDev)
      Case "Edit3":
         DropDownComplete(CursosIDAll)
      Case "Edit4":
         DropDownComplete(CursosIDMkt)
      Case "Edit5":
         DropDownComplete(CursosIDOutros)
      Default:
         Notify().AddWindow("Nenhum control da gui esta com foco",{Time:3000,Icon:238, Background:"0xFFFB03",Title:"ALERTA",TitleSize:15, Size:15, Color: "0x524D4D", TitleColor: "0x3E3E3E"},,"setPosBR")
      }
return


/* ABRIR AS ANOTAÇÕES DO NOTION E A PASTA DO PROJETO SE EXISTIR
*/
AbrirNotion:
   Gui, Submit, NoHide
   needle := "None"
   regexp := RegExMatch(Curso, needle)

   if(RegExMatch(curso, needle))
   {
      Notify().AddWindow("Para abrir a pasta de um projeto você precisa criar um projeto antes",{Time:3000,Icon:28,Background:"0x990000",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR") ;
   }else{
      ; CHAMAR O LABEL courseSelected
      ; Gosub, courseSelected
      if(A_UserName == "Felipe" || A_UserName == "estudos" || A_UserName == "Estudos")
         {
           user := A_UserName
           pass := "xrlo1010"
         }
       Else
         {
           user := "felipe.lullio@hotmail.com"
           pass := "XrLO1000@1010"
         }
       RunAs, %user%, %pass%
      ; Run, C:\Users\felipe\AppData\Local\Programs\Notion\Notion.exe 
      Run %ComSpec% /c C:\Users\felipe\AppData\Local\Programs\Notion\Notion.exe "%notion%", , Hide
      RunAs
      WinActivate, Notion
   }
return

AbrirCurso:
   Gui, Submit, NoHide
   Loop, Parse, CursoLinux, |
      {
          MsgBox Selection number %A_Index% is %A_LoopField%.
      }
   ComObjError(false)

   ; Variables
   chPath := "C:\Program Files\Google\Chrome\Application\chrome.exe"
   IfNotExist, %chPath%
      chPath := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
   profileName := "C:\Users\felipe\Desktop\ChromeProfile"
   IfNotExist %profileName%
      profileName := "C:\Users\Felipe\Desktop\ChromeProfile"
   IfNotExist %profileName%
      profileName := "C:\Users\Estudos\Desktop\ChromeProfile"
   IfNotExist %profileName%
      profileName := "C:\Users\Estudos\AppData\Local\Google\Chrome\User Data"

   ; CHAMAR O LABEL courseSelected
   ; Gosub, courseSelected
   if !(website == "none") AND !(Curso == "GTM1") AND !(Curso == "GTM2") AND !(Curso == "GA4") AND !(CursoMkt == "GTM1") AND !(CursoMkt == "GTM2") AND !(CursoMkt == "GA4") AND !(CursoAll == "GTM1") AND !(CursoAll == "GTM2") AND !(CursoAll == "GA4") AND !(CursoOutros == "GTM1") AND !(CursoOutros == "GTM2") AND !(CursoOutros == "GA4"){
      ; se não encontrar aba chrome com remote debug
      ; msgbox %TextoLinhaSelecionadaCurso%
      ; msgbox %TextoLinhaSelecionadaURL%     ; se não encontrar aba chrome com remote debug
      if !(PageInst := Chrome.GetPageByURL(TextoLinhaSelecionadaURL, "contains"))
      {
         ChromeInst := new Chrome(profileName,TextoLinhaSelecionadaURL,"--remote-debugging-port=9222 --remote-allow-origins=*",chPath)
         Notify().AddWindow("Não encontrei o site aberto no Chrome, Vou abrir pra você agora!",{Time:6000,Icon:28,Background:"0x900C3F",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
         Sleep, 500
         contador1 := 0
         while !(PageInst)
         {
            Sleep, 500
            Notify().AddWindow("procurando instância do chrome...!",{Time:6000,Icon:28,Background:"0x1100AA",Title:"ERRO!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
            PageInst := Chrome.GetPageByURL(TextoLinhaSelecionadaURL, "contains")
            contador1++
            if(contador1 >= 30){
               PageInst.Disconnect()
               break
            }
         }
      }
      Sleep, 500
      ; aqui está o fix pra esperar a página carregar
      PageInst := Chrome.GetPageByURL(TextoLinhaSelecionadaURL, "contains")
      Sleep, 500
     ; SUPER IMPORTANTE, ATIVAR A TAB/PÁGINA, ACTIVATE, FOCUS
      PageInst.Call("Page.bringToFront")
   
      /*
         CASO TENHA SLECIONADO UM CURSO LOCAL 
      */
   }else if(Curso == "GTM1" || CursoWebDev == "GTM1" || CursoAll == "GTM1" || CursoOutros == "GTM1" || CursoMkt == "GTM1"){
      Run vlc.exe "%gtm1Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
      Run %gtm1Folder%\PLAYLIST-COMPLETA-BEGGINER.xspf
   }else if(Curso == "GTM2" || CursoWebDev == "GTM2" || CursoAll == "GTM2" || CursoOutros == "GTM2" || CursoMkt == "GTM2"){
      Run vlc.exe "%gtm2Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
      Run %gtm2Folder%\PLAYLIST-COMPLETA-ADVANCED.xspf
   }else if(Curso == "GA4" || CursoWebDev == "GA4" || CursoAll == "GA4" || CursoOutros == "GA4" || CursoMkt == "GA4"){
      Run vlc.exe "%GA4Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
      Run %GA4Folder%\PLAYLIST-COMPLETA-GA4.xspf
   }else{
      Notify().AddWindow("Nenhum curso válido foi selecionado!",{Time:6000,Icon:28,Background:"0x990000",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
      PageInst.Disconnect()
   }
   ; GoSub, firstStep
   ; PageInst.Disconnect()

   Gui Submit, NoHide

   ComObjError(false)
   /*
   CAPTURAR LINHA SELECINADA NA LISTVIEW DA GUI DO AHK
   */
   NumeroLinhaSelecionada := LV_GetNext()
   ; texto selecionado na coluna 1 (nome do curso)
   LV_GetText(TextoLinhaSelecionadaCurso, NumeroLinhaSelecionada, 1) 
   ; texto selecionado na coluna 2 (url do curso)
   LV_GetText(TextoLinhaSelecionadaURL, NumeroLinhaSelecionada, 2) 

   ; Variables
   chPath := "C:\Program Files\Google\Chrome\Application\chrome.exe"
   IfNotExist, %chPath%
      chPath := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
   profileName := "C:\Users\felipe\Desktop\ChromeProfile"
   IfNotExist %profileName%
      profileName := "C:\Users\Felipe\Desktop\ChromeProfile"
   IfNotExist %profileName%
      profileName := "C:\Users\Estudos\Desktop\ChromeProfile"
   IfNotExist %profileName%
      profileName := "C:\Users\Estudos\AppData\Local\Google\Chrome\User Data"

   ; website := "udemy.com"
   ; if(Chrome.GetPageByURL(website, "contains")){
   ;    website := "udemy.com"
   ; }else{
   ;    website := "youtube.com"
   ; }

   ; msgbox % A_GuiEvent
   if(A_GuiEvent == "DoubleClick"){
   ; msgbox %TextoLinhaSelecionadaCurso%
   ; msgbox %TextoLinhaSelecionadaURL%
   if !(TextoLinhaSelecionadaCurso == "GTM1") AND !(TextoLinhaSelecionadaCurso == "GTM2") AND !(TextoLinhaSelecionadaCurso == "GA4"){      ; se não encontrar aba chrome com remote debug
      if !(PageInst := Chrome.GetPageByURL(TextoLinhaSelecionadaURL, "contains"))
      {
         ChromeInst := new Chrome(profileName,TextoLinhaSelecionadaURL,"--remote-debugging-port=9222 --remote-allow-origins=*",chPath)
         Notify().AddWindow("Não encontrei o site aberto no Chrome, Vou abrir pra você agora!",{Time:6000,Icon:28,Background:"0x900C3F",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
         Sleep, 500
         contador1 := 0
         while !(PageInst)
         {
            Sleep, 500
            Notify().AddWindow("procurando instância do chrome...!",{Time:6000,Icon:28,Background:"0x1100AA",Title:"ERRO!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
            PageInst := Chrome.GetPageByURL(TextoLinhaSelecionadaURL, "contains")
            contador1++
            if(contador1 >= 30){
               PageInst.Disconnect()
               break
            }
         }
      }
      Sleep, 500
      ; aqui está o fix pra esperar a página carregar
      PageInst := Chrome.GetPageByURL(TextoLinhaSelecionadaURL, "contains")
      Sleep, 500
     ; SUPER IMPORTANTE, ATIVAR A TAB/PÁGINA, ACTIVATE, FOCUS
      PageInst.Call("Page.bringToFront")
   
      /*
         CASO TENHA SLECIONADO UM CURSO LOCAL 
      */
      }else if(Curso == "GTM1" || CursoWebDev == "GTM1" || CursoAll == "GTM1" || CursoOutros == "GTM1" || CursoMkt == "GTM1"){
      gtm1Folder := "Y:\Season\Analyticsmania\Google Tag Manager Masterclass For Beginners 3.0"
      if !FileExist(gtm1Folder)
      {
       gtm1Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Google Tag Manager Masterclass For Beginners 3.0"
      }
      Run vlc.exe "%gtm1Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
      Run %gtm1Folder%\PLAYLIST-COMPLETA-BEGGINER.xspf
      }else if(Curso == "GTM2" || CursoWebDev == "GTM2" || CursoAll == "GTM2" || CursoOutros == "GTM2" || CursoMkt == "GTM2"){
      gtm2Folder := "Y:\Season\Analyticsmania\Intermediate Google Tag Manager Advanced Topics 2.0"
      if !FileExist(gtm2Folder)
      {
         gtm2Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Intermediate Google Tag Manager Advanced Topics 2.0"
      }
      Run vlc.exe "%gtm2Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
      Run %gtm2Folder%\PLAYLIST-COMPLETA-ADVANCED.xspf
      }else if(Curso == "GA4" || CursoWebDev == "GA4" || CursoAll == "GA4" || CursoOutros == "GA4" || CursoMkt == "GA4"){
      GA4Folder := "Y:\Season\Analyticsmania\Google Analytics 4 Course"
      if !FileExist(GA4Folder)
      {
      GA4Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Google Analytics 4 Course"
      }
      Run vlc.exe "%GA4Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
      Run %GA4Folder%\PLAYLIST-COMPLETA-GA4.xspf
      }else{
      Notify().AddWindow("Nenhum curso válido foi selecionado!",{Time:6000,Icon:28,Background:"0x990000",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
      PageInst.Disconnect()
      }
   }
Return

; CONTROL VIDEOS
controlVideos:

      alt & l:: ; pausar e play
      Process, Exist, vlc.exe
      if !pid := ErrorLevel
         {
            ; MÉTODO DE PAUSAR NO CHROME
            ; PAUSAR E PLAY VIDEO
            FileRead, javascriptPlay, control-video\pause-play-video.js
            ; PageInst.Call("Page.bringToFront")
            PageInst.Evaluate(javascriptPlay)
            Notify().AddWindow("O método de pausar foi usado no CHROME.",{Time:2000,Icon:131, Background:"0x1100AA",Title:"VLC Não está aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
            ; PageInst.Call("Page.bringToFront")
            ; WinActivate, Chrome
         }
      else if !WinActive("AHK_PID " pid)
         {
            ; Sleep, 400
            ; ControlSend,Qt5QWindowIcon7,{space},ahk_exe vlc.exe
            ; SetTitleMatchMode, 2
            ; #IfWinActive, VLC media player
            ;    Send, {Space} Return
            Sleep, 200
            ControlSend,,{space},ahk_exe vlc.exe
            Sleep, 400
            Notify().AddWindow("O método de pausar foi usado no VLC",{Time:2000,Icon:131, Background:"0x1100AA",Title:"VLC Está Aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
            ; MÉTODO DE PAUSAR NO VLC
            ; WinActivate, AHK_PID %pid%
            ; SetTitleMatchMode, 2
           
         }      
      Return

      Alt & =:: ; aumentar velocidade
      Process, Exist, vlc.exe
      if !pid := ErrorLevel
         {
            ; MÉTODO AUMENTAR VELOCIDADE
            ; AUMENTAR VELOCIDADE
            FileRead, javascriptSpeedPlus, control-video\speed-increase.js
            PageInst.Evaluate(javascriptSpeedPlus)
            Notify().AddWindow("O método de aumentar velocidade foi usado no CHROME.",{Time:1000,Icon:131, Background:"0x1100AA",Title:"VLC Não está aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
            ; PageInst.Call("Page.bringToFront")
            ; WinActivate, Chrome
         }
      else if !WinActive("AHK_PID " pid)
         {
            ; MÉTODO AUMENTAR VELOCIDADE NO VLC
            ; WinActivate, AHK_PID %pid%
            ControlSend,,{=},ahk_exe vlc.exe ;Send =
            SetTitleMatchMode, 2
            IfWinActive, Reprodutor de Mídias VLC
            Send, {=}
            Notify().AddWindow("O método de aumentar velocidade foi usado no VLC",{Time:1000,Icon:131, Background:"0x1100AA",Title:"VLC Está Aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
         }
      Return

      Alt & -:: ; diminuir velocidade
      Process, Exist, vlc.exe
      if !pid := ErrorLevel
         {
            ; MÉTODO DIMNIUIR VELOCIDADE
            ; DIMINUIR VELOCIDADE
            FileRead, javascriptSpeedMinus, control-video\speed-decrease.js
            videoSpeed := PageInst.Evaluate(javascriptSpeedMinus)
            Notify().AddWindow("O método de diminuir velocidade foi usado no CHROME.",{Time:1000,Icon:131, Background:"0x1100AA",Title:"VLC Não está aberto ",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
            ; PageInst.Call("Page.bringToFront")
         }
      else if !WinActive("AHK_PID " pid)
         {
            ; MÉTODO DIMNIUIR VELOCIDADE NO VLC
            ; WinActivate, AHK_PID %pid%
            ControlSend,,{-},ahk_exe vlc.exe ;Send -
            SetTitleMatchMode, 2
            IfWinActive, Reprodutor de Mídias VLC
            Send, {-}
            Notify().AddWindow("O método de diminuir velocidade foi usado no VLC",{Time:2000,Icon:131, Background:"0x1100AA",Title:"VLC Está Aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
         }
      Return

      Alt & Left:: ; voltar 3 segundos
      Process, Exist, vlc.exe
      if !pid := ErrorLevel
         {
            ; RETROCEDER O VIDEO
            ; REWIND VIDEO
            FileRead, javascriptMoveDown, control-video\video-rewind.js
            PageInst.Evaluate(javascriptMoveDown)
            Notify().AddWindow("O método de retroceder video foi usado no CHROME.",{Time:1000,Icon:131, Background:"0x1100AA",Title:"VLC Não está aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
            ; PageInst.Call("Page.bringToFront")
         }
      else if !WinActive("AHK_PID " pid)
         {
            ; RETROCEDER O VIDEO NO VLC
            ; SetKeyDelay, 0, 50
            ControlSend,,+{left},ahk_exe vlc.exe 
            Notify().AddWindow("O método de retroceder video foi usado no VLC",{Time:1000,Icon:131, Background:"0x1100AA",Title:"VLC Está Aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
         }
      Return

      Alt & Right:: ; avancar 3 segundos
      Process, Exist, vlc.exe
      if !pid := ErrorLevel
         {
            ; AVANÇAR O VIDEO
            ; FAST-FORWARD VIDEO
            FileRead, javascriptMoveUp, control-video\video-fast-forward.js
            PageInst.Evaluate(javascriptMoveUp)
            Notify().AddWindow("O método de avançar video foi usado no CHROME.",{Time:1000,Icon:131, Background:"0x1100AA",Title:"VLC Não está aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
            ; PageInst.Call("Page.bringToFront")
         }
      else if !WinActive("AHK_PID " pid)
         {
            ; AVANÇAR O VIDEO NO VLC
            ; SetKeyDelay, 0, 50
            ControlSend,,+{Right},ahk_exe vlc.exe 
            Notify().AddWindow("O método de avançar video foi usado no VLC",{Time:1000,Icon:131, Background:"0x1100AA",Title:"VLC Está Aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
         }
      Return

      Alt & End:: ; proximo video
      Process, Exist, vlc.exe
      if !pid := ErrorLevel
         {
            ; PULAR O VIDEO
            ; PRÓXIMO VÍDEO
            FileRead, javascriptNextVideo, control-video\go-next-video.js
            PageInst.Evaluate(javascriptNextVideo)
            Notify().AddWindow("O método de pular video foi usado no CHROME.",{Time:1000,Icon:131, Background:"0x1100AA",Title:"VLC Não está aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
            ; PageInst.Call("Page.bringToFront")
         }
      else if !WinActive("AHK_PID " pid)
         {
            ; PULAR O VIDEO NO VLC
            ; SetKeyDelay, 0, 50
            ControlSend,,{n},ahk_exe vlc.exe 
            Notify().AddWindow("O método de pular video foi usado no VLC",{Time:1000,Icon:131, Background:"0x1100AA",Title:"VLC Está Aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
         }
      Return

      Alt & Home:: ; video anterior
      Process, Exist, vlc.exe
      if !pid := ErrorLevel
         {
            ; PREVIOUS VIDEO
            ; VIDEO ANTERIOR
            FileRead, javascriptPreviousVideo, control-video\go-previous-video.js
            PageInst.Evaluate(javascriptPreviousVideo)
            Notify().AddWindow("O método de previous video foi usado no CHROME.",{Time:1000,Icon:131, Background:"0x1100AA",Title:"VLC Não está aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
            ; PageInst.Call("Page.bringToFront")
         }
      else if !WinActive("AHK_PID " pid)
         {
            ; PREVIOUS VIDEO NO VLC
            ; SetKeyDelay, 0, 50
            ControlSend,,{p},ahk_exe vlc.exe 
            Notify().AddWindow("O método de previous video foi usado no VLC",{Time:1000,Icon:131, Background:"0x1100AA",Title:"VLC Está Aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
         }
      Return

      Alt & k:: ; habilitar desabilitar legenda
      Process, Exist, vlc.exe
      if !pid := ErrorLevel
         {
            ; PREVIOUS VIDEO
            ; VIDEO ANTERIOR
            FileRead, javascriptLegendaVideo, control-video\legenda-video.js
            PageInst.Evaluate(javascriptLegendaVideo)
            Notify().AddWindow("O método de legenda video foi usado no CHROME",{Time:1000,Icon:131, Background:"0x1100AA",Title:"VLC Não está aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
            ; PageInst.Call("Page.bringToFront")
         }
      else if !WinActive("AHK_PID " pid)
         {
            ; PREVIOUS VIDEO NO VLC
            ; SetKeyDelay, 0, 50
            ControlSend,,{v},ahk_exe vlc.exe 
            Notify().AddWindow("O método de legenda video foi usado no VLC",{Time:1000,Icon:131, Background:"0x1100AA",Title:"VLC Está Aberto",TitleSize:8, Size:8, Color: "0xE7DBD4", TitleColor: "0xE3CFC4"},,"setPosBR")
         }
      Return
Return

getDataFromGoogleSheet(urlData){
   aspa =
   (
   "
   )
   ; https://stackoverflow.com/questions/33713084/download-link-for-google-spreadsheets-csv-export-with-multiple-sheets
   ; https://www.autohotkey.com/docs/v1/lib/URLDownloadToFile.htm
   whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
   whr.Open("GET",urlData, true)
   whr.Send()
   ; Using 'true' above and the call below allows the script to remain responsive.
   whr.WaitForResponse()
   googleSheetData := whr.ResponseText
   SemAspa := RegExReplace(googleSheetData, aspa , "")
   ;  msgbox %googleSheetData%
   ; Return SubStr(googleSheetData, 2,-1) ; remove o primeiro e último catactere (as aspas)
   Return googleSheetData
}

getData:
   aspa =
   (
   "
   )
   /*
      IMPORTANTE:
      A COLUNA E DA PLANILHA PRECISA TER UMA FÓRMULA PARA GERAR O ARRAY DOS DADOS
   */
   Gui Submit, NoHide

         urlData := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=A2:G63&sheet=Cursos"
         urlCourseName := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=A2:A68&sheet=Cursos"
         urlCourseURL := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=B2:B68&sheet=Cursos"
         urlCourseCategories := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=C2:C68&sheet=Cursos"
         urlCourseProvider := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=D2:D68&sheet=Cursos"
         urlCourseNotion := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=E2:E68&sheet=Cursos"
         urlCourseLength := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=F2:F68&sheet=Cursos"
         urlCourseRating := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=G2:G68&sheet=Cursos"

   ; todos os dados
   dataAllRows := getDataFromGoogleSheet(urlData)
   ; msgbox % dataAllRows

   Loop, parse, dataAllRows, `n,`r ; linha
      {
         LineNumber := A_Index
         LineContent := A_LoopField
         ; msgbox % LineContent := A_LoopField
         ; msgbox, % RegExReplace(StrSplit(A_LoopField,",")[1], aspa , "")
         Coluna1 := RegExReplace(StrSplit(A_LoopField,",")[1], aspa , "") ; 1 coluna courseName
         Coluna2 := RegExReplace(StrSplit(A_LoopField,",")[2], aspa , "") ; 2 coluna courseURL
         Coluna3 := RegExReplace(StrSplit(A_LoopField,",")[3], aspa , "") ; 3 coluna courseCategories
         Coluna4 := RegExReplace(StrSplit(A_LoopField,",")[4], aspa , "") ; 4 coluna courseProvider
         Coluna5 := RegExReplace(StrSplit(A_LoopField,",")[5], aspa , "") ; 5 coluna courseLength
         Coluna6 := RegExReplace(StrSplit(A_LoopField,",")[6], aspa , "") ; 6 coluna courseRating
         ; LV_Add("" , Coluna1, SubStr(Coluna2, 2,-1), SubStr(Coluna3, 2,-1), SubStr(Coluna4, 2,-1), SubStr(Coluna5, 2,-1)) ; serve para remover as aspas na frente e final         
         LV_Add("" , Coluna1, Coluna2, Coluna3, Coluna4, Coluna5, Coluna6)
         /*
            ORGANIZAR AS CATEGORIAS DOS CURSOS  / SALVAR TODOS OS CURSOS EM VARIÁVEIS COM BASE NA CATEOGIRA
            1. SE EXISTIR "SQL" na coluna 2 courseCategories Adicionar o nome do curso na variável ListSQLCourses
            2. ....
            nome do curso esta na coluna 1, ou seja [1] posição 1
            ; https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/edit#gid=0
         */
         ListAllCourses .= RegexReplace(StrSplit(A_LoopField,",")[1] "|", aspa, "") ; salvar todos os cursos
         If InStr(Coluna3, "sql")
            ListSQLCourses .= RegexReplace(StrSplit(A_LoopField,",")[1] "|", aspa, "")
         If InStr(Coluna3, "web-dev")
            ListWebDevCourses .= RegexReplace(StrSplit(A_LoopField,",")[1] "|", aspa, "")
         If InStr(Coluna3, "javascript") || If InStr(Coluna3, "js-frameworks") 
            ListJavaScriptCourses .= RegexReplace(StrSplit(A_LoopField, ",")[1] "|", aspa, "")
         If InStr(Coluna3, "analytics") || InStr(Coluna3, "ads") || InStr(Coluna3, "wordpress") 
            ListAnalyticsCourses .= RegexReplace(StrSplit(A_LoopField, ",")[1] "|", aspa, "")
         If InStr(Coluna3, "linux") || InStr(Coluna3, "redes") || InStr(Coluna3, "hacking") 
            ListLinuxCourses .= RegExReplace(StrSplit(A_LoopField, ",")[1] "|", aspa, "")
         If InStr(Coluna3, "top-rated") 
            ListTopCourses .= RegexReplace(StrSplit(A_LoopField, ",")[1] "|", aspa, "")
         If InStr(Coluna3, "web-server") 
            ListWebServerCourses .= RegexReplace(StrSplit(A_LoopField, ",")[1] "|", aspa, "")

      } 
      ; MODIFICANDO TODAS COMBOBOX PARA POPULAREM OS DADOS DA PLANILHA
      GuiControl,1:, Curso, %ListTopCourses% ; main courses
      GuiControl,1:, CursoWebDev, %ListWebDevCourses% ; web dev courses
      GuiControl,1:, CursoJavaScript, %ListJavaScriptCourses% ; analytics mkt courses
      GuiControl,1:, CursoMkt, %ListAnalyticsCourses% ; analytics mkt courses
      GuiControl,1:, CursoSQL, %ListSQLCourses% ; analytics mkt courses
      GuiControl,1:, CursoWebServer, %ListWebServerCourses% ; analytics mkt courses
      GuiControl,1:, CursoLinux, %ListLinuxCourses% ; analytics mkt courses
      GuiControl,1:, CursoAll, %ListAllCourses% ; analytics mkt courses
      ; ajustar largura
      LV_ModifyCol()
      ; ordenar
      ; LV_ModifyCol(1, sort, "integer")
      ; LV_ModifyCol(1, "text")

      ; exibir total de linhas
      totalLines := LV_GetCount()
      GuiControl, , TotalCursos, Total de Cursos: %totalLines%
Return

/*
      AO CLICAR EM ALGUM CURSO DA LISTVIEW
*/
ListaDeCursos:
   Gui Submit, NoHide

   ComObjError(false)
   /*
   CAPTURAR LINHA SELECINADA NA LISTVIEW DA GUI DO AHK
   */
   NumeroLinhaSelecionada := LV_GetNext()
   ; texto selecionado na coluna 1 (nome do curso)
   LV_GetText(TextoLinhaSelecionadaCurso, NumeroLinhaSelecionada, 1) 
   ; texto selecionado na coluna 2 (url do curso)
   LV_GetText(TextoLinhaSelecionadaURL, NumeroLinhaSelecionada, 2) 

   ; Variables
   chPath := "C:\Program Files\Google\Chrome\Application\chrome.exe"
   IfNotExist, %chPath%
      chPath := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
   profileName := "C:\Users\felipe\Desktop\ChromeProfile"
   IfNotExist %profileName%
      profileName := "C:\Users\Felipe\Desktop\ChromeProfile"
   IfNotExist %profileName%
      profileName := "C:\Users\Estudos\Desktop\ChromeProfile"
   IfNotExist %profileName%
      profileName := "C:\Users\Estudos\AppData\Local\Google\Chrome\User Data"

   ; website := "udemy.com"
   ; if(Chrome.GetPageByURL(website, "contains")){
   ;    website := "udemy.com"
   ; }else{
   ;    website := "youtube.com"
   ; }

   ; msgbox % A_GuiEvent
   if(A_GuiEvent == "DoubleClick"){
   ; msgbox %TextoLinhaSelecionadaCurso%
   ; msgbox %TextoLinhaSelecionadaURL%
   if !(TextoLinhaSelecionadaCurso == "GTM1") AND !(TextoLinhaSelecionadaCurso == "GTM2") AND !(TextoLinhaSelecionadaCurso == "GA4"){      ; se não encontrar aba chrome com remote debug
      if !(PageInst := Chrome.GetPageByURL(TextoLinhaSelecionadaURL, "contains"))
      {
         ChromeInst := new Chrome(profileName,TextoLinhaSelecionadaURL,"--remote-debugging-port=9222 --remote-allow-origins=*",chPath)
         Notify().AddWindow("Não encontrei o site aberto no Chrome, Vou abrir pra você agora!",{Time:6000,Icon:28,Background:"0x900C3F",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
         Sleep, 500
         contador1 := 0
         while !(PageInst)
         {
            Sleep, 500
            Notify().AddWindow("procurando instância do chrome...!",{Time:6000,Icon:28,Background:"0x1100AA",Title:"ERRO!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
            PageInst := Chrome.GetPageByURL(TextoLinhaSelecionadaURL, "contains")
            contador1++
            if(contador1 >= 30){
               PageInst.Disconnect()
               break
            }
         }
      }
      Sleep, 500
      ; aqui está o fix pra esperar a página carregar
      PageInst := Chrome.GetPageByURL(TextoLinhaSelecionadaURL, "contains")
      Sleep, 500
     ; SUPER IMPORTANTE, ATIVAR A TAB/PÁGINA, ACTIVATE, FOCUS
      PageInst.Call("Page.bringToFront")
   
      /*
         CASO TENHA SLECIONADO UM CURSO LOCAL 
      */
      }else if(Curso == "GTM1" || CursoWebDev == "GTM1" || CursoAll == "GTM1" || CursoOutros == "GTM1" || CursoMkt == "GTM1"){
      gtm1Folder := "Y:\Season\Analyticsmania\Google Tag Manager Masterclass For Beginners 3.0"
      if !FileExist(gtm1Folder)
      {
       gtm1Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Google Tag Manager Masterclass For Beginners 3.0"
      }
      Run vlc.exe "%gtm1Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
      Run %gtm1Folder%\PLAYLIST-COMPLETA-BEGGINER.xspf
      }else if(Curso == "GTM2" || CursoWebDev == "GTM2" || CursoAll == "GTM2" || CursoOutros == "GTM2" || CursoMkt == "GTM2"){
      gtm2Folder := "Y:\Season\Analyticsmania\Intermediate Google Tag Manager Advanced Topics 2.0"
      if !FileExist(gtm2Folder)
      {
         gtm2Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Intermediate Google Tag Manager Advanced Topics 2.0"
      }
      Run vlc.exe "%gtm2Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
      Run %gtm2Folder%\PLAYLIST-COMPLETA-ADVANCED.xspf
      }else if(Curso == "GA4" || CursoWebDev == "GA4" || CursoAll == "GA4" || CursoOutros == "GA4" || CursoMkt == "GA4"){
      GA4Folder := "Y:\Season\Analyticsmania\Google Analytics 4 Course"
      if !FileExist(GA4Folder)
      {
      GA4Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Google Analytics 4 Course"
      }
      Run vlc.exe "%GA4Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
      Run %GA4Folder%\PLAYLIST-COMPLETA-GA4.xspf
      }else{
      Notify().AddWindow("Nenhum curso válido foi selecionado!",{Time:6000,Icon:28,Background:"0x990000",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
      PageInst.Disconnect()
      }
   }
; GoSub, controlVideos
Return


CadastrarCurso:
   Gui, Submit, NoHide
   msgbox %ListAllCourses%
   msgbox %NomeNovoCurso%
   ListAllCourses .= "|"NomeNovoCurso
   msgbox %ListAllCourses%
   ; atualizar combobox, refill
   ; vCursoAll gCursos w150 hwndCursosIDAll, %ListAllCourses%

   ; SOLUÇÃO PARA EDITAR A PRIMEIRA GUI, QUE NÃO TEM NOME :1'2'1\
   GuiControl,1:, CursoAll , %ListAllCourses%
   ; GuiControl,,hwndCursosIDAll,"|"%ListAllCourses%
Return
/*
TRATAMENTO DO MENU BAR
*/
MenuHandler:
; MsgBox, %A_ThisMenuItem%
return

MenuFileOpen:
; MsgBox, Open Menu was clicked
Gui, NovoCurso:New, +AlwaysOnTop -Resize -MinimizeBox -MaximizeBox, Cadastrar Novo Curso - Felipe Lullio

Gui, NovoCurso:Add, Text,center h20 +0x200 section, Link do Curso:
Gui, NovoCurso:Add, Edit, x+12 w368 vLinkNovoCurso

Gui, NovoCurso:Add, Text,xs center h20 +0x200 section, Nome do Curso:
Gui, NovoCurso:Add, Edit, vNomeNovoCurso w100 x+5

Gui, NovoCurso:Add, Text, ys x+5 center h20 +0x200 section, Categoria:
Gui, NovoCurso:Add, ComboBox, vCategoriaNovoCurso gCursos w100 hwndCursosIDAll ys x+5, Developer|Marketing
Gui, NovoCurso:Add, Checkbox,Checked1 x+15 center h20 +0x200, Curso Principal?

gui, font, S13 ;Change font size to 12
gui, NovoCurso:Add, Button, center y+15 x120 w250 h25 gCadastrarCurso Default, &Cadastrar Curso

Gui, NovoCurso:Show, xCenter yCenter
ControlFocus, Edit1, Cadastrar Novo Curso - Felipe Lullio
return