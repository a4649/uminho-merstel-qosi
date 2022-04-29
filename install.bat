@echo off
@echo Please install python3 manually and press any key to continue...
pause
python get-pip.py

pip install icmplib
pip install iperf3