const crypto = require('crypto');

function encodeBase64URL(str) {
  return Buffer.from(str).toString('base64')
    .replace(/\+/g, '-')
    .replace(/\//g, '_')
    .replace(/=+$/g, '')
    ;
}

function sign(target, privateKey) {
    const signer = crypto.createSign('RSA-SHA256');
    signer.update(target);
    signer.end();
    const signature = signer.sign(privateKey);
    return signature;
}

// https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/generating-a-json-web-token-jwt-for-a-github-app#about-json-web-tokens-jwts
function to_jwt(appId, privateKey) {
    const header = encodeBase64URL(JSON.stringify({
        'alg': 'RS256',
        'typ': 'JWT',
    }));
    const now = Math.floor(Date.now() / 1000);
    const payload = encodeBase64URL(JSON.stringify({
        'iat': now - 60,
        'exp': now + (5 * 60), // expires after 5 minutes
        'iss': appId,
    }));
    const signature = encodeBase64URL(sign(`${header}.${payload}`, privateKey));
    return `${header}.${payload}.${signature}`;
}

async function generate_token(fetch, jwt) {
    const {GITHUB_API_URL, GITHUB_REPOSITORY} = process.env;
    // installation_id
    const installation_id = await (async() => {
        const response = await fetch(`${GITHUB_API_URL}/repos/${GITHUB_REPOSITORY}/installation`, {
            headers: {
                'Authorization': `Bearer ${jwt}`,
                'Accept': 'application/vnd.github+json',
                'X-GitHub-Api-Version': '2022-11-28',
            }
        });
        const json = await response.json();
        return json.id;
    })();

    const token = await (async() => {
        const url = `${GITHUB_API_URL}/app/installations/${installation_id}/access_tokens`;
        const response = await fetch(url, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${jwt}`,
                'Accept': 'application/vnd.github+json',
                'X-GitHub-Api-Version': '2022-11-28',
            },
        });
        const json = await response.json();
        return json.token;
    })();
    return token;
}

module.exports = async ({fetch}) => {
    const {APP_ID, PRIVATE_KEY} = process.env;
    const jwt = to_jwt(APP_ID, PRIVATE_KEY);
    const token = await generate_token(fetch, jwt);
    return token;
}
