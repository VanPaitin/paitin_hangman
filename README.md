# PaitinHangman
[![Code Climate](https://codeclimate.com/github/andela-mpitan/paitin_hangman/badges/gpa.svg)](https://codeclimate.com/github/andela-mpitan/paitin_hangman) [![Test Coverage](https://codeclimate.com/github/andela-mpitan/paitin_hangman/badges/coverage.svg)](https://codeclimate.com/github/andela-mpitan/paitin_hangman/coverage)

Welcome to my new gem! It is just a classic implentation of the Hangman game.

To play this game, just follow the simple instructions below

# Installation

Simply open your terminal and then run

 ```gem install paitin_hangman```
 
 After that you will need to download the dictionary file through the link provided below. After download, you should place the dictionary on your desktop `for Windows devices` or your root/home folder `for OS X and Linux devices`. You should run the game from any of these directories (depending on which directory you placed the dictionary file.


## Usage

This game is a REPL game, i.e it is being played from and with the **Terminal**. To start it just run `paitin_hangman`. Ensure you download the dictionary file from [here](https://drive.google.com/a/andela.co/file/d/0B1C3woZnW_mZQjZpUWlpNEZlTk0/view?usp=sharing) and run the game from the folder the dictionary file is.

Once started, the game is very intuitive and easy to follow.

## Important note
In player mode, if the player is typing his word, it will not be displayed on the screen, it will be hidden so as not to give the challenged player undue advantage.

*"Welcome to Hangman, the no-nonsense game
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
    the other player writes it in all its correct positions."*
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


# Enjoy your Hangman experience and try not to be hanged....
good luck...

