[![Gem Version](https://badge.fury.io/rb/another_toy_robot.svg)](https://badge.fury.io/rb/another_toy_robot)
[![Code Climate](https://codeclimate.com/github/drzel/another_toy_robot/badges/gpa.svg)](https://codeclimate.com/github/drzel/another_toy_robot)
[![Test Coverage](https://codeclimate.com/github/drzel/another_toy_robot/badges/coverage.svg)](https://codeclimate.com/github/drzel/another_toy_robot/coverage)
[![Build Status](https://travis-ci.org/drzel/another_toy_robot.svg?branch=master)](https://travis-ci.org/drzel/another_toy_robot)

# Another Toy Robot Simulator
The application is a simulation of a toy robot moving on a 5 x 5 unit tabletop. It is an example of a well tested, object oriented design, employing the command design pattern. It is commonly used as an code-test. See specifications below for the full text of the test.

### Environment
This application was developed on Ubuntu 16.10 x86_64. It requires Ruby 2.3 or later.

To check your version run:
```
$ ruby -v
```

Information on installing Ruby can be found at [Installing Ruby](https://www.ruby-lang.org/en/documentation/installation/).

### Installation
The latest release can be installed via RubyGems:
```
$ gem install another_toy_robot
```

Alternatively it can be built from source:
```
$ git clone https://github.com/drzel/another_toy_robot.git
$ cd another_toy_robot
$ bundle install
```

### Testing
The test suite is invoked with:
```
$ bundle exec rspec
```

Unit tests are written to [Sandi Metz' Unit Testing Minimalist](https://youtu.be/URSWYvyc42M) guidelines.

### Usage
```
$ another_toy_robot
```

This will present a prompt:
```
Input command:
```

Valid commands are:

| Command       | Description
| ---           | ---
| `place x,y,d` | Places robot at position `x`, `y`, facing cardinal direction `d`. E.g. `place 1,2,north`.
| `left`        | Rotates robot 90° counter-clockwise.
| `right`       | Rotates robot 90° clockwise.
| `move`        | Advances the robot one position in the direction it is currently facing.
| `report`      | Prints the current location.
| `exit`        | Closes the application.

Commands resulting in the robot moving to an out-of-bounds position (`x` or `y` being less than 0 or greater than 4) will be ignored.

### Design
The app implements:
- The [command pattern](https://en.wikipedia.org/wiki/Command_pattern)
- The [null-object pattern](https://en.wikipedia.org/wiki/Null_Object_pattern) (for positions)
- The [singleton pattern](https://en.wikipedia.org/wiki/Singleton_pattern) (for directions)

`another_toy_robot` is an executable in your load path. It is a Ruby script that calls the main function:
```
#!/usr/bin/env ruby

require "another_toy_robot"
AnotherToyRobot.main
```

`AnotherToyRobot#main` instantiates a new `Client`. The `Client` instantiates an `Arena` and `Robot` objects. The new `Robot` is initialised with `NullPosition` in the `Arena`.

The main loop does the following:

- Requests user input
- Instantiates a new `Input` object
- Passes the new `Input` object to the client's `#command_for` method

The `Input` class contains methods to parse the user input and determine the correct `Command` class for the given command. E.g. `"move"` will resolve a the `MoveCommand` while `"derp"` will resolve `InvalidCommand`.

The `Client#command_for` method calls the `Input#new_command` method, passing the `@robot` as the target.

The `xCommand` object will parse any arguments provided and call the appropriate action on the `@robot`.

When receiving `#left`, `#right` or `#move`, the robot will pass the request to its `@position` which will respond with the new position. The `#place` method obtains it's position from the commands parameters. Then `Robot` will then check with its `@arena` to see if the position is `#inbounds` before assigning the new position to itself.

When receiving a `#left`, `#right` or `#move` message the `NullPosition` will return itself.

When the `Robot` receives `#report` it prints its `@position` as a string.

This process continues until an `"exit"` command is received, breaking the loop.

### Considerations
Given the requirement for a command line interface to interact with the robot, I settled on the well established and widely used command pattern.

The `Input` wrapper allows new commands to be easily added. E.g. Creating a new file `lib/another_toy_robot/random_command.rb` and requiring it, would be all that is required for the application to accept the `"random"` command, and it would have access to an array of parameters. Validations can also be added by defining a `valid?` method on the command object. See the `lib/another_toy_robot/place_command.rb` for an example.

I'm particularly happy with the `Position` class and the `Direction` modules. Together as a unit they have absolutely no dependencies and could be easily reused with new features, new objects, or with changing specifications. It would be reasonably straight forward to add a second robot, or a third dimension.

Currently the `Robot` must be instantiated with an `Arena`. Originally, I had also employed the null object pattern for the `Arena` as well as the position, but as it turned out, with the current specification, there is no situation where a robot is not in an arena, so it was unneeded and removed, reducing overall complexity of the application.

As GINnFIN helpfully pointed out in the [Reddit discussion](https://www.reddit.com/r/ruby/comments/5fptz9/i_did_the_toy_robot_challenge_ive_tried_to_be/), the `Position` `#left` and `#right` methods do necessarily need to return a new instance of `Position`, and could instead mutate the current position in place. While this is true, there is a pleasing symmetry in each of the current `Position` methods returning a new instance of position that would would be lost if these were to be changed. I'm not entirely sure which is better, but have decided to keep the current implementation, as different behaviour for the `place` and `move` methods to the `left` and `right` methods may be unnecessarily increasing the conceptual complexity of the app.

### Licence
[MIT](https://tldrlegal.com/license/mit-license)

### Contributing
My goal is to continue to develop this application to use as an example for other developers who are learning Ruby and object oriented design and have attempted to ensure it is SOLID, DRY, OO and TDD.

If you have something to contribute, whether it be to report an bug, suggest a potential improvement or even ask a question, don't hesitate to log an issue.

Pull requests are also warmly welcomed.

### Links
- [another_toy_robot on RubyGems](https://rubygems.org/gems/another_toy_robot)
- [Discussion on Reddit](https://www.reddit.com/r/ruby/comments/5fptz9/i_did_the_toy_robot_challenge_ive_tried_to_be/?ref=share&ref_source=link)

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
- [Sandi Metz' Unit Testing Minimalist](https://youtu.be/URSWYvyc42M)
- [Daniel Steele](https://uk.linkedin.com/in/developerdansteele) and [Omnidev](https://omnidev.co.uk/)

