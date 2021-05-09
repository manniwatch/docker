/*!
 * Source https://github.com/manniwatch/docker
 */

import { ManniWatchApiProxyServer } from '@manniwatch/api-proxy-server';
import { Config } from './config';

const server: ManniWatchApiProxyServer = new ManniWatchApiProxyServer(Config.endpoint, Config.port);
server.start()
    .then((): void => {
        // tslint:disable-next-line:no-console
        console.info(`Server started on ${Config.port} with endpoint ${Config.endpoint}`);
    });
process.on('SIGINT', (): void => {
    // tslint:disable-next-line:no-console
    console.info('Interrupted');
    server.stop()
        .then((): void => {
            console.log('Server closed');
        })
        .catch((err: any): void => {
            console.error('Error occured while stoping', err);
        })
        .finally((): void => {
            process.exit(0);
        });
});
