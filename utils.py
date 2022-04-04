import requests
import json
import platform
import iperf3
from datetime import datetime
from icmplib import ping, exceptions

def get_isp():
    try:
        req = requests.get('https://ipinfo.io')
        result = json.loads(req.text)
        return result['org']
    except Exception as err:
        print(err)
        

def get_date():
    return datetime.today().strftime("%d-%m-%Y")

def get_hour():
    return datetime.datetime.today().strftime("%H:%M")

def get_os():
    return platform.system()

def run_ping(target):
    results = {}
    try:
        test = ping(target, 5)
        results['latency'] = test.avg_rtt
        results['jitter'] = test.jitter
        results['packet_loss'] = test.packet_loss
    except exceptions.SocketPermissionError:
        print("Permissions error. You need to run as sudo")
        return
    return results

def run_iperf(target):
    results = {}
    try:
        client = iperf3.Client()
        client.server_hostname = target
        test = client.run()
        results['download'] = "{:.2f}".format(test.received_MB_s)
        results['upload'] = "{:.2f}".format(test.sent_MB_s)
    except Exception as err:
        print(err)
    return results
