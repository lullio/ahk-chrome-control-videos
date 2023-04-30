#Include, <Default_Settings>
#Include, C:\Users\%A_UserName%\Downloads\Chrome.ahk

if not A_IsAdmin
   Run *RunAs "%A_ScriptFullPath%"

ListNotes =
(
DOM1|DOM2|REGEX|ASYNC JS|FUNC JS|ARRAYS JS|WEB ANALYTICS|COMPLETE JS|JS FULL STACK|AJAX|GOOGLE APPS SCRIPT|DATA STUDIO 1||DATA STUDIO 2|BIG QUERY|POWER BI 1
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
   Gui Submit
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
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=2696476"
   }
   else if(Curso = "DOM2")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=2733254"
   }
   else if(Curso = "ASYNC JS")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=2641732"
   }
   else if(Curso = "FUNC JS")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=2319848"
   }
   else if(Curso = "ARRAYS JS")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=2497482"
   }
   else if(Curso = "WEB ANALYTISC")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=3871000"
   }
   else if(Curso = "COMPLETE JS")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=851712"
   }
   else if(Curso = "JS FULL STACK")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=1436332"
   }
   else if(Curso = "AJAX")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=4454702"
   }
   else if(Curso = "GOOGLE APPS SCRIPT")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=3646911"
   }
   else if(Curso = "GOOGLE APPS SCRIPT")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=3646911"
   }
   else if(Curso = "DATA STUDIO 1")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=3772918"
   }
   else if(Curso = "DATA STUDIO 2")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=1213560"
   }
   else if(Curso = "BIG QUERY")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=3666718"
   }
   else if(Curso = "POWER BI 1")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=1995622"
   }
   else if(Curso = "REGEX")
   {
      website := "https://www.udemy.com/course-dashboard-redirect/?course_id=1963420"
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

alt & l::
   FileRead, javascriptFile, play-pause.js
   Sleep, 1000
   PageInst.Evaluate(javascriptFile)
Return

ctrl & -::
   FileRead, javascriptFile, play-pause.js
   Sleep, 1000
   PageInst.Evaluate(javascriptFile)
Return

Alt & Left::

Return
