---
title: "Some handy Mac Tweaks [macOS]"
date: 2020-07-10
tags: [mac, apple, screenshot, batch renaming, quick action]
excerpt: "Some handy tweaks for mac like relocating default screenshot location, renaming batch files etc"
classes:
  - wide
---

## Some handy MAC Tweaks

### How to change the location where Screenshot is saved
I use screenshot frequently on Mac. It is super easy ([See here for details](https://support.apple.com/en-us/HT201361)).
- Click `command`+`shift`+`3` to capture whole screen
<p align="center">
<img width="30%" src="{{ site.url }}{{ site.baseurl }}/images/mac-tweaks/mac-key-combo-diagram-shift-command-3.png">
</p>
- Click `command`+`shift`+`4` to capture selected portion of screen
<p align="center">
<img width="30%" src="{{ site.url }}{{ site.baseurl }}/images/mac-tweaks/mac-key-combo-diagram-shift-command-4.png">
</p>
- Click `control`+`command`+`shift`+`4` to capture selected portion of screen and save it in the clipboard. Then simply paste it into any applications such as mail or word.

If you want to save the screenshot at some location in Mac such as Documents -> SCREENSHOTS. The default location is `~/Desktop` 
- You can do it easily if you have macOS Mojave and newer. Click `command`+`shift`+`5` and go to options and change the location.

<figure class="half">
<img src="{{ site.url }}{{ site.baseurl }}/images/mac-tweaks/screenshot1.jpg" alt="screenshot">
<img src="{{ site.url }}{{ site.baseurl }}/images/mac-tweaks/screenshot2.jpg" alt="screenshot">
</figure>

- If you want to use terminal, then just type the command:

```
defaults write com.apple.screencapture ~/Documents/SCREENSHOTS
killall SystemUIServer
```

### Renaming files in batch
I like to keep different versions of the file in the local disks (there are other ways to manage versions such as GitHub and even Time Machine). But if I am working on a manuscript with several co-authors, then I like to keep their versions of edit with the suffix of dates. This can be easily set using the "Quick Actions" on Mac.

<p align="center">
<img width="70%" src="{{ site.url }}{{ site.baseurl }}/images/mac-tweaks/renaming-quick-action.jpg">
</p>

Once this quick action is saved, you can select a bunch of file and then right click for the "Quick Actions" and look for the "renameWithDate" (I saved as this name) and then viola, you rename a bunch of files by adding a suffix of `year-month-date` to the name. You can customize the format in the quick actions if you prefer different style.

<figure class="half">
<img src="{{ site.url }}{{ site.baseurl }}/images/mac-tweaks/renaming-demo.jpg" alt="renaming">
<img src="{{ site.url }}{{ site.baseurl }}/images/mac-tweaks/renaming-demo2.jpg" alt="renaming">
</figure>