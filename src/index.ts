/*!
 * Source https://github.com/manniwatch/manniwatch Package: api-proxy-server
 */

import { ManniWatchProxyServer } from '@manniwatch/api-proxy-server';
import { Config } from './config';

const server: ManniWatchProxyServer = new ManniWatchProxyServer(Config.endpoint, Config.port);
server.start();
process.on('SIGINT', () => {
    console.info("Interrupted")
    server.stop();
    process.exit(0)
})
