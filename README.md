# Feature Management Library for Salesforce

This library provides a consistent way to check if a given feature is enabled in Salesforce.

## Motivation

Salesforce has multiple ways of determining if a user should have access to be able to perform a function, including but not limited to Custom Permissions, Custom Settings, Custom Metadata and Permission Sets/Profiles. This can result in codebases having multiple ways of dealing with granting access to features.

The goal of this project is to provide an abstraction on top of these different methodologies and provide a consistent API for apex to use. This library will also contain some common implementations as well as an extension point to add in your own implementations.

## How to Use
When defining a feature that can be enabled/disabled a custom metadata entry needs to be added to the `FeatureSetting__mdt`. This contains the `Name` of the Feature and the name of the class the implements the feature check. For Example:

 Name | Implementation
------|----------------
myFeature | CustomPermissionEnabledFeature

See common implemenations below

Once the entry above exists your code can check the feature in the following way:
```java
public class MyClass {

    private static String FEATURE_FLAG = 'myFeature';
    private FeatureChecker featureChecker = new FeatureCheckerImplementation();

    public void doSomething() {
        if (featureChecker.isEnabled(FEATURE_FLAG)) {
            ...
            // do something
            ...
        }

        return;
    }

}
```

## Common Implementations

The common implementations we have included in this library are:

### Custom Permission Enabled Feature
A wrapper arund the `FeatureManagement.checkPermission()` call
```java
/**
 * @description Feature Implementation that checks the running user for
 * a custom permission
 */
public class CustomPermissionEnabledFeature implements Feature {

    /**
     * @description checks if the feature has been enabled via
     * a custom permission
     *
     * @param featureName
     * @return true if enabled
     */
    public Boolean isEnabled(String featureName) {
        if (String.isBlank(featureName)) {
            throw new IllegalArgumentException(
                'feature cannot be blank'
            );
        }

        if (featureName.containsWhitespace()) {
            throw new IllegalArgumentException(
                'feature cannot contain white spaces'
            );
        }

        return FeatureManagement.checkPermission(
            featureName
        );
    }
}
```

### Custom Metadata Enabled Feature
A look up to a global custom metadata flag - `FeatureFlag__mdt`
```java
/**
 * @description Feature Implementation that uses a global
 * custom metadata flag.
 */
public class CustomMetadataEnabledFeature implements Feature {

    /**
     * @description checks if the feature has been enabled via
     * a custom metadata flag
     *
     * @param featureName
     * @return true if enabled
     */
    public Boolean isEnabled(String featureName) {
        FeatureFlag__mdt feature = FeatureFlag__mdt.getInstance(
            featureName
        );

        if (feature == null) {
            return false;
        }

        return feature.Enabled__c;
    }
}

```

## Custom Implementations

If the implemenations above do not meet your requirements - we can easily create custom Features by implementing the `Feature` interface. Once you have implmemented the Feature interface - you simply need to reference it in the `FeatureSetting__mdt` with your feature Name.

## Contributing to this project

1.  Open an issue to start a discussion about what you're working on
2.  Fork the project
3.  Create your feature branch (git checkout -b my-new-feature)
4.  Commit your changes (git commit -am 'Add some feature')
5.  Push to the branch (git push origin my-new-feature)
6.  Create a new Pull Request

## Code style

This project uses 4 spaces no tabs) for indentation and unix-style line ending (LF).
At the root of the source code, you can find a .editorconfig file which enforces
these rules. Go to [editorconfig website](http://editorconfig.org/) for more information
on how to integrate editorconfig with your favorite IDE/code editor.

For styling, the project uses the standard Java format as described in: [Twitter's Java guide](https://github.com/twitter/commons/blob/master/src/java/com/twitter/common/styleguide.md)
The only exception to this guide is the indentation to 4 spaces instead of 2.

Even if Apex is case-insensitive, having consistent casing through the code makes it easier to read.
_CamelCase for types, camelCase for variables, UPPER_SNAKE for constants_

## Code documentation

The project uses the Javadoc style for code documentation (see [Twitter's Java guide](https://github.com/twitter/commons/blob/master/src/java/com/twitter/common/styleguide.md)).
Public and protected methods MUST be documented (unless they override a previous definition
without changing the previously documented behaviour). Javadoc can be ommited on private
methods, but it's strongly encouraged to document the purpose of the method.

## Unit Testing

All code should be tested at minimum with Salesforce requirements (all test passes, minimum of 75% coverage for each class).
Unit tests should test only one functionality at a time and provide an explicit method name.
In case a meaningful name is hard to find or too long, then a method documentation should be provided.

In the (rare) cases where a test method can't verify an assertion, it should be explicitly stated
in a javadoc comment.
