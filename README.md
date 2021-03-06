# Capstone Project

Exercise 3 from PAC5 in "Noves tendències en el desenvolupament d'aplicacions mòbils" by Naoise Golden Santos.

## Description

This project uses the Marvel API to display a list of Marvel character and their details. 

## Screens

There are 3 screens. 

The `Home` screen displays a list of characters on a clickable card. When the scroll reaches the end of the list, it loads the next batch of items from the API, making it an infinite scroll.

The `Character` screen shows the name, picture and description of the character and displays a button to open the official details page in the web browser. It also shows the 5 first comics and a button to see the complete list.

The `Comics` screen shows the complete list of the comics where the selected character appears.

All screens get their data through the `ChangeNotifierProvider` and the `MarvelCharacter` class.

## Used packages

`flutter_dotenv` to hide the API secrets.

`http` to access the API.

`crypto` to create the hash needed to authenticate with the API provider.

`provider` to handle app state.

`url_launcher` to open a URL with the native web browser.

`flutter_spinkit` to show a spinner when loading data from the API.

## Noteworthy widgets

`Semantics` to add semantic information in character cards.

`Snackbar` to show error messages.

`InkWell` to create the ripple effect when selecting a card.

## How to launch

Create a .env file in the root folder with the following information:

```sh
MARVEL_API_PUBLIC_KEY=
MARVEL_API_PRIVATE_KEY=
```

You must obtain the keys by registering in [developer.marvel.com](https://developer.marvel.com/). (Or ask me by email and I'll forward mine.)
