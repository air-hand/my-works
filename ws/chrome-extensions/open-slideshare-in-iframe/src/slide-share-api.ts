export namespace SlideShare {

    export type OEmbedResponseFormat = "xml" | "json" | "jsonp";

    interface OEmbedRequestParameters {
        url: URL;
        maxwidth? : number;
        maxheight? : number;
        format? : OEmbedResponseFormat;
        callback? : string;
    }

    // eslint-disable-next-line no-inner-declarations
    function attachOEmbedRequestParameters2URL(url: URL, params: OEmbedRequestParameters): URL {
        url.searchParams.append("url", params.url.toString());
        if (params.maxwidth) {
            url.searchParams.append("maxwidth", params.maxwidth.toString());
        }
        if (params.maxheight) {
            url.searchParams.append("maxheight", params.maxheight.toString());
        }
        if (params.format) {
            url.searchParams.append("format", params.format);
        }
        if (params.callback) {
            url.searchParams.append("callback", params.callback);
        }
        return url;
    }

    export interface OEmbedResponse {
        slideshow_id: string;
        type: OEmbedResponseFormat;
        title: string;
        html: string;
    }

    export class API {
        // https://www.slideshare.net/developers/oembed
        async oembed(page_url: URL) : Promise<OEmbedResponse> {
            const OEMBED_API_URL = "https://www.slideshare.net/api/oembed/2";

            const request_url = attachOEmbedRequestParameters2URL(new URL(OEMBED_API_URL), {
                url: page_url,
                format: "json"
            });

            const response = await fetch(request_url.toString());
            if (!response.ok) {
                throw new Error("HTTP error, status = " + response.status);
            }
            const json = await response.json();
            return json as OEmbedResponse;
        }
    }
}
