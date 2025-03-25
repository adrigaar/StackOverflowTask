# StackOverflowTask

## App Overview

This is a quick and simple app, to display the top 20 StackOverflow users by reputation.

It also allows you to follow and unfollow specific users to track them, this status will persist between sessions.

## Technical Decisions
As the brief stipulated UIKit I decided to stick to the pattern of passing completionHandlers for asynchronous code execution rather than using combine's async await functions, particularly around network code, as it is a far more common pattern with UIKit as it fits better into UIKit's style and readability, whereas combine's async await functions fit the design patterns of SwiftUI.

I decided to build the app using protocols and dependency injection to support testing. Allowing me to easily create Mock objects to allow testing on real objects that depend upon them.

I did not spend much time on designing the layout and style for a few reasons; partly because I wanted to take a timeboxed approach where this task was treated as a "get a functional prototype up for iteration" exercise so I didnt overly stress the styling, partly because the brief did not give much in the way of design stipulations, and partly because it is the kind of thing i can spend FAR too long going back and forth on!

When it came to the question of persisting the follow status between sessions i decided that it would be overkill to implement something like CoreData for this, it is a very simple set of integers which is never likely to get particularly large, because of this i decided that storing a list of the id's that the user has "followed" as a Set<Int> in the UserDefaults would be the most efficient way of handling it. The Set<Int> is an efficient way of storing the specific user IDs, which is a convenient and memory efficient way to persist the data we need, and being a Set it ensures uniqueness so we never have to worry about the same id being stored in the list more than once - this makes handling the list and checking the list easy and robust.

I decided to implement a handler for persisting this as a singleton as i wanted all the User objects to be able to update their own followed status, but i only wanted one object to ever be interacting with UserDefaults. This decision also allowed all User objects to have access to the same global object with the list of which user's where followed so they could set their specific status. I know there is a lot of aversion to singletons in general and i definitely agree that they can be massively misused, but this specific situation is one where the singleton pattern actually fits very well, and when implemented well with appropriate access protections can be very effective.

There were a few minor things that i would go back and investigate and maybe tweak, but as i mentioned i wanted to treat this exercise as a first viable draft, ready for feedback and able to pivot and iterate. One such area would be when the tableview reloads the data, my simulator was seeing the entries refresh and flicker, however i was not able to determine if this was a simulator issue, an issue with my macbook, or something i could improve in the code.
