import { AuthConfig } from 'angular-oauth2-oidc';

export const authCodeFlowConfig: AuthConfig = {
    issuer: 'https://ISSUER',
    redirectUri: window.location.origin + '/index.html',
    clientId: 'spa',
    responseType: 'code',
    scope: 'openid profile email offline_access api',
    showDebugInformation: true,
    timeoutFactor: 0.01
};
