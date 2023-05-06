import { urlWithoutQueryStrings } from "./utils";

chrome.runtime.onMessage.addListener(async(message: any, sender: chrome.runtime.MessageSender, sendResponse: Function) => {
    if (message.type === "open-slideshare") {
        const url = urlWithoutQueryStrings(message.url);
        await chrome.tabs.create({
            active: true,
            url: chrome.runtime.getURL(`assets/index.html?slideshare_url=${encodeURI(url.toString())}`),
        });
        return;
    }
});
