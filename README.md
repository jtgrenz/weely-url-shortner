## A Super Simple Url Shortner

Super basic url shortner demo. There are only a handful of routes:
- /
- /url_maps
- /url_maps/new (which is the same as /)
- /url_maps/:token

### Shorten a Url
On the home page, simply enter any valid url and hit "Shorten!"

[![alt](https://screenshot.click/2021-01-e83z9-5wmpd.png)](https://screenshot.click/2021-01-e83z9-5wmpd.png)

The url will be converted to a SHA1 hash with a random salt and then truncated. If you enter a url that has already been shorted, you'll get that same url back and we don't generate a new url.

[![alt](https://screenshot.click/2021-01-xbdm5-upgna.png)](https://screenshot.click/2021-01-xbdm5-upgna.png)

If you enter a url without a scheme (http or https), we'll prepend one to the url before saving. No other modifications are made to the url and it is otherwise stored exactly as input.

Under the hood we just store the truncated SHA1 token along with the long url.

### Tracking
When someone clicks the shorted url, they are taken to `/:token` where we look up the long form url from the token param, store the ip address of the request and then redirect the user to the long form url.

You can see all the redirect events stored under `/url_maps/:token`

[![alt](https://screenshot.click/2021-01-6bhbs-ldj0t.png)](https://screenshot.click/2021-01-6bhbs-ldj0t.png)


---

## Setup

Requires Ruby 2.6.6
This demo app is simple and uses sqlite for the db, so not much to worry about on the dependency side.

To get started:
 - `bundle install`
 - `rails db:setup`
 - `rails server`

and you should be good to go.

