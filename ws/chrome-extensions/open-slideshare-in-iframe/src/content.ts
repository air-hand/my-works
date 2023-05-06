import { confirm } from "./utils";

// onload function
async function onloaded() {
    await confirm('Open this slide on iframe?');

    await chrome.runtime.sendMessage({type: "open-slideshare", url: window.location.href});
}

window.addEventListener('load', onloaded, false);
