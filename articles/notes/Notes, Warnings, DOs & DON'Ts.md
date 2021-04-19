# Notes, Warnings, DOs & DON'Ts
While reading the articles, you may encounter warnings and notes. They are there to guide you and give further explanations.
## Notes
Notes usually look like this:
```diff
# Note Title
Note Description
```
They tell you what you need for the tutorial or additional information. These are the possible types of Notes:
```diff
# Gateway Note
You should setup the Gateway before continuing this tutorial.
```
The tutorial uses the Discord Gateway or `:SendMessage()`. You can read tutorials that guide you step-by-step on how to setup the server and connect to the Discord Gateway.
```diff
# Gateway Note
You should setup the Gateway before using this function.
```
The function uses the Discord Gateway. Similar to the last Note that share the same name, you can read tutorials that guide you step-by-step on how to setup the server and connect to the Discord Gateway.
```diff
# Cache Results Note
You should cache the {x} of this result and only call this function again when necessary.
```
The function sends results that are similar/same everytime or it is very expensive to call this function. Unless you need the most updated version of the result, cache the result and use it.
## Warnings
Warnings usually look like this:
```diff
# Warning Title
! Warning Description
```
You should avoid doing the actions listed in the warning. The wrapper may noy function if you continue to do this. These are the possible types of Warning:
```diff
# Rate Limits Warning
! You are required to respect Discord's rate limits.
! Read the Rate-Limits.md article before you start coding.
```
Read the Rate-Limits.md article before you start coding. Your discord account may be terminated if you do not respect the rate limits.

Some atricles may have custom warnings.
## DOs
DOs usually look like this:
```diff
Developers should:
+ you should do;
+ you should do;
+ you should do,
```
They tell you what you should do and are usually next to DON'Ts and usually are at the end of an article.
## DON'Ts
DOs usually look like this:
```diff
and should not:
- you must not do this;
- you must not do this;
- you must not do this.
```
Warnings tell what you **should not** do and DON'Ts tell you what you **must never** do and usually are at the end of an article.
