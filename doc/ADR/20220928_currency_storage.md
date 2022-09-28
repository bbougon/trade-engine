# Currency storage
## Status

Adopted

## Context

Currency precision is part of crytpo core domain. We have to be certain to keep precision level for each order.

Depending on the language, precision may have tricky behaviour. 

## Solution

To be able to ensure the precision is kept, we store the currency into an Object `Type Currency` with the following:
- store value as an integer
- keep floating dot position

## Decision

It has been decided to use a typed Currency and override the `toString` method in order to display currency value with 
its floating part.