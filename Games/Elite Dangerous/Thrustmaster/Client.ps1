$pipe = new-object System.IO.Pipes.NamedPipeClientStream("NamedPipeTest");
 $pipe.Connect(); 
 
$sw = new-object System.IO.StreamWriter($pipe);
$sw.WriteLine("[System.Console]::Beep(250, 200)"); 
$sw.WriteLine("Write-Host 'Hi there!'");
# Set windows title
$sw.WriteLine("(Get-Host).UI.RawUI.WindowTitle = 'Thrustmaster TARGET'");

# $sw.WriteLine('exit'); 
 
$sw.Dispose(); 
$pipe.Dispose();