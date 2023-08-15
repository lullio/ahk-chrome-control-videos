﻿#Include, <Default_Settings>
; #SingleInstance, force
#Include, C:\Users\%A_UserName%\Downloads\Chrome.ahk

if not A_IsAdmin
   Run *RunAs "%A_ScriptFullPath%"

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
; !PRINCIPAIS CURSOS
ListMainCourses =
(
None|NGINX-1||NGINX-2|DOM-1|DOM-2|JS - ARRAY|JS - ASYNC|JS - FUNC|JS - AJAX|JS - GOOGLE APPS SCRIPT|ANALYTICS BQ - ANALISAR DADOS NO BQ|ANALYTICS BQ - CONSTRUIR DASHBOARD NO BQ|ANALYTICS BQ - APPLIED SQL WITH BQ|GTM1|GTM2|GA4|YT AHK API|ANALYTICS LS - DATA STUDIO pt-br|ANALYTICS LS - DATA STUDIO en-us
)
ListMainCourses := RTrim(ListMainCourses, "|")
ListMainCourses := StrReplace(ListMainCourses, "|", "||",, 1) ; without default item

; ; ! TODOS OS CURSOS
; FileRead, cursos, C:\Users\Felipe\Desktop\courses.txt
; /*
;    magica para não precisar colocar o template aqui como variável, esse transform deref permite ler o código do arquivo ahkTemplate-init-tagueamento.ahk como expressão, substitui as variáveis que estão no arquivo.
; */
; Transform, cursos, deref, % cursos

; Loop, % arr.Length()
;    {
;        msgbox % arr["courseName"]
;    }
;    MsgBox, The end of the file has been reached or there was a problem.
;    return

ListAllCourses := 
(
None|DOM-1|DOM-2|REGEX|JS - ASYNC|JS - FUNC|JS - ARRAY|WEB ANALYTICS|JS - COMPLETE JS COURSE JONAS|JS FULL STACK|JS - AJAX|JS - GOOGLE APPS SCRIPT|ANALYTICS LS - DATA STUDIO pt-br|ANALYTICS LS - DATA STUDIO en-us|ANALYTICS BQ - APPLIED SQL WITH BQ|POWER BI 1|NGINX-1|NGINX-2|GTM1|GTM2|GA4
)
ListAllCourses := RTrim(ListAllCourses, "|")
ListAllCourses := StrReplace(ListAllCourses, "|", "||",, 1) ; without default item

; ! WEB DEV COURSES - JAVASCRIPT
ListWebCourses =
(
None|DOM-1|DOM-2|REGEX|JS - ASYNC|JS - FUNC|JS - ARRAY|JS - COMPLETE JS COURSE JONAS|JS FULL STACK|JS - AJAX|JS - GOOGLE APPS SCRIPT
)
ListWebCourses := RTrim(ListWebCourses, "|")
ListWebCourses := StrReplace(ListWebCourses, "|", "||",, 1) ; without default item

; ! MARKETING COURSES - TAGUEAMENTO
ListMktCourses =
(
None|ANALYTICS BQ - APPLIED SQL WITH BQ|ANALYTICS LS - DATA STUDIO pt-br|ANALYTICS LS - DATA STUDIO en-us|POWER BI 1|NGINX-1|NGINX-2|WEB ANALYTICS|GTM1|GTM2|GA4
)
ListMktCourses := RTrim(ListMktCourses, "|")
ListMktCourses := StrReplace(ListMktCourses, "|", "||",, 1) ; without default item

; ! OUTROS CURSOS - WEB SERVER / LINUX
ListOutrosCourses =
(
None|NGINX-1|NGINX-2|LINUX - SAMBA SERVER 1|LINUX - SAMBA SERVER 2
)
ListOutrosCourses := RTrim(ListOutrosCourses, "|")
ListOutrosCourses := StrReplace(ListOutrosCourses, "|", "||",, 1) ; without default item

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
Gui Add, Text,section y+10 , Main Courses
Gui, Add, ComboBox, x10 y+10 w510 vCurso gCursos hwndCursosIDMain, %ListMainCourses%

/*
COLUNA 1
*/
; dropdown 2 - web dev cursos
Gui Add, Text, section x10,Web Dev Courses
Gui, Add, ComboBox, vCursoWebDev gCursos hwndCursosIDDev w250, %ListWebCourses%
; dropdown 3 - todos os cursos
Gui Add, Text,, All Courses
Gui, Add, ComboBox, vCursoAll gCursos w250 hwndCursosIDAll, %ListAllCourses%

/*
COLUNA 2
*/
; dropdown 4 - mkt cursos
Gui Add, Text, ys, Mkt Courses
Gui, Add, ComboBox, w250 vCursoMkt gCursos hwndCursosIDMkt , %ListMktCourses%
; dropdown 5 - outros cursos
Gui Add, Text,, Other Courses
Gui, Add, ComboBox, vCursoOutros gCursos hwndCursosIDOutros w250, %ListOutrosCourses%

; gui, font, S7 ;Change font size to 12
; 2º dropdown js courses
Gui, Add, GroupBox, xs cBlack r21 w560, Executar Ações (Cuidado)
Gui Add, Text, yp+25 xp+11 center, Selecione um Template ou Cole uma URL Google Sheets:
Gui Font, S10
Gui Add, ComboBox, xs+10 yp+20 w372 center vTemplateDimensoes hwndDimensoesID ,Versão 1 - Parâmetros de Elemento (pt-br-new)||Versão 2 - Parâmetros de Blog (en-us-old)|Versão 3 - Parâmetros Antigos Flow Step (pt-br-old)|Template Vazio
Gui Add, Button, x+20  w135 h24, Atualizar Tabela
Gui Font,
Gui Add, ListView, vListaDimensions w530 r12 xs+10 y+10 -readonly grid sort , Curso|URL|Categories|Nota
; LV_Modify()
Gui Font, S6.5
Gui Add, Link, w120 y+3 xp+200 vTotalDimensoes center,

Gui Font, S11
gui Add, Button, w300  xs+120 yp+25, &Criar Todas Dimensões
gui Add, Button, cGreen w150 xp y+5  , &Excluir tudo
gui Add, Button, w150 x+5 , &Excluir algumas

; Botões
gui, font, S11
gui, Add, Button, y+10 xs w250 h35 gAbrirCurso Default, &Abrir Curso
gui, Add, Button, w150 h35 x+10 gAbrirNotion, &Abrir Notion
gui, Add, Button, w95 h35 x+10 gCancel Cancel, &Cancelar

; EXIBIR E ATIVAR GUI
GuiControl,Focus,Curso
Gui, Show,, Abrir Curso e Controlar Video - Felipe Lulio
ComObjError(false)
GoSub, getData
website := "udemy.com"
if(Chrome.GetPageByURL(website, "contains")){
   website := "udemy.com"
}else{
   website := "youtube.com"
}
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

; Gosub, firstStep
; msgbox % Chrome.GetPageByURL(website, "contains")[1]

; EXECUTAR LOGO AO ABRIR A GUI, PARA EU PODER USAR OS COMANDOS DE VÍDEO MESMO SEM SELECIONAR UM CURSO.

; Ignorar o erro que o ahk dá e continuar executando o script
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

/* LABEL DO TRATAMENTO DO CURSO, QUAL O CURSO SELECIONADO
*/


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
      Gosub, courseSelected
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

AbrirCurso:
   Gui, Submit, NoHide
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
Gosub, courseSelected
; msgbox %website%
if !(website == "none") AND !(Curso == "GTM1") AND !(Curso == "GTM2") AND !(Curso == "GA4") AND !(CursoMkt == "GTM1") AND !(CursoMkt == "GTM2") AND !(CursoMkt == "GA4") AND !(CursoAll == "GTM1") AND !(CursoAll == "GTM2") AND !(CursoAll == "GA4") AND !(CursoOutros == "GTM1") AND !(CursoOutros == "GTM2") AND !(CursoOutros == "GA4"){
   ; se não encontrar aba chrome com remote debug
   if !(PageInst := Chrome.GetPageByURL(website, "contains"))
   {
      ; Instance chrome
      ChromeInst := new Chrome(profileName,website,"--remote-debugging-port=9222 --remote-allow-origins=*",chPath)
      PageInst.WaitForLoad("complete")
      PageInst.Call("Page.bringToFront")
      Notify().AddWindow("Não encontrei o site aberto no Chrome, Vou abrir pra você agora!",{Time:6000,Icon:28,Background:"0x990000",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
   }
   Sleep, 500
   ; aqui está o fix pra esperar a página carregar
   PageInst := Chrome.GetPageByURL(website, "contains")
   Sleep, 500
   /*
   SUPER IMPORTANTE, ATIVAR A TAB/PÁGINA, ACTIVATE, FOCUS
   */
   PageInst.Call("Page.bringToFront")
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
Return

courseSelected:
Gui, Submit, NoHide
   if(Curso == "DOM-1" || CursoWebDev == "DOM-1" || CursoAll == "DOM-1" | CursoOutros == "DOM-1" || CursoMkt == "DOM-1")
      {
         website := "https://www.udemy.com/course/build-interactive-websites-1/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/7ba059f2bff24c89b1af37b7a2da3736?v=c3e4b041d1384185865dc5443c2a2bab&pvs=4"
      }
      else if(Curso = "DOM-2" || CursoWebDev = "DOM-2" || CursoAll = "DOM-2" | CursoOutros = "DOM-2" || CursoMkt = "DOM-2")
      {
         website := "https://www.udemy.com/course/build-dynamic-websites-dom-2/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/JS-DOM-d4415aaf9eeb41769636c6ee16e18c7a?pvs=4#bc76b9d3415e4bb5909c12701a8b11e2"
      }
      else if(Curso = "JS - ASYNC" || CursoWebDev = "JS - ASYNC" || CursoAll = "JS - ASYNC" | CursoOutros = "JS - ASYNC" || CursoMkt = "JS - ASYNC")
      {
         website := "https://www.udemy.com/course/asynchronous-javascript-deep-dive/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/JS-Async-b1e1ff048ba446b9a750c99a0561b964?pvs=4#04605a3148744379a89e4ecd3cd8a957"
      }
      else if(Curso = "JS - FUNC" || CursoWebDev = "JS - FUNC" || CursoAll = "JS - FUNC" | CursoOutros = "JS - FUNC" || CursoMkt = "JS - FUNC")
      {
         website := "https://www.udemy.com/course/functional-programming-in-javascript-a-practical-guide/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/JS-Functions-502abc488dc9492fab8585100472ba30?pvs=4#6c347b0b00794ba583bc10ce86a6c517"
      }
      else if(Curso = "JS - ARRAY" || CursoWebDev = "JS - ARRAY" || CursoAll = "JS - ARRAY" | CursoOutros = "JS - ARRAY" || CursoMkt = "JS - ARRAY")
      {
         website := "https://www.udemy.com/course/mastering-javascript-arrays/learn/"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/JS-Arrays-d00d5b61063c4e009c3f763cd5061cff?pvs=4#c61684276e91400f95dcc194c2aefca1"
      }
      else if(Curso = "WEB ANALYTISC" || CursoWebDev = "WEB ANALYTISC" || CursoAll = "WEB ANALYTISC" | CursoOutros = "WEB ANALYTISC" || CursoMkt = "WEB ANALYTISC")
      {
         website := "https://www.udemy.com/course/webanalytics-completo-muito-alem-do-google-analytics/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/GA3-Udemy-2b20d3b404c646a8b68376f7f8ea179e?pvs=4#694be6e93d9b4b918017fdf37094b57d"
      }
      else if(Curso = "JS - COMPLETE JS COURSE JONAS" || CursoWebDev = "JS - COMPLETE JS COURSE JONAS" || CursoAll = "JS - COMPLETE JS COURSE JONAS" | CursoOutros = "JS - COMPLETE JS COURSE JONAS" || CursoMkt = "JS - COMPLETE JS COURSE JONAS")
      {
         website := "https://www.udemy.com/course/the-complete-javascript-course/learn/lecture"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/Complete-JS-C-c245dd6c4f9a43f8832dc64885b1e825?pvs=4#80de55c25c834079953f41663a137ced"
      }
      else if(Curso = "JS FULL STACK" || CursoWebDev = "JS FULL STACK" || CursoAll = "JS FULL STACK" | CursoOutros = "JS FULL STACK" || CursoMkt = "JS FULL STACK")
      {
         website := "https://www.udemy.com/course/learn-javascript-full-stack-from-scratch/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/Node-JS-ac151bb66604406fb76348d6fac43776?pvs=4#d8995e38ced9466f88778e8328c022ef"
      }
      else if(Curso = "JS - AJAX" || CursoWebDev = "JS - AJAX" || CursoAll = "JS - AJAX" | CursoOutros = "JS - AJAX" || CursoMkt = "JS - AJAX")
      {
         website := "https://www.udemy.com/course/JS - AJAX-fundamentals/learn/lecture/"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/JS - AJAX-a44cb3846172447fb20fbe658abec493?pvs=4#03cb8b5860ab4bfb8b51c3167c143077"
      }
      else if(Curso = "JS - GOOGLE APPS SCRIPT" || CursoWebDev = "JS - GOOGLE APPS SCRIPT" || CursoAll = "JS - GOOGLE APPS SCRIPT" | CursoOutros = "JS - GOOGLE APPS SCRIPT" || CursoMkt = "JS - GOOGLE APPS SCRIPT")
      {
         website := "https://www.udemy.com/course/course-apps-script/learn/"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/Google-Apps-Script-d7d4ecbc058c40108576de160a0f8942?pvs=4#88e8a5c8c6764fd085698c93c58be04d"
      }
      else if(Curso = "ANALYTICS LS - DATA STUDIO pt-br" || CursoWebDev = "ANALYTICS LS - DATA STUDIO pt-br" || CursoAll = "ANALYTICS LS - DATA STUDIO pt-br" | CursoOutros = "ANALYTICS LS - DATA STUDIO pt-br" || CursoMkt = "ANALYTICS LS - DATA STUDIO pt-br")
      {
         website := "https://www.udemy.com/course/domine-google-data-studio/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/7ba059f2bff24c89b1af37b7a2da3736?v=c3e4b041d1384185865dc5443c2a2bab&pvs=4"
      }
      else if(Curso = "ANALYTICS LS - DATA STUDIO en-us" || CursoWebDev = "ANALYTICS LS - DATA STUDIO en-us" || CursoAll = "ANALYTICS LS - DATA STUDIO en-us" | CursoOutros = "ANALYTICS LS - DATA STUDIO en-us" || CursoMkt = "ANALYTICS LS - DATA STUDIO en-us")
      {
         website := "https://www.udemy.com/course/data-analysis-and-dashboards-with-google-data-studio/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/7ba059f2bff24c89b1af37b7a2da3736?v=c3e4b041d1384185865dc5443c2a2bab&pvs=4"
      }
      else if(Curso = "ANALYTICS BQ - APPLIED SQL WITH BQ" || CursoWebDev = "ANALYTICS BQ - APPLIED SQL WITH BQ" || CursoAll = "ANALYTICS BQ - APPLIED SQL WITH BQ" | CursoOutros = "ANALYTICS BQ - APPLIED SQL WITH BQ" || CursoMkt = "ANALYTICS BQ - APPLIED SQL WITH BQ")
      {
         website := "https://www.udemy.com/course/applied-sql-for-data-analytics-data-science-with-bigquery/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/Big-Query-020d06067e154efa81ab7081f4f0b56c?pvs=4#b256df39ab3e4b40abd422eed10e71fe"
      }
      else if(Curso = "ANALYTICS BQ - ANALISAR DADOS NO BQ" || CursoWebDev = "ANALYTICS BQ - ANALISAR DADOS NO BQ" || CursoAll = "ANALYTICS BQ - ANALISAR DADOS NO BQ" | CursoOutros = "ANALYTICS BQ - ANALISAR DADOS NO BQ" || CursoMkt = "ANALYTICS BQ - ANALISAR DADOS NO BQ")
      {
         website := "https://www.udemy.com/course/curso-completo-sql-para-analise-de-dados/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/BigQuery-ac25d6e8937e4cc681ccdab7c2c1f037?pvs=4"
      }
      else if(Curso = "ANALYTICS BQ - CONSTRUIR DASHBOARD NO BQ" || CursoWebDev = "ANALYTICS BQ - CONSTRUIR DASHBOARD NO BQ" || CursoAll = "ANALYTICS BQ - CONSTRUIR DASHBOARD NO BQ" | CursoOutros = "ANALYTICS BQ - CONSTRUIR DASHBOARD NO BQ" || CursoMkt = "ANALYTICS BQ - CONSTRUIR DASHBOARD NO BQ")
      {
         website := "https://www.udemy.com/course/criacao-de-dashboards-com-google-data-studio/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/BigQuery-ac25d6e8937e4cc681ccdab7c2c1f037?pvs=4"
      }
      else if(Curso = "POWER BI 1" || CursoWebDev = "POWER BI 1" || CursoAll = "POWER BI 1" | CursoOutros = "POWER BI 1" || CursoMkt = "POWER BI 1")
      {
         website := "https://www.udemy.com/course/power-bi-completo-do-basico-ao-avancado/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/Power-BI-2f9229501549428f95e8ae5a410c51ca?pvs=4#2e615e5e0bfe4b0ba73bf35f1522cd654"
      }
      else if(Curso = "REGEX" || CursoWebDev = "REGEX" || CursoAll = "REGEX" | CursoOutros = "REGEX" || CursoMkt = "REGEX")
      {
         website := "https://www.udemy.com/course/mastering-regular-expressions-in-javascript/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/RegExp-JS-d9b4e89ab9584f2daef737e3156fe4b1?pvs=4"
      }
      else if(Curso = "NGINX-1" || CursoWebDev = "NGINX-1" || CursoAll = "NGINX-1" | CursoOutros = "NGINX-1" || CursoMkt = "NGINX-1")
      {
         website := "https://www.udemy.com/course/nginx-fundamentals/learn"
         notion := "notion://www.notion.so/lullio/NGINX-8d3e67e6771742eaa474ca72253d93d1?pvs=4#fcd59bbd427843fbb40099b6957e9be8"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
      }
      else if(Curso = "NGINX-2" || CursoWebDev = "NGINX-2" || CursoAll = "NGINX-2" | CursoOutros = "NGINX-2" || CursoMkt = "NGINX-2")
      {
         website := "https://www.udemy.com/course/the-perfect-nginx-server-ubuntu-edition/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/NGINX-7ba5972d67354b4fa8885adfcb6a7ccf?pvs=4#01dc417ce3364b2395bbe81693d2336a"
      }
      else if(Curso = "YT AHK API" || CursoWebDev = "YT AHK API" || CursoAll = "YT AHK API" | CursoOutros = "YT AHK API" || CursoMkt = "YT AHK API")
      {
         website := "https://www.youtube.com/watch?v=86S-bWS_smM&list=PL3JprvrxlW242fgxzzavJM7lRkCB90y4R&index=1"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/AHK-API-3112a6db91cc4ebb8823200980c10ef7?pvs=4"
      }
      else if(Curso = "GTM1" || CursoWebDev = "GTM1" || CursoAll = "GTM1" | CursoOutros = "GTM1" || CursoMkt = "GTM1")
      {
         gtm1Folder := "Y:\Season\Analyticsmania\Google Tag Manager Masterclass For Beginners 3.0"
         if !FileExist(gtm1Folder)
         {
            gtm1Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Google Tag Manager Masterclass For Beginners 3.0"
         }
         website = Run %gtm1Folder%
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/Google-Tag-Manager-5cb91cdde3e943f9b2b05a43e38237c1?pvs=4#37281bf8a5b54405885e2d16aac97806"
      }
      else if(Curso = "GTM2" || CursoWebDev = "GTM2" || CursoAll = "GTM2" | CursoOutros = "GTM2" || CursoMkt = "GTM2")
      {
         gtm2Folder := "Y:\Season\Analyticsmania\Intermediate Google Tag Manager Advanced Topics 2.0"
         if !FileExist(gtm2Folder)
         {
            gtm2Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Intermediate Google Tag Manager Advanced Topics 2.0"
         }
         website := "https://www.udemy.com/course/the-perfect-nginx-server-ubuntu-edition/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/Google-Tag-Manager-5cb91cdde3e943f9b2b05a43e38237c1?pvs=4#fa0f4c0ad533433eb3b2f6e439623d76"
      }
      else if(Curso = "GA4" || CursoWebDev = "GA4" || CursoAll = "GA4" | CursoOutros = "GA4" || CursoMkt = "GA4")
      {
         GA4Folder := "Y:\Season\Analyticsmania\Google Analytics 4 Course"
         if !FileExist(GA4Folder)
         {
           GA4Folder := "C:\Users\" A_UserName "\Documents\Season\Analyticsmania\Google Analytics 4 Course"
         }
         website := "https://www.udemy.com/course/the-perfect-nginx-server-ubuntu-edition/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/GA4-AM-2c2c777ac2a04c388a5ef9bbaea2259d?pvs=4#c962d7277c754ce88b987e179122b521"
      }
      else{
         website := "none"
      }
return

; CONTROL VIDEOS
controlVideos:
; FileRead, javascriptPlay, pause-play-video.js
; PageInst.Evaluate(javascriptPlay)
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
   Return SubStr(googleSheetData, 2,-1) ; remove o primeiro e último catactere (as aspas)
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
      ; ; TRATAR PELA URL DA PLANILHA
      ; Else{
      ;     if(RegExMatch(templateDimensoes, "i).*docs.google.com/.+\/d\/.+\/")){
      ;       RegExMatch(templateDimensoes, "i).*\/d\/.+\/", UrlCode) 
      ;       ; msgbox % UrlCode

      ;       ; msgbox % UrlCode "gviz/tq?tqx=out:csv"
      ;       urlData = %UrlCode%gviz/tq?tqx=out:csv&range=A2:C150
      ;       ; urlData =  %UrlCode%gviz/tq?tqx=out:csv&range=A3:Z3
      ;       ; msgbox %urlData%
      ;       ; pegar as 3 linhas cm tds arrays js do google sheet
      ;       urlAllArr = %UrlCode%gviz/tq?tqx=out:csv&range=E1:E3
      ;       ; msgbox %urlAllArr%
      ;       urlArrDimension = %UrlCode%gviz/tq?tqx=out:csv&range=E1
      ;       urlArrDesc = %UrlCode%gviz/tq?tqx=out:csv&range=E2
      ;       urlArrScope = %UrlCode%gviz/tq?tqx=out:csv&range=E3
      ;     }else{
      ;       MsgBox, 4112 , Erro na URL do Site!, URL Inválida`n- Copie e Cole uma URL do Google Sheets válida!
      ;     }
          
      ; }
      ; msgbox % urlArrDimension
      ; msgbox % urlArrDesc

   ; todos os dados
   dataAllRows := getDataFromGoogleSheet(urlData)
   ; msgbox % dataAllRows
   ; remover aspas inicial e final
   javascriptArrays := RegExReplace(getDataFromGoogleSheet(urlAllArr), "mi)" aspa, "")
   ; msgbox js: %javascriptArrays%

   Loop, parse, dataAllRows, `n, `r ; linha
      {
          LineNumber := A_Index
         ;  msgbox, % Coluna1 := StrSplit(A_LoopField,",")[1] ; 1 coluna Nome da dimensão
         SemAspa := RegExReplace(A_LoopField, aspa , "")
         Coluna1 := StrSplit(A_LoopField,",")[1] ; 1 coluna courseName
         Coluna2 := StrSplit(A_LoopField,",")[2] ; 2 coluna courseURL
         Coluna3 := StrSplit(A_LoopField,",")[3] ; 3 coluna courseCategories
         Coluna4 := StrSplit(A_LoopField,",")[4] ; 4 coluna courseProvider
         Coluna5 := StrSplit(A_LoopField,",")[5] ; 5 coluna courseLength
         Coluna6 := StrSplit(A_LoopField,",")[6] ; 6 coluna courseRating
         ;  msgbox % coluna1
         ;  Coluna1SemAspas := StrReplace(Coluna1, aspa, "")
         ;  Coluna2SemAspas := StrReplace(Coluna2, aspa, "")
         ;  Coluna3SemAspas := StrReplace(Coluna3, aspa, "")
          LV_Add("" , SubStr(Coluna1, 2,-1), SubStr(Coluna2, 2,-1), SubStr(Coluna3, 2,-1), SubStr(Coluna4, 2,-1), SubStr(Coluna5, 2,-1))
         ;  Loop, parse, data, CSV ; coluna
         ;  {
         ;      MsgBox, 4, , %Postition% Field %LineNumber%-%A_Index% is:`n%A_LoopField%`n`nContinue?
         ;      IfMsgBox, No
         ;          return
         ;  }
         If InStr(Coluna2, "sql")
         ListVar2 .= StrSplit(A_LoopField,",")[1] "|"
         
      } 
      GuiControl,1:, CursoWebDev, %ListVar2%
      ; ajustar largura
      LV_ModifyCol(3,0)
      LV_ModifyCol(1)
      LV_ModifyCol(2)
      ; ordenar
      ; LV_ModifyCol(1, sort, "integer")
      ; LV_ModifyCol(1, "text")

      ; exibir total de linhas
      totalLines := LV_GetCount()
      GuiControl, , TotalDimensoes, Total de Dimensões: %totalLines%
Return