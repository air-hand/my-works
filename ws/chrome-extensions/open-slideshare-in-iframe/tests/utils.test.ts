import { urlWithoutQueryStrings } from "../src/utils";

describe('urlWithoutQueryStrings', () => {
    test('url with no query strings', () => {
        expect(urlWithoutQueryStrings("https://foo.bar.baz/hoge/piyo").toString()).toBe("https://foo.bar.baz/hoge/piyo");
    });
    test('url with query strings', () => {
        expect(urlWithoutQueryStrings("https://foo.bar.baz/hoge/?piyo").toString()).toBe("https://foo.bar.baz/hoge/");
    });
});
