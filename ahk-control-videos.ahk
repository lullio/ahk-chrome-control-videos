#Include, <Default_Settings>
#Include, C:\Users\%A_UserName%\Downloads\Chrome.ahk

if not A_IsAdmin
   Run *RunAs "%A_ScriptFullPath%"

ListNotes =
(
DOM1|DOM2|REGEX|ASYNC JS|FUNC JS|ARRAYS JS|WEB ANALYTICS|COMPLETE JS|JS FULL STACK|AJAX|GOOGLE APPS SCRIPT|DATA STUDIO 1||DATA STUDIO 2|BIG QUERY|POWER BI 1|NGINX1|NGINX2
)

ListNotes := RTrim(ListNotes, "|")
ListNotes := StrReplace(ListNotes, "|", "||",, 1) ; without default item
Gui, Destroy
gui, font, S11 ;Change font size to 12
Gui, Add, ComboBox, w250 vCurso gNOTES hwndNotesID , %ListNotes%
gui, Add, Button, w90 gAbrirCurso Default, &Abrir Curso
gui, Add, Button, w75 x+8 gCancel Cancel, &Cancelar
GuiControl,Focus,notes
Gui, Show
; Ignorar o erro que o ahk dá e continuar executando o script
ComObjError(false)

website := "udemy.com"
 ; se não encontrar aba chrome com remote debug
 if !(PageInst := Chrome.GetPageByURL(website, "contains"))
   {
     ; não fazer nada
   }else{
      msgbox ok
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

NOTES:
   {
      ControlGetText, Eingabe,, ahk_id %NotesID%
      ControlGet, Liste, List, , , ahk_id %NotesID%
      ; msgbox %Liste%
      ; msgbox %Eingabe%
      ; If ( !GetKeyState("Delete") && !GetKeyState("BackSpace") && RegExMatch(Liste, "`nmi)^(www\.)?(\Q" . Eingabe . "\E.*)$", Match)) {
      If ( !GetKeyState("Delete") && !GetKeyState("BackSpace") && RegExMatch(Liste, "`nmi)^(\Q" . Eingabe . "\E.*)$", Match)) {
         ; msgbox %match%
         ; msgbox %match1% ; armazena o www.
         ; msgbox %match2% ; armazena o restante sem o www.
         ControlSetText, , %Match%, ahk_id %NotesID% ; insere o texto no combobox
         Selection := StrLen(Eingabe) | 0xFFFF0000 ; tamanho do texto do match
         ; msgbox %Selection%
         SendMessage, CB_SETEDITSEL := 0x142, , Selection, , ahk_id %NotesID% ; colocar o cursor do mouse selecionando o texto do match
      } Else {
         CheckDelKey = 0
         CheckBackspaceKey = 0
      }
      return
   }


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

   if(Curso = "DOM1")
   {
      website := "https://www.udemy.com/course/build-interactive-websites-1/"
   }
   else if(Curso = "DOM2")
   {
      website := "https://www.udemy.com/course/build-dynamic-websites-dom-2/learn"
   }
   else if(Curso = "ASYNC JS")
   {
      website := "https://www.udemy.com/course/asynchronous-javascript-deep-dive/learn"
   }
   else if(Curso = "FUNC JS")
   {
      website := "https://www.udemy.com/course/functional-programming-in-javascript-a-practical-guide/learn"
   }
   else if(Curso = "ARRAYS JS")
   {
      website := "https://www.udemy.com/course/mastering-javascript-arrays/learn/"
   }
   else if(Curso = "WEB ANALYTISC")
   {
      website := "https://www.udemy.com/course/webanalytics-completo-muito-alem-do-google-analytics/learn"
   }
   else if(Curso = "COMPLETE JS")
   {
      website := "https://www.udemy.com/course/the-complete-javascript-course/learn/lecture"
   }
   else if(Curso = "JS FULL STACK")
   {
      website := "https://www.udemy.com/course/learn-javascript-full-stack-from-scratch/learn"
   }
   else if(Curso = "AJAX")
   {
      website := "https://www.udemy.com/course/ajax-fundamentals/learn/lecture/"
   }
   else if(Curso = "GOOGLE APPS SCRIPT")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=3646911"
   }
   else if(Curso = "GOOGLE APPS SCRIPT")
   {
      website := "https://www.udemy.com/course/course-apps-script/learn/"
   }
   else if(Curso = "DATA STUDIO 1")
   {
      website := "https://www.udemy.com/course/domine-google-data-studio/learn"
   }
   else if(Curso = "DATA STUDIO 2")
   {
      website := "https://www.udemy.com/course/data-analysis-and-dashboards-with-google-data-studio/learn"
   }
   else if(Curso = "BIG QUERY")
   {
      website := "https://www.udemy.com/course/applied-sql-for-data-analytics-data-science-with-bigquery/learn"
   }
   else if(Curso = "POWER BI 1")
   {
      website := "https://www.udemy.com/course/power-bi-completo-do-basico-ao-avancado/learn"
   }
   else if(Curso = "REGEX")
   {
      website := "https://www.udemy.com/course/mastering-regular-expressions-in-javascript/learn"
   }
   else if(Curso = "NGINX1")
   {
      website := "https://www.udemy.com/course/nginx-fundamentals/learn"
   }
   else if(Curso = "NGINX2")
   {
      website := "https://www.udemy.com/course/the-perfect-nginx-server-ubuntu-edition/learn"
   }

   ; se não encontrar aba chrome com remote debug
   if !(PageInst := Chrome.GetPageByURL(website, "contains"))
   {
      Notify().AddWindow("Não encontrei o site aberto no Chrome, Vou abrir pra você agora!",{Time:6000,Icon:28,Background:"0x990000",Title:"OPS!",TitleSize:15, Size:15, Color: "0xCDA089", TitleColor: "0xE1B9A4"},,"setPosBR") ;

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

; alt & l::
;    PageInst.Evaluate(javascriptPlay)
; Return

; Alt & =::
;    PageInst.Evaluate(javascriptSpeedPlus)
; Return

; Alt & -::
;    PageInst.Evaluate(javascriptSpeedMinus)
; Return

; Alt & Left::
;    PageInst.Evaluate(javascriptMoveDown)
; Return

; Alt & Right::
;    PageInst.Evaluate(javascriptMoveUp)
; Return