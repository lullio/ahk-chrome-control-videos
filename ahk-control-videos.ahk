#Include, <Default_Settings>
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
None|NGINX1||NGINX2|DOM1|DOM2|ARRAYS JS|ASYNC JS|FUNC JS|AJAX|GOOGLE APPS SCRIPT|GTM1|GTM2|GA4
)
ListMainCourses := RTrim(ListMainCourses, "|")
ListMainCourses := StrReplace(ListMainCourses, "|", "||",, 1) ; without default item

; ! TODOS OS CURSOS
ListAllCourses =
(
None|DOM1|DOM2|REGEX|ASYNC JS|FUNC JS|ARRAYS JS|WEB ANALYTICS|COMPLETE JS|JS FULL STACK|AJAX|GOOGLE APPS SCRIPT|DATA STUDIO 1|DATA STUDIO 2|BIG QUERY|POWER BI 1|NGINX1|NGINX2|GTM1|GTM2|GA4
)
ListAllCourses := RTrim(ListAllCourses, "|")
ListAllCourses := StrReplace(ListAllCourses, "|", "||",, 1) ; without default item

; ! WEB DEV COURSES - JAVASCRIPT
ListWebCourses =
(
None|DOM1|DOM2|REGEX|ASYNC JS|FUNC JS|ARRAYS JS|COMPLETE JS|JS FULL STACK|AJAX|GOOGLE APPS SCRIPT
)
ListWebCourses := RTrim(ListWebCourses, "|")
ListWebCourses := StrReplace(ListWebCourses, "|", "||",, 1) ; without default item

; ! MARKETING COURSES - TAGUEAMENTO
ListMktCourses =
(
None|BIG QUERY|DATA STUDIO 1|DATA STUDIO 2|POWER BI 1|NGINX1|NGINX2|WEB ANALYTICS|GTM1|GTM2|GA4
)
ListMktCourses := RTrim(ListMktCourses, "|")
ListMktCourses := StrReplace(ListMktCourses, "|", "||",, 1) ; without default item

; ! OUTROS CURSOS - WEB SERVER / LINUX
ListOutrosCourses =
(
None|NGINX1|NGINX2
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
Gui Add, Text,section y+10 x+100, Main Courses
Gui, Add, ComboBox, x10 y+10 w312 vCurso gCursos hwndCursosIDMain, %ListMainCourses%

/*
COLUNA 1
*/
; dropdown 2 - web dev cursos
Gui Add, Text, section x10,Web Dev Courses
Gui, Add, ComboBox, vCursoWebDev gCursos hwndCursosIDDev w150, %ListWebCourses%
; dropdown 3 - todos os cursos
Gui Add, Text,, All Courses
Gui, Add, ComboBox, vCursoAll gCursos w150 hwndCursosIDAll, %ListAllCourses%

/*
COLUNA 2
*/
; dropdown 4 - mkt cursos
Gui Add, Text, ys, Mkt Courses
Gui, Add, ComboBox, w150 vCursoMkt gCursos hwndCursosIDMkt , %ListMktCourses%
; dropdown 5 - outros cursos
Gui Add, Text,, Other Courses
Gui, Add, ComboBox, vCursoOutros gCursos hwndCursosIDOutros w150, %ListOutrosCourses%

; gui, font, S7 ;Change font size to 12
; 2º dropdown js courses


; Botões
gui, font, S11
gui, Add, Button, xs w100 gAbrirCurso Default, &Abrir Curso
gui, Add, Button, w100 x+10 gAbrirNotion, &Abrir Notion
gui, Add, Button, w75 x+10 gCancel Cancel, &Cancelar

; EXIBIR E ATIVAR GUI
GuiControl,Focus,Curso
Gui, Show,, Abrir Curso e Controlar Video - Felipe Lulio

; Ignorar o erro que o ahk dá e continuar executando o script
ComObjError(false)

; EXECUTAR LOGO AO ABRIR A GUI, PARA EU PODER USAR OS COMANDOS DE VÍDEO MESMO SEM SELECIONAR UM CURSO.
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
      PageInst := Chrome.GetPageByURL(website, "contains")
      Sleep, 500
      /*
      SUPER IMPORTANTE, ATIVAR A TAB/PÁGINA, ACTIVATE, FOCUS
      */
      ; PageInst.Call("Page.bringToFront")
      GoSub, controlVideos
   }else{
      ; PageInst.Evaluate("alert(window.location.pathname)")
   }
   ; msgbox % Chrome.GetPageByURL(website, "contains")[1]

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
gui, NovoCurso:Add, Button, center y+15 x120 w200 h25 gCadastrarCurso Default, &Cadastrar Curso
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
      RunAs, felipe.lullio@hotmail.com, XrLO1000@1010
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
}
Return

courseSelected:
Gui, Submit, NoHide
   if(Curso == "DOM1" || CursoWebDev == "DOM1" || CursoAll == "DOM1" | CursoOutros == "DOM1" || CursoMkt == "DOM1")
      {
         website := "https://www.udemy.com/course/build-interactive-websites-1/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/7ba059f2bff24c89b1af37b7a2da3736?v=c3e4b041d1384185865dc5443c2a2bab&pvs=4"
      }
      else if(Curso = "DOM2" || CursoWebDev = "DOM2" || CursoAll = "DOM2" | CursoOutros = "DOM2" || CursoMkt = "DOM2")
      {
         website := "https://www.udemy.com/course/build-dynamic-websites-dom-2/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/JS-DOM-d4415aaf9eeb41769636c6ee16e18c7a?pvs=4#bc76b9d3415e4bb5909c12701a8b11e2"
      }
      else if(Curso = "ASYNC JS" || CursoWebDev = "ASYNC JS" || CursoAll = "ASYNC JS" | CursoOutros = "ASYNC JS" || CursoMkt = "ASYNC JS")
      {
         website := "https://www.udemy.com/course/asynchronous-javascript-deep-dive/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/JS-Async-b1e1ff048ba446b9a750c99a0561b964?pvs=4#04605a3148744379a89e4ecd3cd8a957"
      }
      else if(Curso = "FUNC JS" || CursoWebDev = "FUNC JS" || CursoAll = "FUNC JS" | CursoOutros = "FUNC JS" || CursoMkt = "FUNC JS")
      {
         website := "https://www.udemy.com/course/functional-programming-in-javascript-a-practical-guide/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/JS-Functions-502abc488dc9492fab8585100472ba30?pvs=4#6c347b0b00794ba583bc10ce86a6c517"
      }
      else if(Curso = "ARRAYS JS" || CursoWebDev = "ARRAYS JS" || CursoAll = "ARRAYS JS" | CursoOutros = "ARRAYS JS" || CursoMkt = "ARRAYS JS")
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
      else if(Curso = "COMPLETE JS" || CursoWebDev = "COMPLETE JS" || CursoAll = "COMPLETE JS" | CursoOutros = "COMPLETE JS" || CursoMkt = "COMPLETE JS")
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
      else if(Curso = "AJAX" || CursoWebDev = "AJAX" || CursoAll = "AJAX" | CursoOutros = "AJAX" || CursoMkt = "AJAX")
      {
         website := "https://www.udemy.com/course/ajax-fundamentals/learn/lecture/"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/Ajax-a44cb3846172447fb20fbe658abec493?pvs=4#03cb8b5860ab4bfb8b51c3167c143077"
      }
      else if(Curso = "GOOGLE APPS SCRIPT" || CursoWebDev = "GOOGLE APPS SCRIPT" || CursoAll = "GOOGLE APPS SCRIPT" | CursoOutros = "GOOGLE APPS SCRIPT" || CursoMkt = "GOOGLE APPS SCRIPT")
      {
         website := "https://www.udemy.com/course/course-apps-script/learn/"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/Google-Apps-Script-d7d4ecbc058c40108576de160a0f8942?pvs=4#88e8a5c8c6764fd085698c93c58be04d"
      }
      else if(Curso = "DATA STUDIO 1" || CursoWebDev = "DATA STUDIO 1" || CursoAll = "DATA STUDIO 1" | CursoOutros = "DATA STUDIO 1" || CursoMkt = "DATA STUDIO 1")
      {
         website := "https://www.udemy.com/course/domine-google-data-studio/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/7ba059f2bff24c89b1af37b7a2da3736?v=c3e4b041d1384185865dc5443c2a2bab&pvs=4"
      }
      else if(Curso = "DATA STUDIO 2" || CursoWebDev = "DATA STUDIO 2" || CursoAll = "DATA STUDIO 2" | CursoOutros = "DATA STUDIO 2" || CursoMkt = "DATA STUDIO 2")
      {
         website := "https://www.udemy.com/course/data-analysis-and-dashboards-with-google-data-studio/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/7ba059f2bff24c89b1af37b7a2da3736?v=c3e4b041d1384185865dc5443c2a2bab&pvs=4"
      }
      else if(Curso = "BIG QUERY" || CursoWebDev = "BIG QUERY" || CursoAll = "BIG QUERY" | CursoOutros = "BIG QUERY" || CursoMkt = "BIG QUERY")
      {
         website := "https://www.udemy.com/course/applied-sql-for-data-analytics-data-science-with-bigquery/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/Big-Query-020d06067e154efa81ab7081f4f0b56c?pvs=4#b256df39ab3e4b40abd422eed10e71fe"
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
      else if(Curso = "NGINX1" || CursoWebDev = "NGINX1" || CursoAll = "NGINX1" | CursoOutros = "NGINX1" || CursoMkt = "NGINX1")
      {
         website := "https://www.udemy.com/course/nginx-fundamentals/learn"
         notion := "notion://www.notion.so/lullio/NGINX-8d3e67e6771742eaa474ca72253d93d1?pvs=4#fcd59bbd427843fbb40099b6957e9be8"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
      }
      else if(Curso = "NGINX2" || CursoWebDev = "NGINX2" || CursoAll = "NGINX2" | CursoOutros = "NGINX2" || CursoMkt = "NGINX2")
      {
         website := "https://www.udemy.com/course/the-perfect-nginx-server-ubuntu-edition/learn"
         pasta := "C:\Users\felipe\Documents\Github\AHK\main-scripts"
         notion := "notion://www.notion.so/lullio/NGINX-7ba5972d67354b4fa8885adfcb6a7ccf?pvs=4#01dc417ce3364b2395bbe81693d2336a"
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
; Return