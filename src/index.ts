/*!
 * Source https://github.com/manniwatch/docker
 */

import {
    ManniWatchApiProxyServer,
    ManniWatchProxyServer,
} from '@manniwatch/api-proxy-server';
import { join, resolve } from 'path';
import { Config } from './config';

enum Mode {
    API_ONLY = 1,
    FULL = 2,
}

const extractMode: () => Mode = (): Mode => {
    if (process.argv.length >= 3) {
        if (process.argv[2] === 'api') {
        } else if (process.argv[2] === 'full') {
            return Mode.FULL;
        } else {
            console.group(`Unknown Mode argument: "${process.argv[2]}"`);
            // tslint:disable-next-line:no-console
            console.log('Using Default "api"');
            console.groupEnd();
        }
    }
    return Mode.API_ONLY;
};
const mode: Mode = extractMode();
console.log(`Server runs in ${mode === Mode.API_ONLY ? 'Api Only' : 'Full'} Mode`);
const server: ManniWatchApiProxyServer | ManniWatchProxyServer = mode === Mode.API_ONLY ?
    new ManniWatchApiProxyServer(Config.endpoint, Config.port) :
    new ManniWatchProxyServer(Config.endpoint, Config.port, resolve(join('/manniwatch', 'client')));
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
