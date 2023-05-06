export function confirm (message: string): Promise<void> {
    if (window.confirm(message)) {
        return Promise.resolve();
    }
    return Promise.reject();
}

export function urlWithoutQueryStrings(url: URL|string): URL {
    const new_url = new URL(url.toString());
    new_url.search = "";
    return new_url;
}
