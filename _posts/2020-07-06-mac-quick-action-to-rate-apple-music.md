---
title: "Mac Quick Action to Rate the Songs in Apple Music App"
date: 2020-07-06
tags: [Mac, Quick Action, Apple Music, Rate, Love, Dislike, Macbook]
excerpt: "Quick action for mac to easily love, dislike, rate songs in apple music app"
classes:
  - wide
---

I wrote a couple of "quick actions" for Mac that can love and dislike songs easily without going into the Apple music app. Rating, loving and disliking songs in apple music helps the app to suggest music based on your interests. Without the input of love, rating and disliking, the apple music would suggest you songs only based on your play and skipping of songs. I will give you my applescript that can even be executed in the "Scripts app", or just used as an app and then can be easily executed using the "Spotlight" or "Alfred" app.

<figure>
    <img width="400" src="{{ site.url }}{{ site.baseurl }}/images/mac-quick-action/figure0.jpg">
</figure>


## What is Quick Action?
Quick action (see [here](https://support.apple.com/guide/automator/use-quick-action-workflows-aut73234890a/mac) for details) can be used to set up frequently used workflows in Mac that can be easily executed. It can be run in ["Finder"](https://support.apple.com/guide/mac-help/perform-quick-actions-in-the-finder-on-mac-mchl97ff9142/mac), using "Touch Bar".

## How to write a quick action for loving a song and rating it three star and up??
I will list the steps you need to follow to write a simple quick action. For details visit [here](https://appleinsider.com/articles/18/10/05/how-to-add-your-own-quick-actions-to-the-new-macos-mojave-finder).

1. Open __Automator__ app. This is default app on MacOS and can be open via Spotlight, or by going into the applications folder or launchpad.


2. Select "__Quick Action__" from the dialog menu and click "__Choose__".

<figure>
    <img width="400" src="{{ site.url }}{{ site.baseurl }}/images/mac-quick-action/figure1.jpg">
</figure>

3. On the left side, search "__Run AppleScript__" in the list of available actions. 
<figure>
    <img width="400" src="{{ site.url }}{{ site.baseurl }}/images/mac-quick-action/figure2.jpg">
</figure>

4. Drag it to the right side workflow space.

5. Copy and paste the following script by replacing the text "__(* Your script goes here *)__".

<figure>
    <img width="400" src="{{ site.url }}{{ site.baseurl }}/images/mac-quick-action/figure3.jpg">
</figure>

```
if application "Music" is running then
    tell application "Music"
        if player state ≠ stopped and not loved of current track then
            set loved of current track to true
        end if
        set thisRating to rating of current track
        if thisRating < 60 then
            set thisRating to 60
            set rating of current track to thisRating
        else if thisRating ≥ 60 and thisRating < 100 then
            set thisRating to thisRating + 20
            set rating of current track to thisRating
        else
            set theDialogText to "Rating of current song is maximum of " & (rating of current track) & "."
            display dialog theDialogText
        end if
        
    end tell
end if
```
This script first checks whether the "__Music__" app is running, then if the play is not stopped and the current track is not loved then it will love it. It will also assign the rating of 60 (three stars) to the track if it has not been previously rated. It it has been rated and has a rating of 60 and over then it will add 20 each time this quick action is executed. If the rating is maximum (100 or 5 stars) then it will show a dialog box that the rating is maximum.

<figure>
    <img width="400" src="{{ site.url }}{{ site.baseurl }}/images/mac-quick-action/figure4.jpg">
</figure>

6. Save the quick action to your desired name. I saved it to __loveMUSIC__.


Now, you can quickly love the music playing on the apple music app. And it will automatically assign the rating of three star the first time you love it. Next time when you execute this "quick action" then it will make the rating 4 stars and then 5 stars.



## How to write a quick action for disliking a song and rating it one star and skipping the track??
The steps are similar as the previous section. The applescript for this workflow is:

```
if application "Music" is running then
    tell application "Music"
        if player state ≠ stopped and not loved of current track then
            set disliked of current track to true
            set rating of current track to 20
            next track
        else if player state ≠ stopped and loved of current track then
            set loved of current track to false
            set currRating to rating of current track
            if currRating > 40 then
                set rating of current track to currRating - 20
                next track
            end if
        end if
    end tell
end if
```

<figure>
    <img width="400" src="{{ site.url }}{{ site.baseurl }}/images/mac-quick-action/figure5.jpg">
</figure>