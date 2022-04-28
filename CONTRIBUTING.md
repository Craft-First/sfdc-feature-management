# Contributing to sfdc-feature-management

First and foremost, **thank you**! We appreciate that you want to contribute to
sfdc-feature-management, your time is valuable, and your contributions mean a
lot to us.

## Important! <a id="important"></a>

By contributing to this project you agree that:

- you have authored 100% of the content
- you have the necessary rights to the content
- you have received the necessary permissions from your employer to make the
  contributions \(if applicable\)
- the content you contribute may be provided under the Project license\(s\)
- if you did not author 100% of the content, the appropriate licenses and
  copyrights have been added along with any other necessary attribution.

## Getting started <a id="getting-started"></a>

**What does “contributing” mean?**

1.  Open an issue to start a discussion about what you're working on
2.  Fork the project
3.  Create your feature branch (git checkout -b my-new-feature)
4.  Commit your changes (git commit -am 'Add some feature')
5.  Push to the branch (git push origin my-new-feature)
6.  Create a new Pull Request

## Code style

This project uses 4 spaces no tabs) for indentation and unix-style line ending
(LF). At the root of the source code, you can find a .editorconfig file which
enforces these rules. Go to [editorconfig website](http://editorconfig.org/) for
more information on how to integrate editorconfig with your favorite IDE/code
editor.

For styling, the project uses the standard Java format as described in:
[Twitter's Java guide](https://github.com/twitter/commons/blob/master/src/java/com/twitter/common/styleguide.md)
The only exception to this guide is the indentation to 4 spaces instead of 2.

Even if Apex is case-insensitive, having consistent casing through the code
makes it easier to read. _CamelCase for types, camelCase for variables,
UPPER_SNAKE for constants_

## Code documentation

The project uses the Javadoc style for code documentation (see
[Twitter's Java guide](https://github.com/twitter/commons/blob/master/src/java/com/twitter/common/styleguide.md)).
Public and protected methods MUST be documented (unless they override a previous
definition without changing the previously documented behaviour). Javadoc can be
ommited on private methods, but it's strongly encouraged to document the purpose
of the method.

## Unit Testing

All code should be tested at minimum with Salesforce requirements (all test
passes, minimum of 75% coverage for each class). Unit tests should test only one
functionality at a time and provide an explicit method name. In case a
meaningful name is hard to find or too long, then a method documentation should
be provided.

In the (rare) cases where a test method can't verify an assertion, it should be
explicitly stated in a javadoc comment.
