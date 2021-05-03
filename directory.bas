Attribute VB_Name = "Module1"


Sub FileList()
    Dim V As String
    Dim BrowseFolder As String
     
    '????????? ?????????? ???? ?????? ?????
    With Application.FileDialog(msoFileDialogFolderPicker)
        .Title = "???????? ????? ??? ????"
        .Show
        On Error Resume Next
        Err.Clear
        V = .SelectedItems(1)
        If Err.Number <> 0 Then
            MsgBox "?? ?????? ?? ???????!"
            Exit Sub
        End If
    End With
    BrowseFolder = CStr(V)
     
    '????????? ???? ? ??????? ?? ???? ????? ???????
    ActiveWorkbook.Sheets.Add
    With Range("A1:E1")
        .Font.Bold = True
        .Font.Size = 12
    End With
    Range("A1").Value = "��� �����"
    Range("B1").Value = "����"
    Range("C1").Value = "������"
    Range("D1").Value = "������"
    Range("E1").Value = "�������"
     
    '???????? ????????? ?????? ?????? ??????
    '???????? True ?? False, ???? ?? ????? ???????? ????? ?? ????????? ?????
    ListFilesInFolder BrowseFolder, True
End Sub
 
 
Private Sub ListFilesInFolder(ByVal SourceFolderName As String, ByVal IncludeSubfolders As Boolean)
 
    Dim FSO As Object
    Dim SourceFolder As Object
    Dim SubFolder As Object
    Dim FileItem As Object
    Dim r As Long
 
    Set FSO = CreateObject("Scripting.FileSystemObject")
    Set SourceFolder = FSO.getfolder(SourceFolderName)
 
    r = Range("A65536").End(xlUp).Row + 1   '??????? ?????? ?????? ??????
    '??????? ?????? ?? ?????
    For Each FileItem In SourceFolder.Files
        Cells(r, 1).Formula = FileItem.Name
        Cells(r, 2).Formula = FileItem.Path
        Cells(r, 3).Formula = FileItem.Size
        Cells(r, 4).Formula = FileItem.DateCreated
        Cells(r, 5).Formula = FileItem.DateLastModified
        r = r + 1
        X = SourceFolder.Path
    Next FileItem
     
    '???????? ????????? ???????? ??? ?????? ????????? ?????
    If IncludeSubfolders Then
        For Each SubFolder In SourceFolder.SubFolders
            ListFilesInFolder SubFolder.Path, True
        Next SubFolder
    End If
 
    Columns("A:E").AutoFit
 
    Set FileItem = Nothing
    Set SourceFolder = Nothing
    Set FSO = Nothing
 
End Sub