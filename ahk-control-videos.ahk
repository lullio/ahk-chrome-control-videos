#Include, <Default_Settings>
#Include, C:\Users\%A_UserName%\Downloads\Chrome.ahk

if not A_IsAdmin
   Run *RunAs "%A_ScriptFullPath%"

ListMainCourses =
(
None|NGINX1||NGINX2|DOM1|DOM2|ASYNC JS|FUNC JS|ARRAYS JS|AJAX|GOOGLE APPS SCRIPT
)
ListMainCourses := RTrim(ListMainCourses, "|")
ListMainCourses := StrReplace(ListMainCourses, "|", "||",, 1) ; without default item
ListAllCourses =
(
None|DOM1|DOM2|REGEX|ASYNC JS|FUNC JS|ARRAYS JS|WEB ANALYTICS|COMPLETE JS|JS FULL STACK|AJAX|GOOGLE APPS SCRIPT|DATA STUDIO 1|DATA STUDIO 2|BIG QUERY|POWER BI 1|NGINX1|NGINX2
)
ListAllCourses := RTrim(ListAllCourses, "|")
ListAllCourses := StrReplace(ListAllCourses, "|", "||",, 1) ; without default item
ListWebCourses =
(
None|DOM1|DOM2
)
ListWebCourses := RTrim(ListWebCourses, "|")
ListWebCourses := StrReplace(ListWebCourses, "|", "||",, 1) ; without default item
ListMktCourses =
(
None|DATA STUDIO 2|BIG QUERY|POWER BI 1|NGINX1|NGINX2
)
ListMktCourses := RTrim(ListMktCourses, "|")
ListMktCourses := StrReplace(ListMktCourses, "|", "||",, 1) ; without default item
Gui, Destroy
gui, font, S11 ;Change font size to 12

/*
LINHA 1 - SEPARADO - PRINCIPAIS CURSOS
*/
; dropdown 1 - principais cursos
Gui Add, Text,section y+10 x+100, Principais Cursos
Gui, Add, ComboBox, x10 y+10 w312 vCurso gCursos hwndCursosIDMain, %ListMainCourses%

/*
COLUNA 1
*/
; dropdown 2 - web dev cursos
Gui Add, Text, section x10,Web Dev Courses
Gui, Add, ComboBox, vCursoWebDev gCursos hwndCursosIDDev w150, %ListWebCourses%
; dropdown 3 - todos os cursos
Gui Add, Text,, Todos os Cursos
Gui, Add, ComboBox, vCursoAll gCursos w150 hwndCursosIDAll, %ListAllCourses%

/*
COLUNA 2
*/
; dropdown 4 - mkt cursos
Gui Add, Text, ys, Mkt Courses
Gui, Add, ComboBox, w150 vCursoMkt gCursos hwndCursosIDMkt , %ListMktCourses%
; dropdown 5 - outros cursos
Gui Add, Text,, Outros
Gui, Add, ComboBox, vCursoOutros gCursos hwndCursosIDOutros w150, %ListWebCourses%

; gui, font, S7 ;Change font size to 12
; 2º dropdown js courses


; Botões
gui, font, S11
gui, Add, Button, xs w100 gAbrirCurso Default, &Abrir Curso
gui, Add, Button, w100 x+10 gAbrirPasta, &Abrir Pasta
gui, Add, Button, w75 x+10 gCancel Cancel, &Cancelar

; EXIBIR E ATIVAR GUI
GuiControl,Focus,Curso
Gui, Show

; Ignorar o erro que o ahk dá e continuar executando o script
ComObjError(false)

; EXECUTAR LOGO AO ABRIR A GUI, PARA EU PODER USAR OS COMANDOS DE VÍDEO MESMO SEM SELECIONAR UM CURSO.
website := "udemy.com"
 ; se não encontrar aba chrome com remote debug
 if !(PageInst := Chrome.GetPageByURL(website, "contains"))
   {
     ; não fazer nada
   }else{
         Sleep, 500
         ; aqui está o fix pra esperar a página carregar
         PageInst := Chrome.GetPageByURL(website, "contains")
         Sleep, 500
         /*
         SUPER IMPORTANTE, ATIVAR A TAB/PÁGINA, ACTIVATE, FOCUS
         */
         ; PageInst.Call("Page.bringToFront")

         ; PAUSAR E PLAY VIDEO
      FileRead, javascriptPlay, pause-play-video.js

      ; FAST-FORWARD VIDEO
      FileRead, javascriptMoveUp, video-fast-forward.js
      ; REWIND VIDEO
      FileRead, javascriptMoveDown, video-rewind.js

      ; AUMENTAR VELOCIDADE
      FileRead, javascriptSpeedPlus, speed-increase.js
      ; DIMINUIR VELOCIDADE
      FileRead, javascriptSpeedMinus, speed-decrease.js

      ; PRÓXIMO VÍDEO
      FileRead, javascriptPreviousVideo, go-previous-video.js
      ; VIDEO ANTERIOR
      FileRead, javascriptNextVideo, go-next-video.js      

      alt & l::
         PageInst.Evaluate(javascriptPlay)
         PageInst.Call("Page.bringToFront")
      Return

      Alt & =::
         PageInst.Evaluate(javascriptSpeedPlus)
         PageInst.Call("Page.bringToFront")
      Return

      Alt & -::
         PageInst.Evaluate(javascriptSpeedMinus)
         PageInst.Call("Page.bringToFront")
      Return

      Alt & Left::
         PageInst.Evaluate(javascriptMoveDown)
         PageInst.Call("Page.bringToFront")
      Return

      Alt & Right::
         PageInst.Evaluate(javascriptMoveUp)
         PageInst.Call("Page.bringToFront")
      Return

      Alt & End::
         PageInst.Evaluate(javascriptNextVideo)
         PageInst.Call("Page.bringToFront")
      Return

      Alt & Home::
         PageInst.Evaluate(javascriptPreviousVideo)
         PageInst.Call("Page.bringToFront")
      Return
   }

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
}
Cursos:
      DropDownComplete(CursosIDMain)
      DropDownComplete(CursosIDDev)
      DropDownComplete(CursosIDAll)
      DropDownComplete(CursosIDMkt)
      DropDownComplete(CursosIDOutros)
Return

/* LABEL DO TRATAMENTO DO CURSO, QUAL O CURSO SELECIONADO
*/


/* ABRIR AS ANOTAÇÕES DO NOTION E A PASTA DO PROJETO SE EXISTIR
*/
AbrirPasta:
   Gui, Submit, NoHide
   needle := "None"
   regexp := RegExMatch(Curso, needle)

   if(RegExMatch(curso, needle)){
      Notify().AddWindow("Para abrir a pasta de um projeto você precisa criar um projeto antes",{Time:3000,Icon:28,Background:"0x990000",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR") ;
   }else{
      ; CHAMAR O LABEL courseSelected
      Gosub, courseSelected
      RunAs, felipe.lullio@hotmail.com, XrLO1000@1010
      ; Run, C:\Users\felipe\AppData\Local\Programs\Notion\Notion.exe 
      Run %ComSpec% /c C:\Users\felipe\AppData\Local\Programs\Notion\Notion.exe "%notion%", , Hide
      RunAs
   }
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
if !(website == "none"){
   ; se não encontrar aba chrome com remote debug
   if !(PageInst := Chrome.GetPageByURL(website, "contains"))
   {
      Notify().AddWindow("Não encontrei o site aberto no Chrome, Vou abrir pra você agora!",{Time:6000,Icon:28,Background:"0x990000",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR")
      ; Instance chrome
      ChromeInst := new Chrome(profileName,website,"--remote-debugging-port=9222 --remote-allow-origins=*",chPath)
      PageInst.WaitForLoad("complete")
   }
   Sleep, 500
   ; aqui está o fix pra esperar a página carregar
   PageInst := Chrome.GetPageByURL(website, "contains")
   Sleep, 500
   /*
   SUPER IMPORTANTE, ATIVAR A TAB/PÁGINA, ACTIVATE, FOCUS
   */
   PageInst.Call("Page.bringToFront")
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
      }
      else if(Curso = "ASYNC JS" || CursoWebDev = "ASYNC JS" || CursoAll = "ASYNC JS" | CursoOutros = "ASYNC JS" || CursoMkt = "ASYNC JS")
      {
         website := "https://www.udemy.com/course/asynchronous-javascript-deep-dive/learn"
      }
      else if(Curso = "FUNC JS" || CursoWebDev = "FUNC JS" || CursoAll = "FUNC JS" | CursoOutros = "FUNC JS" || CursoMkt = "FUNC JS")
      {
         website := "https://www.udemy.com/course/functional-programming-in-javascript-a-practical-guide/learn"
      }
      else if(Curso = "ARRAYS JS" || CursoWebDev = "ARRAYS JS" || CursoAll = "ARRAYS JS" | CursoOutros = "ARRAYS JS" || CursoMkt = "ARRAYS JS")
      {
         website := "https://www.udemy.com/course/mastering-javascript-arrays/learn/"
      }
      else if(Curso = "WEB ANALYTISC" || CursoWebDev = "WEB ANALYTISC" || CursoAll = "WEB ANALYTISC" | CursoOutros = "WEB ANALYTISC" || CursoMkt = "WEB ANALYTISC")
      {
         website := "https://www.udemy.com/course/webanalytics-completo-muito-alem-do-google-analytics/learn"
      }
      else if(Curso = "COMPLETE JS" || CursoWebDev = "COMPLETE JS" || CursoAll = "COMPLETE JS" | CursoOutros = "COMPLETE JS" || CursoMkt = "COMPLETE JS")
      {
         website := "https://www.udemy.com/course/the-complete-javascript-course/learn/lecture"
      }
      else if(Curso = "JS FULL STACK" || CursoWebDev = "JS FULL STACK" || CursoAll = "JS FULL STACK" | CursoOutros = "JS FULL STACK" || CursoMkt = "JS FULL STACK")
      {
         website := "https://www.udemy.com/course/learn-javascript-full-stack-from-scratch/learn"
      }
      else if(Curso = "AJAX" || CursoWebDev = "AJAX" || CursoAll = "AJAX" | CursoOutros = "AJAX" || CursoMkt = "AJAX")
      {
         website := "https://www.udemy.com/course/ajax-fundamentals/learn/lecture/"
      }
      else if(Curso = "GOOGLE APPS SCRIPT" || CursoWebDev = "GOOGLE APPS SCRIPT" || CursoAll = "GOOGLE APPS SCRIPT" | CursoOutros = "GOOGLE APPS SCRIPT" || CursoMkt = "GOOGLE APPS SCRIPT")
      {
         website := "https://www.udemy.com/course-dashboard-redirect/?course_id=3646911"
      }
      else if(Curso = "GOOGLE APPS SCRIPT" || CursoWebDev = "GOOGLE APPS SCRIPT" || CursoAll = "GOOGLE APPS SCRIPT" | CursoOutros = "GOOGLE APPS SCRIPT" || CursoMkt = "GOOGLE APPS SCRIPT")
      {
         website := "https://www.udemy.com/course/course-apps-script/learn/"
      }
      else if(Curso = "DATA STUDIO 1" || CursoWebDev = "DATA STUDIO 1" || CursoAll = "DATA STUDIO 1" | CursoOutros = "DATA STUDIO 1" || CursoMkt = "DATA STUDIO 1")
      {
         website := "https://www.udemy.com/course/domine-google-data-studio/learn"
      }
      else if(Curso = "DATA STUDIO 2" || CursoWebDev = "DATA STUDIO 2" || CursoAll = "DATA STUDIO 2" | CursoOutros = "DATA STUDIO 2" || CursoMkt = "DATA STUDIO 2")
      {
         website := "https://www.udemy.com/course/data-analysis-and-dashboards-with-google-data-studio/learn"
      }
      else if(Curso = "BIG QUERY" || CursoWebDev = "BIG QUERY" || CursoAll = "BIG QUERY" | CursoOutros = "BIG QUERY" || CursoMkt = "BIG QUERY")
      {
         website := "https://www.udemy.com/course/applied-sql-for-data-analytics-data-science-with-bigquery/learn"
      }
      else if(Curso = "POWER BI 1" || CursoWebDev = "POWER BI 1" || CursoAll = "POWER BI 1" | CursoOutros = "POWER BI 1" || CursoMkt = "POWER BI 1")
      {
         website := "https://www.udemy.com/course/power-bi-completo-do-basico-ao-avancado/learn"
      }
      else if(Curso = "REGEX" || CursoWebDev = "REGEX" || CursoAll = "REGEX" | CursoOutros = "REGEX" || CursoMkt = "REGEX")
      {
         website := "https://www.udemy.com/course/mastering-regular-expressions-in-javascript/learn"
      }
      else if(Curso = "NGINX1" || CursoWebDev = "NGINX1" || CursoAll = "NGINX1" | CursoOutros = "NGINX1" || CursoMkt = "NGINX1")
      {
         website := "https://www.udemy.com/course/nginx-fundamentals/learn"
         notion := "notion://www.notion.so/lullio/NGINX-8d3e67e6771742eaa474ca72253d93d1?pvs=4#b84456c982f74fb6b1ff5e23064a579b"
      }
      else if(Curso = "NGINX2" || CursoWebDev = "NGINX2" || CursoAll = "NGINX2" | CursoOutros = "NGINX2" || CursoMkt = "NGINX2")
      {
         website := "https://www.udemy.com/course/the-perfect-nginx-server-ubuntu-edition/learn"
      }else{
         website := "none"
      }
Return