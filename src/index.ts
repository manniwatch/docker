/*!
 * Source https://github.com/manniwatch/docker
 */

import { ManniWatchProxyServer } from '@manniwatch/api-proxy-server';
import { Config } from './config';

const server: ManniWatchProxyServer = new ManniWatchProxyServer(Config.endpoint, Config.port);
server.start();
process.on('SIGINT', (): void => {
    // tslint:disable-next-line:no-console
    console.info('Interrupted');
    server.stop();
    process.exit(0);
});
