#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

   ; rodar script como admin
   if not A_IsAdmin
   {
      Run, *RunAs %A_ScriptFullPath% ; Requires v1.0.92.01+
      ExitApp
   }
   
   ; versão do AHK pra executar
   if((A_PtrSize=8&&A_IsCompiled="")||!A_IsUnicode){ ;32 bit=4  ;64 bit=8
       SplitPath,A_AhkPath,,dir
       if(!FileExist(correct:=dir "\AutoHotkeyU32.exe")){
          MsgBox error
          ExitApp
       }
       Run,"%correct%" "%A_ScriptName%",%A_ScriptDir%
       ExitApp
   }
   
   ; definir qual vai ser a pasta appdata depende da versão do Windows C:\Users\felipe\AppData\Roaming
   if !InStr(A_OSVersion, "10.")
      appdata := A_ScriptDir
   else
      appdata := A_AppData "\" regexreplace(A_ScriptName, "\.\w+"), isWin10 := true
   
   ; configurações do script para criar
   global script := {base			: script
                ,name			: regexreplace(A_ScriptName, "\.\w+")
                ,version		: "1.0"
                ,author		: "Felipe Lullio"
                ,email			: "felipe@lullio.com.br"
                ,homepagetext	: "www.notion link"
                ,homepagelink	: "notion"
                ,donateLink	: "donate link"
                ,resfolder		: appdata "\res"
                ,iconfile		: appdata "\res\sct.ico"
                ,configfolder	: appdata
                ,configfile	: appdata "\settings.ini"}

                if (!FileExist(script.configfile))
                  {
                     FileCreateDir % regexreplace(script.configfile, "^(.*)\\([^\\]*)$", "$1")
                     FileAppend,, % script.configfile, UTF-8-RAW
                  
                     IniWrite, % true, % script.configfile, Settings, FirstRun
                     IniWrite, % true, % script.configfile, Settings, ShowUsage
                     Gosub HotkeysGUI
                  }
                  else
                  {
                     IniWrite, % false, % script.configfile, Settings, FirstRun
                     Gosub SetHotkeys
                  }
   
   if !fileExist(script.resfolder)
   {
      FileCreateDir, % script.resfolder
      FileInstall, res\sct.ico, % script.iconfile
   }
