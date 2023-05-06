import { urlWithoutQueryStrings } from "./utils";

type Message = {
    type: string,
    url?: URL|string,
};

chrome.runtime.onMessage.addListener(async(message: Message, sender: chrome.runtime.MessageSender, sendResponse: CallableFunction) => {
    if (message.type === "open-slideshare") {
        const url = urlWithoutQueryStrings(message.url);
        await chrome.tabs.create({
            active: true,
            url: chrome.runtime.getURL(`assets/index.html?slideshare_url=${encodeURI(url.toString())}`),
        });
        return;
    }
});
