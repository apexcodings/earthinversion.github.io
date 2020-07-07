cd /Users/utpalkumar50/Documents/utpalrai-github-io
numModFiles=$( git status -s -uno | wc -l )

if [[ "$numModFiles" -gt 0 ]]; then
    git add .
    git commit -m "Tuesday, July 7, 2020 at 10:01:12 AM"
    git push origin master
fi
