# Summary

This is a [processing](https://processing.org/) project. It shows fireworks.
 
# Screenshot
Inline-style: 
![Firework](https://github.com/Frank-H-H/firework_playground/raw/master/screenshot.png "Firework")

# Required libraries
 - PeasyCam
 - Minim
 - Toxic-Libs

Add them via this menu:
![Add library](https://github.com/Frank-H-H/firework_playground/raw/master/add_library.png "Add library")
![Add library dialog](https://github.com/Frank-H-H/firework_playground/raw/master/add_library_dialog.png "Add library dialog")



# Usage
There are three different kind of fireworks:
 - Volcanos
 - Rockets
 - Bombs (don't know, how those are really called)

You can use keyboard to set either of those up:
 - v for Volcano
 - r for Rocket
 - b for Bomb

Additionally: The program opens a listing port on 8080. You can then send HTTP GET requests to that port. The body within the request can either be:
 - Volcano: Sets of a volcano
 - Rocket: Sets of a rocket
 - Bomb: Sets of a bomb
 - Wind: Toggles wind on / off (Toggling on computes a new wind direction)
 - Gravity: Switch between two different gravities
 - AutoMode: Toggles on / off Auto-Mode (starts after a minute)
