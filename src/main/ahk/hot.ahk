#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode 2    

Activate(t)
{
  IfWinActive,%t%
  {
    WinMinimize
    return
  }
  SetTitleMatchMode 2    
  DetectHiddenWindows,on
  IfWinExist,%t%
  {
    WinShow
    WinActivate           
    return 1
  }
  return 0
}

ActivateAndOpen(t,p)
{
  if Activate(t)==0
  {
    Run %p%
    WinActivate
    return
  }
}

;-----------------------------10.9 update---------------------------
^F12::ActivateAndOpen("Fiddler Web Debugger","C:\Users\huayu\AppData\Local\Programs\Fiddler\Fiddler.exe")


;-----------------------------9.17 update---------------------------
; Notes
#a::Activate("- 印象笔记")
#+a::Activate("有道云笔记")
;其实思维导图可以加在这

; Editors
!`::Activate("Microsoft Word")
^`::Activate("Microsoft Excel")
#`::ActivateAndOpen("Notepad++","C:\Program Files (x86)\Notepad++\notepad++.exe")

^#`::ActivateAndOpen("Beyond Compare","C:\Program Files\Beyond Compare 4\BCompare.exe")
#!`::Activate("Visio Professional")
!2::ActivateAndOpen("WebStorm","C:\Program Files\JetBrains\WebStorm 2017.2.4\bin\webstorm64.exe")


; Documents for search
#z::ActivateAndOpen("jdk1.7 API","D:\books\JAVA_API_1.7中文.chm")
#+z::ActivateAndOpen("金山词霸","C:\Users\huayu\AppData\Local\Kingsoft\Power Word 2016\2016.3.3.0306\PowerWord.exe")

; Browsers
; IE.Better than just win+num,which would have you to choose tab
!1::ActivateAndOpen("Internet Explorer","C:\Program Files (x86)\Internet Explorer\iexplore.exe")

; DASUNG配置，方便切焦点看标题栏（如eclipse看文件路径
#ESC::Activate("Paperlike Pro")

;-----------------------------9.17 update---------------------------


^[::
send {End}{End}{End}{{}{Enter}
return

!Enter::
send {End}{End},
return


^Enter::
send {End}{End};
return

^Up::
send !{Up}{Up}{Down}{Tab}
return

^Down::
send !{Down}{Up}{Down}{Tab}
return


