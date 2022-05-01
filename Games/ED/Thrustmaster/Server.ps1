
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
		
		#$cmd = $reader.ReadLine();
		
		$task = $reader.ReadLineAsync();
		
		#while (($task.IsCompleted -ne $true) -and $pipe.IsConnected)
		do
		{	
			Write-Host 'Waiting...';	
			#$task.Wait(1000);
			#Write-Host 'Done';	
		}
		while (($task.Wait(1000) -ne $true) -and $pipe.IsConnected)
		
		if ($task.Status -eq "RanToCompletion")
			{
			Write-Host 'RanToCompletion';	
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
		

		} 
	
	# We lost connection.
    # Make sure we explicitly disconnect before waiting for a new connection.	
	$pipe.Disconnect();
	
	}

$reader.Dispose();
$pipe.Dispose();
