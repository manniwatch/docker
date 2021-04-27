/*!
 * Source https://github.com/manniwatch/manniwatch Package: api-proxy-server
 */
console.log
export class Config {
    /**
     * gets the port for the server
     */
    public static get port(): number {
        if (process.env.MW_PORT) {
            return parseInt(process.env.MW_PORT, 10);
        }
        throw new Error('No port specified');
    }

    public static get endpoint(): string {
        if (process.env.MW_ENDPOINT) {
            return process.env.MW_ENDPOINT;
        }
        throw new Error('No endpoint specified');
    }

}
