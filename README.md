# ![Fun with Cats App](logo.png)

### [Demo]&nbsp;&nbsp;&nbsp;&nbsp;[FunWithCats]


This codebase was created to showcase my knowledge of [SwiftUI] and [Combine framework] in answering Photobooth's Tech challenge.

I've formatted this code with [SwiftFormat].

# How it works

Will display Cat images from the CATAS Api. If these images are animatable, will display them as Gifs. Scrolling should be infinite, take you to the end of the cat list. Also allows you to filter by tag (just one tag at a time for now).

# Getting started

* Install [Xcode]
* Build and run, should work out of the box.
* May need to wait for SPM to finish downloading packages

# Packages

* AnimatedImage [main]
* SDWebImage [5.14.2]
* SDWebImageSwiftUI [2.2.1]
* SwiftUIPager [1.9.2]

# Package Purposes

* AnimatedImage is used for loading and displaying the Gifs
* SDWebImage/SDWebImageSwiftUI allows progressive like downloads (don't need to wait for entire gif to load to display, more user responsive)
* SwiftUIPager is a nifty Pager/Carousel view for going through the SDWebImageSwiftUI


# Limitations

* Pagination. [CATAS API] doesn't really support pagination all that well. They do offer parameters [limit] and [skip] but these don't seem to work as normal pagination would. Eg [limit] = 15, [skip] = 0 works as expected, returning 15 cats whereas [limit] = 15, [skip] = 15 does not and returns over 1,000 cats. I could not find a resolution in their documentation and since this worked fine in the app, I left it as.

* Filtering. Only 1 tag at a time. This can be made to support multiple tags. Will not load more cats from the API while filtering is in place, though this can be amended to do so on subsequent loads.

* FlexibleView. I created this view to display the tags returned by the API, but it's very computationally heavy and causes a noticeable drop in FPS while it does all the computation, this is due to the sheer amount of tags returned by /api/tags. Will need to be refactored later on to be a pager and load the tags incrementally. 
