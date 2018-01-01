
$pipe=new-object System.IO.Pipes.NamedPipeServerStream("NamedPipeTest", "InOut", 1, "Message", "Asynchronous", 32768, 32768);
if ($pipe -eq $null)
	{
	Write-Host "Can't create pipe!";
	# That should only close the window if started from TARGET
	exit;	
	}

Write-Host 'Created server side of "NamedPipeTest"';
 
while ($true)
	{
	Write-Host 'Waiting for connection...';
	$pipe.WaitForConnection(); 
	Write-Host 'Reading data...';
	
	$reader = new-object System.IO.StreamReader($pipe); 
	while ($pipe.IsConnected) 
		{
		#(($cmd= $sr.ReadLine()) -ne 'exit')
		
		$cmd = $reader.ReadLine();
		if ($cmd -ne $null)
			{
			# Try invoke that command
			Invoke-Expression $cmd;
			#$ExecutionContext.InvokeCommand.ExpandString($cmd)
			#$script = $ExecutionContext.InvokeCommand.NewScriptBlock($cmd);
			#& $script;
			}
		} 
	
	# We lost connection.
    # Make sure we explicitly disconnect before waiting for a new connection.	
	$pipe.Disconnect();
	
	}

$reader.Dispose();
$pipe.Dispose();

exit;

###########################################
# TODO: Make it async at some point
		$task = $reader.ReadLineAsync();
		if ([System.Threading.Tasks.Task]::WhenAny($task, [System.Threading.Tasks.Task]::Delay(1000)) -eq $task)
			{
			Write-Host 'Complete!';
			$cmd = $task.Result;
			if ($cmd -ne $null)
				{
				# Try invoke that command
				Invoke-Expression $cmd;
				#$ExecutionContext.InvokeCommand.ExpandString($cmd)
				#$script = $ExecutionContext.InvokeCommand.NewScriptBlock($cmd);
				#& $script;
				}			
			}
		else
			{
			Write-Host 'Timeout!';
			#Timedout
			}