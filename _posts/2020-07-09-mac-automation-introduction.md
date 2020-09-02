---
title: "Introduction to Automating Mac [macOS]"
date: 2020-07-09
last_modified_at: 2020-07-10
tags: [mac, automation, automator, services, quick actions, applescripts, apple]
excerpt: "Mac can be easily automated by the help of several tools such as automator, quick actions, applescripts"
classes:
  - wide
header:
  teaser: "/images/mac-automation/automator.jpg"
---
{% include toc %}

In my personal view, OSX (Mac OS) is the best compromise between Windows and Linux. The best thing about Mac other than availability of all necessary apps by default and the fully functional terminal, is that you can automate most of the stuffs.  
The benefits of automation includes - faster work, fewer mistakes, accurate , consistent and higher quality results.
Mac can be automated to boost productivity using two built-in tools - automator (apps, workflows and quick actions), and applescripts. These can be very handy to manage repetitive and time consuming tasks in Mac by automating it.

## Automator:
The automator brings the power of multi-application automation to the user-level. It helps to control Mac like a pro. It includes a lot of built-in actions and also supported by many third-party apps. 

<p align="center">
<img width="70%" src="{{ site.url }}{{ site.baseurl }}/images/mac-automation/automator.jpg">
</p>

- automates tasks on Mac
- no scripting or programming required
- can be applied for individual tasks
- several simple actions can be combined to form a complex workflow
- It can be considered for automating simple tasks, batch manipulating files, music, photos, etc., and adding custom functions to the applications.

However, it has some limitations: 
- limited available actions
- actions don't always fit together
- limited looping capabilities
- No branching logic
- Can get tedious

## Quick Actions
- targets individual file, folders, apps
- quick action menu available 
- no scripting or coding required

<p align="center">
<img width="70%" src="{{ site.url }}{{ site.baseurl }}/images/mac-automation/quick-action.jpg">
</p>


## Apple Scripts
- built into macOS
- can be used to control individual apps
- automates repetitive and time-consuming tasks on Mac
- relatively easy to learn than other programming languages because of the English-like syntax.
  `tell the application "Finder" to make new folder at the desktop`

<p align="center">
<img width="70%" src="{{ site.url }}{{ site.baseurl }}/images/mac-automation/applescript.jpg">
</p>

Applescript is capable for batch processing, database publishing, image manipulation, file and folder maintainance, etc. However, it requires the applications to support AppleScript and hence is application dependent. Scriptable applications include an AppleScript dictionary. It can be checked by going into the Scripts app and then Window -> Library.

