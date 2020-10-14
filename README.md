# anitube_crawler_api

[![Build Status](https://travis-ci.com/sc4v3ng3r/anitube_crawler_api.svg?branch=master)](https://travis-ci.com/sc4v3ng3r/anitube_crawler_api)

Anitube website crawler API. This dart package is a simple library to fetch animes and episodes data from the brazilian [Anitube](https://www.anitube.site) website.

This package gets the website html pages, parse them and returns the data using a well formatted data model classes.

This package is part of the [AnimeStore](https://github.com/sc4v3ng3r/animeapp_course) mobile app project.

## Features

:film_strip: Fetch the most recents episodes.

:tada: Fetch the most recents animes.

:heart_eyes: Fetch the most viewed animes.

:white_check_mark: Fetch the daily releases.

:dizzy: Fetch available genres.

:ok_man: Fetch anime details info with the available episodes.

:clapper: Fetch episodes details with video stream link.

:mag_right: Search for animes.

  

## Usage

To use this plugin, add `anitube_crawler_api`  and  [dio](https://pub.dev/packages/dio)  package as [dependencies in pubspec.yaml file](https://flutter.io/platform-plugins/). For example:

  

```yaml
dependencies:

anitube_crawler_api: 0.3.0
dio: 3.0.10
```

## The API

The API is very simple. You just need an instance of ```AniTubeApi``` class to get all the data that you want.

```dart
import  'package:anitube_crawler_api/anitube_crawler_api.dart';

final dioClient = Dio();
/// create a instance.
final  AniTubeApi api = AniTubeApi(dioClient);
```
### Getting the Anitube homepage data
```dart
HomePageInfo homePage = await api.getHomePageData();

// HomePageInfo brings all information about the anitube website home page using a simple and good formated model.

// Checking the data that homePage brings to you.

print(homePage.dayReleases ); // Data type is List<AnimeItem>

print(homePage.latestEpisodes); // Data type is List<EpisodeItem>

print(homePage.mostRecentAnimes); // Data type is List<AnimeItem>

print(homePage.mostShowedAnimes); // Data type is List<AnimeItem>
```
### Getting details about an "anime" like title, author, episodes reference list, genre and more...

```dart
// getting the first anime released.
AnimeItem anime = homePage.dayReleases[0];
// use id property of AnimeItem instance.

AnimeDetails details = await api.getAnimeDetails();

// check the anime details property
print(details);
```
### Getting episode details like the stream Url
```dart

// details is an AnimeDetails instance.

var episodeList = details.episodes; // getting List<EpisodeItem>

// getting the first episode from the list

var desiredEpisode = episodeList[ 0 ];

// use id property of EpisodeItem instance.

EpisodeDetails episode = await api.getEpisodeDetails(desiredEpisode.id);

// printing episode title

print(episode.title)

// printing episode stream URL

print(episode.streamUrl);

// checking EpisodeDetails class properties

print(episode);
```

### Getting all genres available.

```dart
List<Genres> genres = await api.getGenresAvailable();

// print the list with all avaialble genre names.
print(genres);
```
### Getting all the animes in anitube website.
```dart
// AnimeListPageInfo instance holds data about the current
// anime list page included the anime item list and the current page
// number and the max page number both are useful to do pagination.

AnimeListPageInfo pageInfo = await api.getAnimeListPageData(
// 1 is the default page number
pageNumber = 1,
// getting only animes with subtitles.
ccType = AnimeCC.LEGENDED,);

// prints the current page number
print(pageInfo.pageNumber);

// prints the last page number
print(pageInfo.maxPageNumber);

// prints the list with AnimeItem objects which comes with the current page.
print(pageInfo.animes);
```

### Animes Search

The search engine used is from the [anitube website](https://www.anitube.site/). Sometimes it returns undesired results but most cases it works well.

```dart
// the search can be anything. A letter, a anime name, studio name etc.

String query = "Shigeki no kyojin";

AnimeListPageInfo searchPageInfo = await api.search(
query,
pageNumber = 1, // the default page number is 1.

);

// prints the current search page number
print(searchPageInfo.pageNumber);

// prints the last page number
print(searchPageInfo.maxPageNumber);

// prints the list with AnimeItem objects which comes with the current search page.
print(searchPageInfo.animes);

//NOTE: sometimes a query can have more than 1 page, in this cases

// if you want more results to the same query string value YOU MUST call search method again using the same query but a different pageNumber

// getting the page 2 for the query string.

AnimeListPageInfo searchPageInfo2 = await api.search(
query,
pageNumber = 2,);
```