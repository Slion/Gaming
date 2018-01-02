$pipe = new-object System.IO.Pipes.NamedPipeClientStream("NamedPipeTest");
 $pipe.Connect(); 
 
$sw = new-object System.IO.StreamWriter($pipe);
#$sw.WriteLine("[System.Console]::Beep(450, 80)"); 
#$sw.WriteLine("[System.Console]::Beep(350, 80)"); 

$sw.WriteLine("[System.Console]::Beep(350, 80)");
$sw.WriteLine("[System.Console]::Beep(450, 80)"); 


$sw.WriteLine("Write-Host 'Hi there!'");
# Set windows title
$sw.WriteLine("(Get-Host).UI.RawUI.WindowTitle = 'Thrustmaster TARGET'");
# Flush
$sw.Flush();

Start-Sleep -s 5;

$sw.WriteLine("Write-Host 'Still there!'");

#$sw.WriteLine("[System.Console]::Beep(250, 3000)"); 
#$sw.WriteLine("[System.Console]::Beep(650, 1000)"); 

# $sw.WriteLine('exit'); 
 
$sw.Dispose(); 
$pipe.Dispose();