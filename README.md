# makers-bnb

# setup

run ```rvm use 3.0.0```
```bundle install```
```rspec``` you should see 1 passing test.

# Database setup
Run the following code in ```psql```:

Create 2 databases
```CREATE DATABASE MBNB```
```CREATE DATABASE MBNB_test```

Then you can use the code in the db/migrations folder to create your tables.


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