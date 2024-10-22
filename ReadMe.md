# Prometheus 4D Exporter
Installs an additional web server for Prometheus metric generation.
Runs isolated from standard web server for data security (expose the metrics port, but protect/isolate your main server).


### Installation

###### Recommended way

Note: branch main requires 4D 20 R7 or newer, select branch 4D 20 R5andR6 if needed.


Copy to 4D's component folder (compile/build upfront for production usage). 4D v19 or newer required. This launches an additional web server on a separated port, not sharing the main web server, only for Prometheus access, keeping the main server more confidential/secure.

In your On Server Startup method call:

```
		ARRAY TEXT($tTxt_Components; 0)
		COMPONENT LIST($tTxt_Components)
		If (Find in array($tTxt_Components; "Prometheus_4D_Exporter")>0)
			$para:=New object("HTTPPort"; 9828; "user"; "myusername"; "pass"; "mypassword")
			EXECUTE METHOD("Prometheus_Start"; *; $para)
		End if 
	End if 
```

Change HTTPPort (default 9828), HTTPSPort (default 9843), username, password as needed. If you do not pass user/pass the server runs without authentication. 

You can disable the exporter at any time by removing it from the component folder and restart 4D.

###### Alternative installation

If you want to share the main web server, add to your onWebConnection database method:

```
If ($1="/Metrics")
	C_BLOB:C604($blobin; $blobout)
	DOCUMENT TO BLOB:C525(Get 4D folder:C485(Current resources folder:K5:16)+"metrics.shtml"; $blobin)
	PROCESS 4D TAGS:C816($blobin; $blobout)
	WEB SEND BLOB:C654($blobout; "text/plain")
End if 
```

Modify /Metrics to another URL if required (which needs to adapt prometheus.yml as well, by example:  metrics_path: /my4Dmetrics )

Copy the file metrics.shtml from the resource folder of the component into the resource folder of your main application.



### Prometheus Setup

Add to your prometheus.yml file a job such as:

```
  - job_name: 'My4DDatabase'
    scrape_interval:     60s
    static_configs:
    - targets: ['192.168.0.34:9828']	
```

The metrics are calculated for 60 seconds. If you want to change the interval, the used code needs to be changed as well.

### Metrics

The metrics starts all with "FourD_". They return metrics about total number of connected clients, running processes, memory usage details, detailed information about database usage (read from disk, write to disk, read from Memory in total and per table) and for queries the count and time per query operation



### Grafana Dashbaord	

An example dashboard is included in the "Grafana" [folder](Grafana/4D-1622574690034.json).

The dashboard shows memory usage (free, virtual, cache, etc), Client and process usage, total database measures (read and write to disk and read from cache for all database operations) and scrap time. The scrap time is useful to see if the total system behave slower than normal.

![screen1.jpg](Documentation/Screen1.png)

Followed by read from disk per table, focused on records on the left, on disk on the right, below the same for writing to disk:

![Screen 2](Documentation/Screen2.png)

Followed by reading from cache, left records per table, right index per table. Move the mouse over a line (or dot) to see a legend (details about each table)

Below analyze per query. On the right total execution counted, on the left total time need per queries type

![Screen3](Documentation/Screen3.png)


###  History
Published 2021 for 4D v19. Introduced at 4DMethod Meeting:
https://www.youtube.com/watch?v=0999ycYHEtg

Recompiled 2024 for 4D 20 R5 or newer, published as 1.1
Modifications:
- Using new var keyword to declare all variables
- Build + notarize zip, upload as Release 1.1 to be useable with new dependencies.json features in 20 R6 (to download component automatically via project dependencies)

Recompiled 2024 for 4D 20 R7 or newer, published as 1.2
- changed command names in metrics.shtml from Get license info to license info, etc.

