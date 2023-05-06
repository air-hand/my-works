import { SlideShare } from "./slide-share-api";

declare let document: Document;

document.addEventListener('DOMContentLoaded', async() => {
    const url = new URL(window.location.href);
    const slideshare_url = url.searchParams.get("slideshare_url");
    if (!slideshare_url) {
        return;
    }
    const api = new SlideShare.API();
    const res = await api.oembed(new URL(slideshare_url));
    const iframe_parent = document.getElementById("iframe-box") as HTMLElement;
    iframe_parent.innerHTML = res.html;
});
