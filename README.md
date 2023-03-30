# Quality of Service in IP Networks

Exercises and projects developed during the uality of Service in IP Networks curricular unit of the Engineering of Computer Networks and Telematic Services from School of Engineering, University of Minho

https://www.eng.uminho.pt/en/study/_layouts/15/UMinho.PortaisUOEI.UI/Pages/CatalogoCursoDetail.aspx?itemId=3929&catId=12

This project aims to assess the quality of connection from the main Portuguese ISPs to the largest public cloud providers on the internet.
An active monitoring tool was developed to run measurements on personal computers against virtual machines located in the different cloud providers. 
During one month different metrics were collected and the conclusions shows which ISP and cloud providers has the best metrics results


Data collected per measurement:
  - latency (ms)
  - jitter (ms)
  - packet loss (%)
  - download (Mbps)
  - upload (Mbps)
  - target (azure/aws/ibm/google/alibaba)
  - isp (ASN)
  - device operating system (linux,windows,macos,android,iphone) iperf3 python library not works on Windows!
  - date
  - hour

Cloud Virtual Machines (UK/London region):
  - Amazon AWS
  - Alibaba Cloud
  - Azure 
  - Google
 
VMs specs (Free tier)
  - 1GB of memory
  - 1 CPU (except Google - 2 CPU) 
  - Region/Location: London/UK
  - OS: CentOS8
  - Name: qosi-vm
  - Add firewall rule: reply ICMP and TCP port 5201


Run the tool (Linux/MacOS)

1. Download the code through web browser

2. Unzip folder

```unzip QoSI-main.zip```

3. Enter folder folder

```cd QoSI-main```

4. Install requirements:

```sudo ./install.sh```

5. Run the tool:

```sudo python3 qosi.py```

Run the tool (Windows)

1. Download the code through web browser

2. Enter the folder with code
3. 
```cd QoSI-main```

3. Install requirements:
4. 
```install.bat```

4. Run python script:
5. 
```python qosi.py```
