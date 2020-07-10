---
title: "Some handy MAC Tweaks [macOS]"
date: 2020-07-10
tags: [mac, apple, screenshot]
excerpt: "Some handy tweaks for mac like relocating default screenshot location etc"
classes:
  - wide
---

## Some handy MAC Tweaks

### How to change the location where Screenshot is saved
I use screenshot frequently on Mac. It is super easy ([See here for details](https://support.apple.com/en-us/HT201361)).
- Click `command`+`shift`+`3` to capture whole screen
<p align="center">
<img width="30%" src="{{ site.url }}{{ site.baseurl }}/images/mac-automation/mac-key-combo-diagram-shift-command-3.png">
</p>
- Click `command`+`shift`+`4` to capture selected portion of screen
<p align="center">
<img width="30%" src="{{ site.url }}{{ site.baseurl }}/images/mac-automation/mac-key-combo-diagram-shift-command-4.png">
</p>
- Click `control`+`command`+`shift`+`4` to capture selected portion of screen and save it in the clipboard. Then simply paste it into any applications such as mail or word.

If you want to save the screenshot at some location in Mac such as Documents -> SCREENSHOTS. The default location is `~/Desktop` 
- You can do it easily if you have macOS Mojave and newer. Click `command`+`shift`+`5` and go to options and change the location.

<figure class="half">
<img src="{{ site.url }}{{ site.baseurl }}/images/mac-automation/screenshot1.jpg" alt="screenshot">
<img src="{{ site.url }}{{ site.baseurl }}/images/mac-automation/screenshot2.jpg" alt="screenshot">
</figure>

- If you want to use terminal, then just type the command:

```
defaults write com.apple.screencapture ~/Documents/SCREENSHOTS
killall SystemUIServer
```