---
title: "Some handy Mac Tweaks [macOS]"
date: 2020-07-10
last_modified_at: 2020-07-12
tags: [mac, apple, screenshot, batch renaming, quick action]
excerpt: "Some handy tweaks for mac like relocating default screenshot location, renaming batch files etc"
classes:
  - wide
---

## Some handy MAC Tweaks
1. <a href="#change-screenshot-location">How to change the location where Screenshot is saved</a>
2. <a href="#rename-files-in-batch">Renaming files in batch</a>
3. <a href="#file-in-terminal">Opening the location of the file or folder in terminal</a>

<h3 id="change-screenshot-location">How to change the location where Screenshot is saved</h3>
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

<h3 id="rename-files-in-batch">Renaming files in batch</h3>
I like to keep different versions of the file in the local disks (there are other ways to manage versions such as GitHub and even Time Machine). But if I am working on a manuscript with several co-authors, then I like to keep their versions of edit with the suffix of dates. This can be easily set using the "Quick Actions" on Mac.

<p align="center">
<img width="70%" src="{{ site.url }}{{ site.baseurl }}/images/mac-tweaks/renaming-quick-action.jpg">
</p>

Once this quick action is saved, you can select a bunch of file and then right click for the "Quick Actions" and look for the "renameWithDate" (I saved as this name) and then viola, you rename a bunch of files by adding a suffix of `year-month-date` to the name. You can customize the format in the quick actions if you prefer different style.

<figure class="half">
<img src="{{ site.url }}{{ site.baseurl }}/images/mac-tweaks/renaming-demo.jpg" alt="renaming">
<img src="{{ site.url }}{{ site.baseurl }}/images/mac-tweaks/renaming-demo2.jpg" alt="renaming">
</figure>

<h3 id="file-in-terminal">Opening the location of the file or folder in terminal</h3>
If you like using terminal frequently for many tasks on Mac, it is important to open the location of the file in terminal. The easiest way is to set up a `quick action`, which can open the location in terminal. So you don't need to navigate to the location of the file every time you need to work in a particular directory.

<p align="center">
<img width="70%" src="{{ site.url }}{{ site.baseurl }}/images/mac-tweaks/open-in-terminal.jpg">
</p>


```
on run {input, parameters}
	tell application "Finder"
		set myWin to window 1
		set theWin to (quoted form of POSIX path of (target of myWin as alias))
		tell application "Terminal"
			activate
			tell window 1
				do script "cd " & theWin
			end tell
		end tell
	end tell
	return input
end run
```
Source: [MacWorld](https://www.macworld.com/article/1047793/folderinterm.html)