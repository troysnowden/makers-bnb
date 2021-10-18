# makers-bnb

# setup

run ```rvm use 3.0.0```
```bundle install```
```rspec``` you should see 1 passing test.

# git workflow
```git checkout main```
```git pull```
```git checkout -b "MBNB-[ticket_num]-brief-title"```
```make changes```
```git add .```
```git commit -m```
```repeat as necessary```
```git checkout main```
```git pull```
```git checkout [branch-name]```
```git merge main```
```git commit -a -m "merge in main"```
```git push```
```submit pull request```

A Makers version of the site AirBnb

Any signed-up user can list a new space.

Users can list multiple spaces.

Users should be able to name their space, provide a short description of the space, and a price per night.