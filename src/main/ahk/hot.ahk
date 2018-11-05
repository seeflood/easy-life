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

;-----------------------------test update---------------------------
;^2::Activate("远程桌面连接")
;^3::
;send !{CtrlBreak}
;return
;-----------------------------10.9 update---------------------------
; For debugger
#F12::ActivateAndOpen("HTTP Debugger Pro","C:\Program Files (x86)\HTTPDebuggerPro\HTTPDebuggerUI.exe")
^F12::ActivateAndOpen("Fiddler Web Debugger","C:\Users\huayu\AppData\Local\Programs\Fiddler\Fiddler.exe")
!F12::ActivateAndOpen("以太网","C:\Program Files\Wireshark\Wireshark.exe")
#!F12::ActivateAndOpen("Apache JMeter","D:\工具包\jmeter-3.0\bin\jmeter.bat")
;-----------------------------9.17 update---------------------------
; Notes
#a::Activate("- Evernote")
#+a::Activate("有道云笔记")
!a::Activate("xmind")


; Editors
!`::Activate("- Word")
^`::Activate("Microsoft Excel")
#`::ActivateAndOpen("Notepad++","C:\Program Files\Notepad++\notepad++.exe")

^#`::ActivateAndOpen("Beyond Compare","C:\Program Files\Beyond Compare 4\BCompare.exe")
#!`::Activate("Visio Professional")
;不用webstorm了，贼烦
;!2::ActivateAndOpen("WebStorm","C:\Program Files\JetBrains\WebStorm 2017.2.4\bin\webstorm64.exe")


; Documents for search
#z::ActivateAndOpen("jdk1.7 API","D:\books\JAVA_API_1.7中文.chm")
;Decide to use the hot key of its own.
;#+z::ActivateAndOpen("金山词霸","C:\Users\huayu\AppData\Local\Kingsoft\Power Word 2016\2016.3.3.0306\PowerWord.exe")

; Browsers
; IE.Better than just win+num,which would have you to choose tab
!1::ActivateAndOpen("Edge","C:\windows\explorer.exe shell:Appsfolder\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge")

; DASUNG配置，方便切焦点看标题栏（如eclipse看文件路径
#ESC::Activate("Paperlike Pro")

;方便chrome devTools调试
!ESC::
send {ESC}{ESC}{ESC}
return
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

;-----------------------------db related---------------------------
!2::ActivateAndOpen("京东到家-运维管理平台","https://op.jddj.com/dql_index")


If !TabActivate("百度一下，你就知道")
    OpenInNewTab("http://baidu.com")
Return

OpenInNewTab(URL) {
    For pwb in ComObjCreate("Shell.Application").Windows
        If InStr(pwb.FullName, "iexplore.exe") {
            WinActivate, % "ahk_id " pwb.hwnd
            pwb.Navigate(URL, 2048) ; navOpenInNewTab = 2048
            Return
        }

    pwb := ComObjCreate("InternetExplorer.Application")
    pwb.Visible := True
    pwb.Navigate(URL)
    Return
}

TabActivate(TabName) {
    WinGet, id, List, ahk_class IEFrame
    Loop, %id%
    {
        this_id := id%A_Index%
        
        ControlGet, hTabUI , hWnd,, DirectUIHWND2, % "ahk_id " this_id
        If !hTabUI
            ControlGet, hTabUI , hWnd,, DirectUIHWND1, % "ahk_id " this_id

        Tabs := Acc_ObjectFromWindow(hTabUI).accChild(1) ; access "Tabs" control
        Loop, % Tabs.accChildCount
            if (Tabs.accChild(A_Index).accName(0) = TabName) {
                WinActivate, ahk_id %this_id%
                return True, Tabs.accChild(A_Index).accDoDefaultAction(0)
            }
    }
}

; 以下为 Acc.ahk 的一部分
Acc_Init()
{
    Static  h
    If Not  h
        h:=DllCall("LoadLibrary","Str","oleacc","Ptr")
}

Acc_ObjectFromWindow(hWnd, idObject = -4)
{
    Acc_Init()
    If  DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd, "UInt", idObject&=0xFFFFFFFF, "Ptr", -VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
    Return  ComObjEnwrap(9,pacc,1)
}