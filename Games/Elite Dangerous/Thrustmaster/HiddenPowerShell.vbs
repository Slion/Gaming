Rem CreateObject("Wscript.Shell").Run """" & WScript.Arguments(0) & """", 0, False

Dim shell,command
command = "powershell.exe -nologo -Command " & WScript.Arguments(0) 
Set shell = CreateObject("WScript.Shell")
shell.Run command,0