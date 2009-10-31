Bouken -- a simple branching path game engine
---------------------------------------------

Gameplay
--------

If you read the old "Choose You Own Adventure" novels back in the day, then you should know what to expect.  You're given a description of the situation your character finds him or herself in, and a handful of options.  Choose one of the options and the story advances to the next decision point.  Rinse and repeat.

The code comes with a mildly noxious sample game, "Space Cargo Hauler," which demonstrates how a game is constructed.

Please note that the game is currently case-sensitive, so if you have an option to "Eat Mushroom", typing "eat mushroom" will not work.

This project was inspired by [Joshua French](http://github.com/osake).

Game Structure
--------------

To play, type:
    ruby story_runner.rb

The story_runner.rb will, by default, load up story_data.rb, which contains the structure of the game.

In order to write your own game, simply create your own story_data.rb.  It doesn't matter what code is in story_data.rb, or how it's built, as long as it produces

* An instance variable @story, which contains:
* A valid Story Structure hash, outlined below.

The interpreter picks up this hash and begins taking the user through your game.

Story Structure
---------------

The entire story structure is a hash of hashes.  The hash is made up of two parts, scenes and options, which are combined to create a path through the story.

### Scene ###
    { "Description" => options_hash }

### Option ###
    { "Option" => scene_hash }

You can let the interpreter know that you've reached the end of the story by using an :end symbol instead of an options hash.
    { "Description" => :end }
  
Assembling the story is as simple as creating a valid hash of scenes and options.  The following story has 5 nodes, 2 decision points, and 3 possible endings:
    { "Description 1" => {
        "Option 1" => { "Description 2" => :end },
        "Option 2" => { "Description 3" => {
          "Option 3" => { "Description 4" => :end },
          "Option 4" => { "Description 5" => :end }
        } }
    } }

Additionally, since the descriptions and option texts are just regular ruby strings, you can use string interpolation to add some dynamic content to the story:
    {
      "You wake slowly.  The clock reads #{Time.now}.  You have a very large clock." =>
      { "Option #{var = rand(6)}" => { "You selected #{var}!" => :end } }
    }

Please note that every story path must be closed with an :end tag.  All hash keys are expected to be strings.

Other
-----

There's no restriction on the way story data is constructed.  The sample story code is assembled in a very simple fashion for readability, but a lightweight DSL could easily reduce the complexity of building out a story hash for very large, complex games.

Additionally given the flexibility of having the story data defined in Ruby code, there's nothing to stop you from loading story text and structure from a database, or remotely from a web page, or randomly generation story elements and options.

Purpose
-------

The goal was to write a usable game engine with as little code as possible.  The choose-your-own-adventure format was an excellent fit, and the use of hashes as a data store elimated the need for parsing or external libraries.

Surprisingly, the content for the sample game took nearly ten times as long as writing the engine.  In retrospect, this should not have been nearly as surprising as it was.


