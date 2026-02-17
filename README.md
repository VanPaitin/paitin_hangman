# PaitinHangman
[![Code Climate](https://codeclimate.com/github/vanpaitin/paitin_hangman/badges/gpa.svg)](https://codeclimate.com/github/andela-mpitan/paitin_hangman) [![Test Coverage](https://codeclimate.com/github/andela-mpitan/paitin_hangman/badges/coverage.svg)](https://codeclimate.com/github/andela-mpitan/paitin_hangman/coverage) [![Build Status](https://travis-ci.org/andela-mpitan/paitin_hangman.svg?branch=master)](https://travis-ci.org/andela-mpitan/paitin_hangman)

Welcome to my new gem! It is just a classic implentation of the Hangman game.

To play this game, just follow the simple instructions below


# Installation

Simply open your terminal and then run

 ```gem install paitin_hangman```
 
 If you are on a **windows platform**, open the command prompt and the run the command above
 



## Usage

This game is a REPL game, i.e it is being played from and with the **Terminal**. To start it just run `paitin_hangman`.

Once started, the game is very intuitive and easy to follow.

###"Welcome to Hangman, the no-nonsense game
  Be smart, then you live. if not, you'll have to die by Hanging.
    You have a couple of options to pick from.....
    **`Press 'P' or 'play' if you think you are ready for the challenge`**,
    **`You may press 'I' or 'instructions' for a short explanation of how to play`**
    **`You may continue a previously saved game by pressing 'L' or 'load'`**
    **`Or you could just quit by pressing a 'Q' or typing 'quit'"`**
    "The word to guess is represented by a row of dashes
    These dashes represent each letter of the word.
    Words you cannot use include proper nouns such as names, places, and brands.
    If the guessing player suggests a letter which occurs in the word,
    the other player writes it in all its correct positions."
    
The guessing player must guess all of the letters of the word within a limited amount of chances. Faiure to do so will result in his death by hanging

## Important note
In player mode, if the player is typing his word, it will not be displayed on the screen, it will be hidden so as not to give the challenged player undue advantage.


## Extras
>You can actually reveal the word by pressing `:c` or `cheat`. This is a cheat for solving the problem and it is not recommended.

>You can quit at any point by pressing `:q` or typing `quit` whereby you will be asked if you want to save the game or just quit. (The option to save is only available in the computer mode.)
>
>If you press `:h` or type `history`, a list showing your guesses will be displayed.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/paitin_hangman.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


# Enjoy your Hangman experience and try not to be hanged...
good luck...

