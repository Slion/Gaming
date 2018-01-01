
$pipeSecurity = new-object System.IO.Pipes.PipeSecurity;
$pipeRule = new-object System.IO.Pipes.PipeAccessRule("Everyone", "ReadWrite", "Allow");
$pipeSecurity.AddAccessRule($pipeRule);

$pipe=new-object System.IO.Pipes.NamedPipeServerStream("NamedPipeTest", "InOut", 1, "Message", "Asynchronous", 32768, 32768); #, $pipeSecurity
'Created server side of "NamedPipeTest"'
$pipe.WaitForConnection(); 
'Reading data...'
 
$sr = new-object System.IO.StreamReader($pipe); 
while (($cmd= $sr.ReadLine()) -ne 'exit') 
{
	Invoke-Expression $cmd;
	#$ExecutionContext.InvokeCommand.ExpandString($cmd)
	#$script = $ExecutionContext.InvokeCommand.NewScriptBlock($cmd);
	#& $script;
}; 
 
$sr.Dispose();
$pipe.Dispose();