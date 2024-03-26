#Include, <Default_Settings>
; #SingleInstance, force
; #Include, C:\Users\%A_UserName%\Downloads\Chrome.ahk
#Include, C:\Program Files\AutoHotkey\Lib\Chrome.ahk

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
if not A_IsAdmin
   Run *RunAs "%A_ScriptFullPath%"

; Variables
; Variables
chPath := "C:\Program Files\Google\Chrome\Application\chrome.exe"
IfNotExist, %chPath%
   chPath := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

profileName := "C:\Users\" . A_UserName "\AppData\Local\Google\Chrome\User Data"
IfNotExist %profileName%
   profileName := "C:\Users\Felipe\AppData\Local\Google\Chrome\User Data\Default"
IfNotExist %profileName%
   profileName := "C:\Users\Felipe\Desktop\ChromeProfile"
IfNotExist %profileName%
   profileName := "C:\Users\Estudos\Desktop\ChromeProfile"
IfNotExist %profileName%
   profileName := "C:\Users\Estudos\AppData\Local\Google\Chrome\User Data"
aspas =
      (
      "
      )

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
Menu, FileMenu, Add, &Abrir Planilha`tCtrl+N, MenuAbrirLink
Menu, FileMenu, Add, &Abrir Cursos Udemy, MenuAbrirLink
Menu, FileMenu, Add ; with no more options, this is a seperator
Menu, FileMenu, Add, &Reiniciar o App, MenuAbrirLink
Menu, FileMenu, Add, &Sair do App, MenuAbrirLink

Menu, EditMenu, Add, Copy`tCtrl+C, MenuAbrirLink
Menu, EditMenu, Add, Past`tCtrl+V, MenuAbrirLink
Menu, EditMenu, Add ; with no more options, this is a seperator
Menu, EditMenu, Add, Delete`tDel, MenuAbrirLink

Menu, HelpMenu, Add, &Como usar o Programa?, MenuAjudaNotify
Menu, HelpMenu, Add ; with no more options, this is a seperator
Menu, HelpMenu, Add, &Como controlar o vídeo (atalhos)?, MenuAjudaNotify
Menu, HelpMenu, Add, &Qual é a função do botão 'Abrir Curso'?, MenuAjudaNotify
Menu, HelpMenu, Add, &Qual é a função do botão 'Pesquisar'?, MenuAjudaNotify
Menu, HelpMenu, Add, &Qual é a função do botão 'Atualizar'?, MenuAjudaNotify
Menu, HelpMenu, Add ; with no more options, this is a seperator
Menu, HelpMenu, Add, &Sobre o programa (Github), MenuAbrirLink
Menu, HelpMenu, Add, &Desenvolvedor, MenuAbrirLink
Menu, HelpMenu, Add, &WhatsApp, MenuAbrirLink

; Attach the sub-menus that were created above.
Menu, MyMenuBar, Add, &Abrir, :FileMenu
; Menu, MyMenuBar, Add, &Editar, :EditMenu
Menu, MyMenuBar, Add, &Ajuda, :HelpMenu
Gui, Menu, MyMenuBar ; Attach MyMenuBar to the GUI

/*
   STATUS BAR
*/
Gui Font, S9
Gui Add, Statusbar, gStatusBarLinks vMyStatusBar,
/*
   EDITAR TEXTO DA STATUS BAR
*/
SB_SetParts(105, 160, 160, 80, 80)
SB_SetText("Reload (SHIFT+R ou @reload)", 2)
SB_SetText("Front Page (Shift+A ou @front)", 3)
SB_SetText("Close Chrome", 4)
Gui Font, S10

/*
LINHA 1 - SEPARADO - PRINCIPAIS CURSOS
*/
; dropdown 1 - principais cursos
Gui Add, Text,section y+10 , Main Courses / Top Rated
Gui, Add, ComboBox, Multi x10 y+10 w255 vCurso gCursos hwndCursosIDMain sort,
Gui Add, Text, ys , Soft Skills
Gui, Add, ComboBox, Multi y+10 w255 vCursoSoftSkills gCursos hwndCursosIDSoft sort,

/*
COLUNA 1
*/
; dropdown 2 - web dev cursos
Gui Add, Text, section x10, Web Developer
Gui, Add, ComboBox, Multi vCursoWebDev gCursos hwndCursosIDDev w250 sort,
; dropdown 3 - Cursos Analytics
Gui Add, Text,, Analytics / Marketing
Gui, Add, ComboBox, Multi vCursoMkt gCursos w250 hwndCursosIDAll sort,
; dropdown 7 - backend
Gui Add, Text,, Backend / Web Server
Gui, Add, ComboBox, Multi vCursoWebServer gCursos hwndCursosIDOutros w250 sort,
/*
COLUNA 2
*/
; dropdown 4 - javascript cursos
Gui Add, Text, ys, JavaScript All
Gui, Add, ComboBox, Multi w250 vCursoJavaScript gCursos hwndCursosIDMkt sort,
; dropdown 5 - sql banco de dados cursos
Gui Add, Text,, SQL
Gui, Add, ComboBox, Multi vCursoSQL gCursos hwndCursosIDOutros w250 sort,
; dropdown 6 - linux cursos
Gui Add, Text, , Linux Courses
Gui, Add, ComboBox , Multi w250 vCursoLinux gCursos hwndCursosIDMkt sort,

; Botões
gui, font, S11
gui, Add, Button, y+15 xs w250 h30 gAbrirCurso Default, &Abrir Curso
gui, Add, Button, w150 h30 x+10 gAbrirNotion, &Abrir Anotações
gui, Add, Button, w95 h30 x+10 gCancel Cancel, &Cancelar

/*
COLUNA 3
*/

; gui, font, S7 ;Change font size to 12
; 2º dropdown js courses
Gui, Add, GroupBox, y+15 xs cBlack r14 w560, Lista dos Cursos
Gui Add, Text, yp+25 xp+11 center, Cursos em Andamento
Gui Add, Text, x+155 center, Cursos do Youtube
Gui Font, S10

Gui Add, ComboBox, Multi xs+10 yp+20 w280 center vCursoAndamento hwndDimensoesID sort,
; Gui Add, ComboBox, Multi xs+10 yp+20 w372 center vCursoAll hwndDimensoesID ,
Gui Add, ComboBox, Multi x+10 w237 center vCursoYoutube hwndDimensoesID sort,
Gui Font,
Gui Add, ListView, altsubmit vCursoDaLista gListaDeCursos w530 r10 xs+10 y+10 -readonly grid , ID|Nome do Curso|URL|Categories|Provider|Notion|Length|Rating
; Gui Add, Link, w120 y+5 vTotalCursos center,
; LV_Modify()
Gui Font, S12
Gui, Add, Edit, h29 vVarPesquisarDados w230 y+15 section cblue, .*power.*
Gui Font, S10,
Gui, Add, Button, vBtnPesquisar x+10 w100 h30 gPesquisarDados Default, Pesquisar
Gui, Add, Button, vBtnAtualizar x+10 w100 h30 gUpdateList, Atualizar
Gui Font, S6.5
; Gui Add, Button, x+50 w135 h26 gUpdateList, Atualizar Lista

; CARREGAR OS DADOS DOS CURSOS DA PLANILHA ANTES DE EXIBIR A GUI, NÃO VAI TER DELAY
GoSub, getData

; Botões
; gui, font, S11
; gui, Add, Button, y+15 xs w250 h30 gAbrirCurso Default, &Abrir Curso
; gui, Add, Button, w150 h30 x+10 gAbrirNotion, &Abrir Anotações
; gui, Add, Button, w95 h30 x+10 gCancel Cancel, &Cancelar

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
      DropDownComplete(CursosIDSoft)
   Case "Edit3":
      DropDownComplete(CursosIDDev)
   Case "Edit4":
      DropDownComplete(CursosIDAll)
   Case "Edit5":
      DropDownComplete(CursosIDMkt)
   Case "Edit6":
      DropDownComplete(CursosIDOutros)
   Default:
      Notify().AddWindow("Nenhum control da gui esta com foco",{Time:3000,Icon:238, Background:"0xFFFB03",Title:"ALERTA",TitleSize:15, Size:15, Color: "0x524D4D", TitleColor: "0x3E3E3E"},,"setPosBR")
   }
return

/* ABRIR AS ANOTAÇÕES DO NOTION E A PASTA DO PROJETO SE EXISTIR
*/
AbrirNotion:
   Gui, Submit, NoHide
   /*
   PEGAR TEXTOS DA PRIMEIRA E SEGUNDA COLUNA DA LISTVIEW
   */
   WinGet, ActiveControlList, ControlList, A
   Loop, % LV_GetCount() ; loop through every row
   {
      LV_GetText(TextoColuna1, A_Index) ; will get first column by default (Nome do Curso)
      LV_GetText(TextoColuna5, A_Index, 5) ; will get second column (URL do Curso)
      /*
      CAPTURANDO TODOS OS CONTROLS DA GUI
      */
      Loop, Parse, ActiveControlList, `n
      {
         ControlGetText, TextoDoControl, %A_LoopField%
         FileAppend, %a_index%`t%A_LoopField%`t%TextoDoControl%`n, C:\Controls.txt
         /*
            CAPTURANDO SOMENTES OS ComboBoXES
         */
         if(InStr(A_LoopField, "ComboBox")) ; se for um combobox
         {
            if(TextoDoControl && TextoDoControl = TextoColuna1) ; selecionou algum curso no combobox e for igual a algum texto da coluna1 da listview
            {
               ; abrir notion
               /*
                 ABRIR NOTION
                              */
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
               Run %ComSpec% /c C:\Users\felipe\AppData\Local\Programs\Notion\Notion.exe "%TextoColuna5%" , , Hide
               RunAs
               WinActivate, Notion
            }
         }
      }
   }
return

AbrirCurso:
   Gui, Submit, NoHide
   ComObjError(false)
   /*
   PEGAR TEXTOS DA PRIMEIRA E SEGUNDA COLUNA DA LISTVIEW
   */
   WinGet, ActiveControlList, ControlList, A

   /*
   CAPTURANDO TODOS OS CONTROLS DA GUI
   */
   ; msgbox % TextoColuna2
   Loop, Parse, ActiveControlList, `n
   {

      ControlGetText, TextoDoControl, %A_LoopField%
      ; msgbox % TextoDoControl
      FileAppend, %a_index%`t%A_LoopField%`t%TextoDoControl%`n, C:\Controls.txt
      ; RETORNAR O NOME/VARIÁVEL DO CONTROL QUE ESTÁ COM FOCO
      GuiControlGet,varName, FocusV
      /*
         CAPTURANDO SOMENTES OS ComboBoXES
      */
      if(InStr(A_LoopField, "ComboBox")) ; se for um combobox
      {
         ; msgbox %TextoDoControl%

         if(TextoDoControl == "GTM1"){
            gtm1Folder := "Y:\Season\Analyticsmania\Google Tag Manager Masterclass For Beginners 3.0"
            if !FileExist(gtm1Folder)
            {
               gtm1Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Google Tag Manager Masterclass For Beginners 3.0"
            }
            Run vlc.exe "%gtm1Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
            Run %gtm1Folder%\PLAYLIST-COMPLETA-BEGGINER.xspf
         }else if(TextoDoControl == "GTM2"){
            gtm2Folder := "Y:\Season\Analyticsmania\Intermediate Google Tag Manager Advanced Topics 2.0"
            if !FileExist(gtm2Folder)
            {
               gtm2Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Intermediate Google Tag Manager Advanced Topics 2.0"
            }
            Run vlc.exe "%gtm2Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
            Run %gtm2Folder%\PLAYLIST-COMPLETA-ADVANCED.xspf

         }else if(TextoDoControl == "GA4"){
            GA4Folder := "Y:\Season\Analyticsmania\Google Analytics 4 Course"
            if !FileExist(GA4Folder)
            {
               GA4Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Google Analytics 4 Course"
            }
            Run vlc.exe "%GA4Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
            Run %GA4Folder%\PLAYLIST-COMPLETA-GA4.xspf


            /*
               SE O COMBOBOX TIVER ALGUMA OPÇÃO SELECIONADA E SE O TEXTO DO COMBOBOX SELECIONADO É IGUAL A ALGUM TEXTO DA COLUNA1 DA LISTVIEW
            */
         }else if(TextoDoControl == "Scrum + GTD - Gustavo Farias"){
            ScrumFolder := "Y:\Season\#Scrum Gestão Ágil com Scrum COMPLETO + 3 Cursos BÔNUS"
            if !FileExist(ScrumFolder)
            {
               ScrumFolder := "C:\Users\" A_UserName "\Documents\Season\#Scrum Gestão Ágil com Scrum COMPLETO + 3 Cursos BÔNUS"
            }
            Run vlc.exe "%ScrumFolder%\playlist-gestao-agil-gustavo-farias.xspf"
            Run %ScrumFolder%\playlist-gestao-agil-gustavo-farias.xspf

            /*
               SE O COMBOBOX TIVER ALGUMA OPÇÃO SELECIONADA E SE O TEXTO DO COMBOBOX SELECIONADO É IGUAL A ALGUM TEXTO DA COLUNA1 DA LISTVIEW
            */
         }else ; selecionou algum curso no combobox e for igual a algum texto da coluna1 da listview
         {
            Loop, % LV_GetCount() ; loop through every row
            {
               LV_GetText(TextoColuna2, A_Index, 2) ; will get first column by default (Nome do Curso)
               LV_GetText(TextoColuna3, A_Index, 3) ; will get second column (URL do Curso)
               ; msgbox %a_index%`t%A_LoopField%`t%TextoDoControl%`n
               ; msgbox %A_index%

               ; msgbox %TextoColuna1%%TextoColuna3%

               ; se não encontrar aba chrome com remote debug
               ; msgbox %TextoLinhaSelecionadaCurso%
               ; msgbox %TextoLinhaSelecionadaURL%     ; se não encontrar aba chrome com remote debug
               if(TextoDoControl && TextoDoControl = TextoColuna2 && !(TextoLinhaSelecionadaCurso == "GTM1") AND !(TextoLinhaSelecionadaCurso == "GTM2") AND !(TextoLinhaSelecionadaCurso == "GA4") AND !(TextoLinhaSelecionadaCurso == "Scrum + GTD - Gustavo Farias")){
                  if !(PageInst := Chrome.GetPageByURL(TextoColuna3, "contains"))
                  {
                     ChromeInst := new Chrome(profileName,TextoColuna3,"--remote-debugging-port=9222 --remote-allow-origins=* --profile-directory=""Default""",chPath)
                     Notify().AddWindow("Não encontrei o site aberto no Chrome, Vou abrir pra você agora!",{Time:6000,Icon:28,Background:"0x900C3F",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
                     Sleep, 500
                     contador1 := 0
                     while !(PageInst)
                     {
                        Sleep, 500
                        Notify().AddWindow("procurando instância do chrome...!",{Time:6000,Icon:28,Background:"0x1100AA",Title:"ERRO!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
                        PageInst := Chrome.GetPageByURL(TextoColuna3, "contains")
                        contador1++
                        if(contador1 >= 5){
                           PageInst.Disconnect()
                           break
                        }
                     }
                  }
                  Sleep, 500
                  ; aqui está o fix pra esperar a página carregar
                  PageInst := Chrome.GetPageByURL(TextoColuna3, "contains")
                  Sleep, 500
                  ; SUPER IMPORTANTE, ATIVAR A TAB/PÁGINA, ACTIVATE, FOCUS
                  PageInst.Call("Page.bringToFront")
                  PageInst.Disconnect()
                  Break
               }
            }
         }

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
   dataAllRows := ""
   /*
      IMPORTANTE:
      A COLUNA E DA PLANILHA PRECISA TER UMA FÓRMULA PARA GERAR O ARRAY DOS DADOS
   */
   Gui Submit, NoHide

   urlData := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=A2:G80&sheet=Cursos"
   urlCourseName := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=A2:A80&sheet=Cursos"
   urlCourseURL := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=B2:B80&sheet=Cursos"
   urlCourseCategories := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=C2:C80&sheet=Cursos"
   urlCourseProvider := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=D2:D80&sheet=Cursos"
   urlCourseNotion := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=E2:E80&sheet=Cursos"
   urlCourseLength := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=F2:F80&sheet=Cursos"
   urlCourseRating := "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/gviz/tq?tqx=out:csv&range=G2:G80&sheet=Cursos"

   ; todos os dados
   dataAllRows := getDataFromGoogleSheet(urlData)
   ; msgbox % dataAllRows

   ListAllCourses := ""
   ListSQLCourses := ""
   ListWebDevCourses := ""
   ListJavaScriptCourses := ""
   ListAnalyticsCourses := ""
   ListLinuxCourses := ""
   ListTopCourses := ""
   ListWebServerCourses := ""
   ListAndamentoCourses := ""
   ListYoutubeCourses := ""
   ListSoftSkillCourses := ""
   Loop, parse, dataAllRows, `n,`r ; linha
   {
      LineNumber := A_Index
      LineContent := A_LoopField
      ; msgbox % LineContent := A_LoopField
      ; msgbox, % RegExReplace(StrSplit(A_LoopField,",")[1], aspa , "")
      Coluna0 := RegExReplace(StrSplit(A_LoopField,",")[1], aspa , "") ; 1 coluna courseName
      Coluna1 := RegExReplace(StrSplit(A_LoopField,",")[2], aspa , "") ; 1 coluna courseName
      Coluna2 := RegExReplace(StrSplit(A_LoopField,",")[3], aspa , "") ; 2 coluna courseURL
      Coluna3 := RegExReplace(StrSplit(A_LoopField,",")[4], aspa , "") ; 3 coluna courseCategories
      Coluna4 := RegExReplace(StrSplit(A_LoopField,",")[5], aspa , "") ; 4 coluna courseProvider
      Coluna5 := RegExReplace(StrSplit(A_LoopField,",")[6], aspa , "") ; 5 coluna courseLength
      Coluna6 := RegExReplace(StrSplit(A_LoopField,",")[7], aspa , "") ; 6 coluna courseRating
      ; LV_Add("" , Coluna1, SubStr(Coluna2, 2,-1), SubStr(Coluna3, 2,-1), SubStr(Coluna4, 2,-1), SubStr(Coluna5, 2,-1)) ; serve para remover as aspas na frente e final
      LV_Add("" , Coluna0, Coluna1, Coluna2, Coluna3, Coluna4, Coluna5, Coluna6)
      /*
         ORGANIZAR AS CATEGORIAS DOS CURSOS  / SALVAR TODOS OS CURSOS EM VARIÁVEIS COM BASE NA CATEOGIRA
         1. SE EXISTIR "SQL" na coluna 2 courseCategories Adicionar o nome do curso na variável ListSQLCourses
         2. ....
         nome do curso esta na coluna 1, ou seja [1] posição 1
      ; https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/edit#gid=0
      */
      ListAllCourses .= RegexReplace(StrSplit(A_LoopField,",")[2] "|", aspa, "") ; salvar todos os cursos
      If InStr(Coluna3, "sql")
         ListSQLCourses .= RegexReplace(StrSplit(A_LoopField,",")[2] "|", aspa, "")
      If InStr(Coluna3, "web-dev")
         ListWebDevCourses .= RegexReplace(StrSplit(A_LoopField,",")[2] "|", aspa, "")
      If InStr(Coluna3, "javascript") || If InStr(Coluna3, "js-frameworks")
         ListJavaScriptCourses .= RegexReplace(StrSplit(A_LoopField, ",")[2] "|", aspa, "")
      If InStr(Coluna3, "analytics") || InStr(Coluna3, "ads") || InStr(Coluna3, "wordpress")
         ListAnalyticsCourses .= RegexReplace(StrSplit(A_LoopField, ",")[2] "|", aspa, "")
      If InStr(Coluna3, "linux") || InStr(Coluna3, "redes") || InStr(Coluna3, "hacking")
         ListLinuxCourses .= RegExReplace(StrSplit(A_LoopField, ",")[2] "|", aspa, "")
      If InStr(Coluna3, "top-rated")
         ListTopCourses .= RegexReplace(StrSplit(A_LoopField, ",")[2] "|", aspa, "")
      If InStr(Coluna3, "web-server")
         ListWebServerCourses .= RegexReplace(StrSplit(A_LoopField, ",")[2] "|", aspa, "")
      If InStr(Coluna3, "em-andamento")
         ListAndamentoCourses .= RegexReplace(StrSplit(A_LoopField, ",")[2] "|", aspa, "")
      If InStr(Coluna2, "youtube.com")
         ListYoutubeCourses .= RegexReplace(StrSplit(A_LoopField, ",")[2] "|", aspa, "")
      If InStr(Coluna3, "soft-skill")
         ListSoftSkillCourses .= RegexReplace(StrSplit(A_LoopField, ",")[2] "|", aspa, "")

   }
   ; MODIFICANDO TODAS COMBOBOX PARA POPULAREM OS DADOS DA PLANILHA
   GuiControl,1:, Curso, %ListTopCourses% ; main courses
   GuiControl,1:, CursoSoftSkills, %ListSoftSkillCourses% ; main courses
   GuiControl,1:, CursoWebDev, %ListWebDevCourses% ; web dev courses
   GuiControl,1:, CursoJavaScript, %ListJavaScriptCourses% ; analytics mkt courses
   GuiControl,1:, CursoMkt, %ListAnalyticsCourses% ; analytics mkt courses
   GuiControl,1:, CursoSQL, %ListSQLCourses% ; analytics mkt courses
   GuiControl,1:, CursoWebServer, %ListWebServerCourses% ; analytics mkt courses
   GuiControl,1:, CursoLinux, %ListLinuxCourses% ; analytics mkt courses
   GuiControl,1:, CursoAll, %ListAllCourses% ; analytics mkt courses
   GuiControl,1:, CursoAndamento, %ListAndamentoCourses% ; cursos em andamento
   GuiControl,1:, CursoYoutube, %ListYoutubeCourses% ; cursos do youtube
   LV_ModifyCol(1, 28)
   LV_ModifyCol(2, 472)
   ; ajustar largura
   ; LV_ModifyCol(1, 50)
   ; LV_ModifyCol(2, 509)
   ; ; ordenar
   ; LV_ModifyCol(2, 0)
   LV_ModifyCol(3, 0)
   LV_ModifyCol(4, 0)
   LV_ModifyCol(5, 0)
   LV_ModifyCol(6, 0)
   LV_ModifyCol(7, 0)
   LV_ModifyCol(8, 0)

; exibir total de linhas
totalCursos:
   totalLines := LV_GetCount()
   GuiControl, , TotalCursos, Total de Cursos: %totalLines%
   SB_SetText("Total de Cursos: " totalLines, 1)
Return
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
   ; NOME DO CURSO -> texto selecionado na coluna 1 (nome do curso)
   LV_GetText(TextoLinhaSelecionadaCurso, NumeroLinhaSelecionada, 2)
   ; URL DO CURSO -> texto selecionado na coluna 2 (url do curso)
   LV_GetText(TextoLinhaSelecionadaURL, NumeroLinhaSelecionada, 3)
   ; URL DO NOTION - ANOTAÇÕES -> texto selecionado na coluna 5 (notion do curso)
   LV_GetText(TextoLinhaSelecionadaNotion, NumeroLinhaSelecionada, 6)

   ; msgbox % A_GuiEvent
   if(A_GuiEvent == "DoubleClick"){
      ; msgbox %TextoLinhaSelecionadaCurso%
      ; msgbox %TextoLinhaSelecionadaURL%
      if !(TextoLinhaSelecionadaCurso == "GTM1") AND !(TextoLinhaSelecionadaCurso == "GTM2") AND !(TextoLinhaSelecionadaCurso == "GA4") AND !(TextoLinhaSelecionadaCurso == "Scrum + GTD - Gustavo Farias"){ ; se não encontrar aba chrome com remote debug
         if !(PageInst := Chrome.GetPageByURL(TextoLinhaSelecionadaURL, "contains"))
         {
            ; ChromeInst := new Chrome(profileName,TextoLinhaSelecionadaURL,"--remote-debugging-port=9222 --remote-allow-origins=* --profile-directory=""Profile 2""",chPath)
            ChromeInst := new Chrome(profileName,TextoLinhaSelecionadaURL,"--remote-debugging-port=9222 --remote-allow-origins=* --profile-directory=""Default""",chPath)
            Notify().AddWindow("Não encontrei o site aberto no Chrome, Vou abrir pra você agora!",{Time:6000,Icon:28,Background:"0x900C3F",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
            Sleep, 500
            contador1 := 0
            while !(PageInst)
            {
               Sleep, 500
               Notify().AddWindow("procurando instância do chrome...!",{Time:6000,Icon:28,Background:"0x1100AA",Title:"ERRO!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
               PageInst := Chrome.GetPageByURL(TextoLinhaSelecionadaURL, "contains")
               contador1++
               if(contador1 >= 5){
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
            ABRIR NOTION
         */
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
         Run %ComSpec% /c C:\Users\felipe\AppData\Local\Programs\Notion\Notion.exe "%TextoLinhaSelecionadaNotion%", , Hide
         RunAs
         WinActivate, Notion

         /*
            CASO TENHA SLECIONADO UM CURSO LOCAL
         */
      }else if(TextoLinhaSelecionadaCurso == "GTM1"){
         gtm1Folder := "Y:\Season\Analyticsmania\Google Tag Manager Masterclass For Beginners 3.0"
         if !FileExist(gtm1Folder)
         {
            gtm1Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Google Tag Manager Masterclass For Beginners 3.0"
         }
         Run vlc.exe "%gtm1Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
         Run %gtm1Folder%\PLAYLIST-COMPLETA-BEGGINER.xspf
      }else if(TextoLinhaSelecionadaCurso == "GTM2"){
         gtm2Folder := "Y:\Season\Analyticsmania\Intermediate Google Tag Manager Advanced Topics 2.0"
         if !FileExist(gtm2Folder)
         {
            gtm2Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Intermediate Google Tag Manager Advanced Topics 2.0"
         }
         Run vlc.exe "%gtm2Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
         Run %gtm2Folder%\PLAYLIST-COMPLETA-ADVANCED.xspf
      }else if(TextoLinhaSelecionadaCurso == "GA4"){
         GA4Folder := "Y:\Season\Analyticsmania\Google Analytics 4 Course"
         if !FileExist(GA4Folder)
         {
            GA4Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Google Analytics 4 Course"
         }
         Run vlc.exe "%GA4Folder%\PLAYLIST-ADITIONAL-CONTENT.xspf"
         Run %GA4Folder%\PLAYLIST-COMPLETA-GA4.xspf
      }else if(TextoLinhaSelecionadaCurso == "Scrum + GTD - Gustavo Farias"){
         ScrumFolder := "Y:\Season\#Scrum Gestão Ágil com Scrum COMPLETO + 3 Cursos BÔNUS"
         if !FileExist(ScrumFolder)
         {
            ScrumFolder := "C:\Users\" A_UserName "\Documents\Season\#Scrum Gestão Ágil com Scrum COMPLETO + 3 Cursos BÔNUS"
         }
         Run vlc.exe "%ScrumFolder%\playlist-gestao-agil-gustavo-farias.xspf"
         Run %ScrumFolder%\playlist-gestao-agil-gustavo-farias.xspf
      }else{
         Notify().AddWindow("Nenhum curso válido foi selecionado!",{Time:6000,Icon:28,Background:"0x990000",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
         PageInst.Disconnect()
      }
      /*
         CLIQUE COM BOTÃO DIREITO DO MOUSE
      */
   }else if(A_GuiEvent == "RightClick"){
      /*
         ABRIR NOTION
      */
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
      Run %ComSpec% /c C:\Users\felipe\AppData\Local\Programs\Notion\Notion.exe "%TextoLinhaSelecionadaNotion%", , Hide
      RunAs
      WinActivate, Notion

   }
; GoSub, controlVideos
Return

/*
      ATUALIZAR LISTVIEW
*/
UpdateList:
   LV_Delete()
   Gosub, getData
Return

/*
--------------------------
--------------------------
--------------------------
--------------------------
--------------------------
--------------------------
--------------------------
--------------------------
*/
/*
TRATAMENTO DO MENU BAR
*/
MenuAcoesApp:
   If(InStr(A_ThisMenuItem, "Sair"))
      ExitApp
   Else If(InStr(A_ThisMenuItem, "Reiniciar"))
      Reload
return

MenuAbrirLink:
   ; MsgBox, %A_ThisMenuItem%
   If(InStr(A_ThisMenuItem, "planilha"))
      Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Default" "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/edit?usp=sharing"
   If(InStr(A_ThisMenuItem, "cursos udemy"))
      Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Default" "https://www.udemy.com/home/my-courses/lists/"
   Else If(InStr(A_ThisMenuItem, "Sobre o programa (Github)"))
   {
      Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Default" "https://github.com/lullio/ahk-chrome-control-videos"
      Run, https://projetos.lullio.com.br/gerenciador-de-cursos-e-controle-de-video
   }
   Else If(InStr(A_ThisMenuItem, "WhatsApp"))
      Run, https://wa.me/5511991486309
   Else If(InStr(A_ThisMenuItem, "Desenvolvedor"))
      Run, https://www.lullio.com.br
return
MenuAjudaNotify:
   If(InStr(A_ThisMenuItem, "Como usar o programa?"))
      ; msgbox SUCESSO com SOM e ICONE alwaysontop
      MsgBox, 4160 , INFORMAÇÃO!, Dê um duplo clique em qualquer item da lista para abrir o quadro correspondente. `n`nSe desejar realizar alguma ação no quadro`, como excluí-lo ou editar o seu nome`, basta dar um duplo clique com o botão direito do mouse., 900
   Else If(InStr(A_ThisMenuItem, "como usar o programa"))
      ; msgbox SUCESSO com SOM e ICONE alwaysontop
      MsgBox, 4160 , INFORMAÇÃO!, 1. Para abrir uma tarefa no Notion`, clique com o botão esquerdo do mouse em qualquer item da Lista.`n`n2. Para arquivar ou desarquivar uma tarefa`, clique com o botão direito do mouse em qualquer item da Lista., 900
   Else If(InStr(A_ThisMenuItem, "Qual é a função do botão 'Abrir Curso'"))
      ; msgbox SUCESSO com SOM e ICONE alwaysontop
      MsgBox, 4160 , INFORMAÇÃO!, O botão 'Abrir Curso' tem a finalidade de criar um ou mais quadros no seu Trello. Para criar mais de um quadro`, basta separar os nomes por vírgulas e as descrições por quebra de linha, 900
   Else If(InStr(A_ThisMenuItem, "Qual é a função do botão 'Pesquisar'"))
      ; msgbox SUCESSO com SOM e ICONE alwaysontop
      MsgBox, 4160 , INFORMAÇÃO!, O botão "Pesquisar" tem a finalidade de buscar uma tarefa na lista de tarefas exibida acima.`n`n O campo de pesquisa permite o uso de expressões regulares (regex) e`, por padrão`, a pesquisa não diferencia maiúsculas de minúsculas (não é "casesensitive").`n`nObservação:Você pode realizar uma pesquisa clicando no botão 'Pesquisar' ou pressionando a tecla 'Enter' no teclado., 900
   Else If(InStr(A_ThisMenuItem, "Qual é a função do botão 'Atualizar'"))
      ; msgbox SUCESSO com SOM e ICONE alwaysontop
      MsgBox, 4160 , INFORMAÇÃO!, O botão 'Atualizar' tem a função de enviar uma nova requisição HTTP à API do Notion e`, assim`, recarregar os dados na lista., 900
   Else If(InStr(A_ThisMenuItem, "Como controlar o vídeo"))
      ; msgbox SUCESSO com SOM e ICONE alwaysontop
      MsgBox, 4160 , INFORMAÇÃO!, Atalhos:`n`n1. CTRL + L = pause/play`n`n2. ALT + = = speed up`n`n3.ALT + - = speed down`n`n4. ALT + < = Voltar 3s`n`n5. ALT + > = Avançar 3s`n`n6. ALT + END = Next Video`n`n7. ALT + HOME = Previous Video`n`n8. ALT + K = subtitles, 900
Return

/*
--------------------------
--------------------------
--------------------------
--------------------------
--------------------------
--------------------------
--------------------------
--------------------------
*/
/*
TRATAMENTO DA STATUS BAR
*/

/*
   AO CLICAR EM UMA POSIÇÃO DA STATUSBAR
*/
StatusBarLinks:
   Gui Submit, Nohide
   ; msgbox %MyStatusBar%
   ; msgbox %A_EventInfo%
   ; if(A_GuiEvent == "Normal"){
   ;    msgbox %A_EventInfo%
   ; }
   ; recarregar página
   If(A_GuiEvent == "Normal" && A_EventInfo == 2){
      Gosub, #+r
   }Else If(A_GuiEvent == "Normal" && A_EventInfo == 3){
      GoSub, #+a
   }Else If(A_GuiEvent == "Normal" && A_EventInfo == 4){
      Gosub, closechromeahk
   }Else If(A_GuiEvent == "Normal" && A_EventInfo == 5){

      ; Run, "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Default" "https://docs.google.com/spreadsheets/d/1_flbbi427JI7NiIk4ZGZvAM9eRBM4dd_gTDFgw3Npo8/edit#gid=0"
   }
Return

closechromeahk:
   DetectHiddenWindows, On
   SetTitleMatchMode, 2
   GroupAdd, AhkPrograms, .ahk ahk_class AutoHotkey,,,MEU_SCRIPT_FELIPE.ahk
   GroupAdd, AhkPrograms2, .ahk ahk_group AhkPrograms,,,script-notion-felipe
   GroupAdd, AhkPrograms3, .ahk ahk_group AhkPrograms2,,,Paste-Image-To-Screen-TOP
   GroupAdd, AhkPrograms4, .ahk ahk_group AhkPrograms3,,,WindowSnipping
   GroupAdd, AhkPrograms5, .ahk ahk_group AhkPrograms4,,,AHK-GUI-HOTSTRINGS-FELIPE

   GroupAdd, cchrome , ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe
   WinClose, ahk_group cchrome

   Loop {
      WinClose, ahk_group AhkPrograms5
      IfWinNotExist, ahk_group AhkPrograms5
         Break ;No [more] matching windows/processes found
   }
   Notify().AddWindow("Fechei todas instâncias do chrome e todos scripts secundários!",{Time:3000,Icon:177,Background:"0x039018",Title:"Sucesso",TitleColor:"0xF0F8F1", TitleSize:13, Size:13, Color: "0xF0F8F1"},"","setPosBR")
Return
Return
/*
   FUNÇÕES/LABELS DA STATUSBAR
*/
; recarregar página web
#+r:: ; Reload Page Shift+r
:?*:@reload:: ; hotstring @reload
   contador := 0
   escapeDropdownItem := "www.|"
   ; chPath := "C:\Program Files\Google\Chrome\Application\chrome.exe"
   ; IfNotExist, %chPath%
   ; chPath := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
   ; ; profileName = C:\Users\%A_UserName%\AppData\Local\Google\Chrome\User Data

   ; ChromeInst := new Chrome(profileName,websiteInput,"--remote-allow-origins=*",chPath)
   ; msgbox %siteHostNameOnly%
   if !(PageInst := Chrome.GetPage())
   {
      ChromeInst := new Chrome(profileName,"","--remote-debugging-port=9222 --remote-allow-origins=* --profile-directory=""Default""",chPath)
      Notify().AddWindow("Não encontrei o site aberto no Chrome, Vou abrir pra você agora!",{Time:6000,Icon:28,Background:"0x088F8F",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
      contador1 := 0
      while !(PageInst)
      {
         Sleep, 500
         Notify().AddWindow("procurando instância do chrome...!",{Time:6000,Icon:28,Background:"0x1100AA",Title:"ERRO!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
         PageInst := Chrome.GetPageByURL(siteHostNameOnly, "contains")
         contador1++
         if(contador1 >= 5){
            break
         }
      }
   }else{
      PageInst.Call("Page.bringToFront")
      PageInst.Call("Page.reload", {"ignoreCache": Chrome.Jxon_True()})
      ; --- Export a PNG of the page ---

   }
   PageInst.Disconnect()
   Notify().AddWindow("Script " A_ScriptName " Recarregar página",{Time:2000,Icon:238, Background:"0xFFFB03",Title:"ALERTA: Shift+R Pressionado",TitleSize:15, Size:15, Color: "0x524D4D", TitleColor: "0x3E3E3E"},,"setPosBR")
Return

; trazer para frente / alwaysontop Shift+a
#+a:: ; trazer para frente / alwaysontop Shift+a
:?*:@front:: ; hotstring @front
:?*:@alwaysont:: ; hotstring @front
:?*:@bringtofront:: ; hotstring @front
:?*:@chromeactive:: ; hotstring @front
:?*:@chromefront:: ; hotstring @front
   contador := 0
   escapeDropdownItem := "www.|"
   ; chPath := "C:\Program Files\Google\Chrome\Application\chrome.exe"
   ; IfNotExist, %chPath%
   ; chPath := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
   ; profileName = C:\Users\%A_UserName%\AppData\Local\Google\Chrome\User Data

   ; ChromeInst := new Chrome(profileName,websiteInput,"--remote-allow-origins=*",chPath)
   ; msgbox %siteHostNameOnly%
   if !(PageInst := Chrome.GetPage())
   {
      ChromeInst := new Chrome(profileName,"","--remote-debugging-port=9222 --remote-allow-origins=* --profile-directory=""Default""",chPath)
      Notify().AddWindow("Não encontrei o site aberto no Chrome, Vou abrir pra você agora!",{Time:6000,Icon:28,Background:"0x088F8F",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
      contador1 := 0
      while !(PageInst)
      {
         Sleep, 500
         Notify().AddWindow("procurando instância do chrome...!",{Time:6000,Icon:28,Background:"0x1100AA",Title:"ERRO!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
         PageInst := Chrome.GetPageByURL(siteHostNameOnly, "contains")
         contador1++
         if(contador1 >= 7){
            break
         }
      }
   }else{
      PageInst.Call("Page.bringToFront")
      ; PageInst.Call("Page.reload", {"ignoreCache": Chrome.Jxon_True()})
   }
   PageInst.Disconnect()
   Notify().AddWindow("Script " A_ScriptName " trazer página para frente",{Time:2000,Icon:238, Background:"0xFFFB03",Title:"ALERTA: Shift+A Pressionado",TitleSize:15, Size:15, Color: "0x524D4D", TitleColor: "0x3E3E3E"},,"setPosBR")
Return

; * PESQUISAR DADOS NA LISTVIEW
PesquisarDados:
   Gui Submit, NoHide
   /*
      * VARIÁVEIS
   */
   MatchText := VarPesquisarDados ; *Texto inserido no inputbox
   MatchFound := false ; *iniciar variável como false até achar o texto
   cntMatches := 0

   ; !apagar todas as linhas da listview
   GuiControl, -Redraw, LVAll
   LV_Delete()
   ; msgbox % MatchText
   for index, line in StrSplit(dataAllRows, "`n", "`r") ; loop though every row
   {
      ; clipboard := line
      ; msgbox % line
      ; If(InStr(line, MatchText)){
      If(RegexMatch(line, "im)" MatchText)){
         ; msgbox % line
         row := [], ++cnt
         ; * Array com o conteúdo da linha(colunas)
         ; cellValue := RegExReplace(StrSplit(line, A_Tab), aspa, "") ; ! mantive o padrão da captura dos dados da listview, que é separação por tab, assim é melhor pois é comum ter vírgula no título do documento
         loop, parse, line, CSV ; dividir a linha em células
            row.push(a_loopfield)													;or if a_index in 1,4,5
         ; * TÉCNICA PARA INSERIR O ARRAY COMPLETO EM UMA LINHA, CADA ITEM DO ARRAY SERÁ INSERIDO EM UMA COLUNA DIFERENTE
         LV_add("",row*)
         cntMatches++
      }
   }
   SB_SetText("Match(es): " cntMatches, 5)
   GuiControl, +Redraw, LVAll
   GuiControl, Focus, LVAll ; dar foco na listview após pesquisar
   LV_Modify(1)
   LV_Modify(2)
   LV_Modify(1, "+Select") ; selecionar primeiro item da listview
   i++
   If(LV_GetCount() = 0){
      MsgBox, 4112 , Erro!, A Pesquisa não retornou nada`nAtualizando...!, 2
      GoSub, UpdateList
      ; Sleep, 500
      ; Notify().AddWindow("Erro",{Time:3000,Icon:28,Background:"0x990000",Title:"ERRO",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},"w330 h30","setPosBR")
      GuiControl, Focus, BtnPesquisar ; dar foco no botao
   }
   GuiControl,Focus, VarPesquisarDados ; !limpar o inputbox após pesquisar
Return

