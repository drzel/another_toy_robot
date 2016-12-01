[![Gem Version](https://badge.fury.io/rb/another_toy_robot.svg)](https://badge.fury.io/rb/another_toy_robot)
[![Code Climate](https://codeclimate.com/github/drzel/toy_robot/badges/gpa.svg)](https://codeclimate.com/github/drzel/toy_robot)
[![Test Coverage](https://codeclimate.com/github/drzel/toy_robot/badges/coverage.svg)](https://codeclimate.com/github/drzel/toy_robot/coverage)
[![Build Status](https://travis-ci.org/drzel/toy_robot.svg?branch=master)](https://travis-ci.org/drzel/toy_robot)

# Another Toy Robot Simulator
The application is a simulation of a toy robot moving on a 5 x 5 unit tabletop. It
is an example of a well tested, object oriented design, employing the command design
pattern.

### Links
- [another_toy_robot on RubyGems](https://rubygems.org/gems/another_toy_robot)
- [Discussion on Reddit](https://www.reddit.com/r/ruby/comments/5fptz9/i_did_the_toy_robot_challenge_ive_tried_to_be/?ref=share&ref_source=link)

### Dependencies
Requires Ruby 2.3 or later.

### Installation
```
gem install another_toy_robot
```

### Usage
```
toy_robot
```

This will present a prompt:
```
Input command:
```

Valid commands are:

| Command       | Description
| ------------- | ---
| `place x,y,d` | Places robot at position `x`, `y`, facing cardinal direction `d`. E.g. `place 1,2,north`.
| `left`        | Rotates robot 90° counter-clockwise.
| `right`       | Rotates robot 90° clockwise.
| `move`        | Advances the robot one position in the direction it is currently facing.
| `report`      | Prints the current location.
| `exit`        | Closes the application.

Commands resulting in the robot moving to an out-of-bounds position (`x` or `y` being less than 0 or greater than 4) will be ignored.

## Specification

### Description
- The application is a simulation of a toy robot moving on a square tabletop, 
  of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, but must be 
  prevented from falling to destruction. Any movement that would result in the 
  robot falling from the table must be prevented, however further valid 
  movement commands must still be allowed.
- Create an application that can read in commands of the following form:

```
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

- PLACE will put the toy robot on the table in position X,Y and facing NORTH,
  SOUTH, EAST or WEST.
- The origin (0,0) can be considered to be the SOUTH WEST most corner.
- The first valid command to the robot is a PLACE command, after that, any
  sequence of commands may be issued, in any order, including another PLACE
  command. The application should discard all commands in the sequence until a
  valid PLACE command has been executed.
- MOVE will move the toy robot one unit forward in the direction it is currently
  facing.
- LEFT and RIGHT will rotate the robot 90 degrees in the specified direction
  without changing the position of the robot.
- REPORT will announce the X,Y and F of the robot. This can be in any form, but
  standard output is sufficient.
- A robot that is not on the table can choose the ignore the MOVE, LEFT, RIGHT
  and REPORT commands.
- Input can be from a file, or from standard input, as the developer chooses.
- Provide test data to exercise the application.

### Constraints
The toy robot must not fall off the table during movement. This also includes 
the initial placement of the toy robot. Any move that would cause the robot 
to fall must be ignored.

### Example Input and Output
a)
```
PLACE 0,0,NORTH
MOVE
REPORT
```
Output: `0,1,NORTH`

b)
```
PLACE 0,0,NORTH
LEFT
REPORT
```
Output: `0,0,WEST`

c)
```
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
```
Output: `3,3,NORTH`

### Deliverables
The source files, the test data and any test code.

It is not required to provide any graphical output showing the movement of the
toy robot. 

## Acknowledgements
- [RafaelChefe's Toy Robot Simulator](https://github.com/RafaelChefe/toy_robot)
- [Wikipedia Command pattern article](https://en.wikipedia.org/wiki/Command_pattern)
- [Sandi Metz' Unit Testing Minimalist](https://youtu.be/URSWYvyc42M) :heart:
