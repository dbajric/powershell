# Define parameters that can be passed in from command line
param (
    [string]$server = "8.8.8.8",
    [int]$port = 53,
    [int]$iterations = 20
)

$stopwatch = [system.diagnostics.stopwatch]::StartNew()

for($i = 0; $i -lt $iterations; $i++)
{
    # Create a TCP client and set lingering state to not reuse connections
    $tcp = New-Object System.Net.Sockets.TcpClient;
    $tcp.LingerState = New-Object System.Net.Sockets.LingerOption($TRUE, 0)

    Try
    {
        # Measure the amount of time needed to establish a TCP connection with the server
        $start = $stopwatch.Elapsed
        $tcp.Connect($server, $port)
        $duration = $stopwatch.Elapsed - $start

        # Print out the duration onto screen
        Write-Host ("Connecting to {0}:{1} took {2}ms" -f $server, $port, $duration.TotalMilliseconds)
    }
    Catch
    {
        # In case an error happened, print out the error onto screen
        $_.Exception
    }
    Finally
    {
        # Ensure that connection is closed
        if($tcp.Connected) 
        {
            $tcp.Close();
        }

        # Wait for some time to ensure the connection is closed
        Start-Sleep -Seconds 1
    }
}