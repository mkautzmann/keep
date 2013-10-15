![Keep logo](http://f.cl.ly/items/1b2n2b1h073B290m2M3A/keep_banner_large.png)

Keep
====

## What?

Keep is a Chrome extension that controls web based music players based on the state of some video player services on the web.

This is currently on **BETA** so it's not public on the Chrome Web Store yet, just people with the link like [you](https://chrome.google.com/webstore/detail/keep-it-playing/fagomklndfgephijmhgfennnpfpeioom) can access it.

## Why?

This is a FDD (Fun Driven Development) project that I made because I want to watch videos on YouTube while listening to my musics on Deezer, but I don't want to keep pausing/resuming my music everytime I start a video on YouTube. So I thought: wouldn't it be cool if I could just watch my videos and the music stops/resumes by itself?

So a extension called Keep It Playing is here. As Chrome is my default browser this is available as a Chrome extension.

## How I use it?

The extension usage if pretty simple:

1. Get the extension at the [Chrome Web Store](https://chrome.google.com/webstore/detail/keep-it-playing/fagomklndfgephijmhgfennnpfpeioom);
2. Open [Deezer](http://www.deezer.com/) and start listening;
3. Open [YouTube](http://www.youtube.com/) and start watching videos (nope, it doesn't work with embed videos so far. Sorry...);
4. Boom! Your music now knows when you want to watch a video and pauses automatically.

What if I want to keep the music playing while watching sometimes?

OK, just disable the extension functionality using the popup menu by clicking the blue K logo in your extension bar.

There you'll a switch, just turn it off.

When you want the extension to work again turn it back on.

Reminder: The configuration made in the popup window will be synced across all your Chrome browsers and it will be there as you left it even if you restart the computer.

## How it's done?

Basically what Keep does is watch for YouTube's player events and then tell Deezer if the video is playing or not, so Deezer can control the music accordingly.

Of course Deezer and YouTube aren't the only multimedia services I use in the web. This may be expanded to support some other services available out there and I apreciate contributions. Check out the [issues](https://github.com/mkautzmann/keep/issues) if you're interested.

## Current state

I'm currently facing some problems in making this extension work across all Chrome versions and operating systems.

So here's a compatibility table with information of current extension compatibility:

| Browser          | OS      | Compatible? |
| ---------------- | ------- | ----------- |
| Chrome Stable 30 | Mac     | NO          |
| Chrome Canary 32 | Mac     | YES         |
| Chrome Stable 30 | Windows | Not tested  |
| Chrome Canary 32 | Windows | Not tested  |
| Chrome Stable 30 | Linux   | Not tested  |
| Chrome Canary 32 | Linux   | Not tested  |

As you can see the testing process is currently in progress, this table shall change soon.

The first version of the extenstion will be publicly release as soon as we fill out this table positive cells.

## Where?

The extension isn't publicly yet, but you can download if you have the link.available at the [Chrome Web Store](https://chrome.google.com/webstore/detail/keep-it-playing/fagomklndfgephijmhgfennnpfpeioom).

Feel free to download and test it, it's completely free.

Just notice that things are pretty unstable so far, lots of "mysterious" problems to solve. Check out the next section if you want to help.

## Wanna contribute?

Contributions are welcome.

Feel free to fill an [issue](https://github.com/mkautzmann/keep/issues) or a [pull request](https://github.com/mkautzmann/keep/pulls) to this project if you can pull out a fix, suggestion or maybe a new feature/implementation.

Also, if you are having problems using the extension please use the [issues page](https://github.com/mkautzmann/keep/issues) detailing the problem. Then we can solve it together.

## Who?

Made with fun by [Matheus Kautzmann](https://github.com/mkautzmann/) with some of bugs to solve by the way, perhaps if you make a good contribution you may appear at this section as well.

## LICENSE

[MIT LICENSE](LICENSE.md)
