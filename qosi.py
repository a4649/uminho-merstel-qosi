import utils
import logging

targets = ['aws','azure','google','ibm']

def main():
    for target in targets:
        measurement = {}
        logging.info('Getting information from device...')
        measurement['isp'] = utils.get_isp()
        measurement['os'] = utils.get_os()
        measurement['date'] = utils.get_date()
        measurement['hour'] = utils.get_hour()

        logging.info('Starting ICMP measurement...')
        ping = utils.run_ping(target)
        if ping:
            measurement['latency'] = ping['latency']
            measurement['jitter'] = ping['jitter']
            measurement['packet_loss'] = ping['packet_loss']
            logging.info('Ping OK')
        else:
            logging.error('Error, aborting')
            return

        logging.info('Starting bandwidth measurement...')
        iperf = utils.run_iperf(target)
        if iperf:
            measurement['upload'] = iperf['upload']
            measurement['download'] = iperf['download']
            logging.info('Bandwidth OK')
        else:
            logging.error('Error, aborting')
            return

        logging.info('Sending results to databse...')
        if utils.send_results(measurement):
            logging.info('OK')
        else:
            logging.error('Error, aborting')



if __name__ == "__main__":
    main()