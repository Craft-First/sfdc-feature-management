# Feature Management Library for Salesforce

![Build](https://github.com/Craft-First/sfdc-feature-management/actions/workflows/build.yml/badge.svg)
[![codecov](https://codecov.io/gh/Craft-First/sfdc-feature-management/branch/main/graph/badge.svg?token=YZ4X3EMSXX)](https://codecov.io/gh/Craft-First/sfdc-feature-management)

This library provides a consistent way to check if a given feature is enabled in
Salesforce.

## Motivation

Salesforce has multiple ways of determining if a user should have access to be
able to perform a function, including but not limited to Custom Permissions,
Custom Settings, Custom Metadata and Permission Sets/Profiles. This can result
in codebases having multiple ways of dealing with granting access to features.

The goal of this project is to provide an abstraction on top of these different
methodologies and provide a consistent API for apex to use. This library will
also contain some common implementations as well as an extension point to add in
your own implementations.

## Installation Urls <a id="installation-url"></a>

- [Production/Developer](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t5f000000NpsuAAC)
- [Sandbox](https://test.salesforce.com/packaging/installPackage.apexp?p0=04t5f000000NpsuAAC)

## How to Use

When defining a feature that can be enabled/disabled a custom metadata entry
needs to be added to the `FeatureSetting__mdt`. This contains the `Name` of the
Feature and the name of the class the implements the feature check. For Example:

| Name      | Implementation                 |
| --------- | ------------------------------ |
| myFeature | CustomPermissionEnabledFeature |

See common implemenations below

Once the entry above exists your code can check the feature in the following
way:

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
public class CustomPermissionEnabledFeature extends Feature {

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
public class CustomMetadataEnabledFeature extends Feature {

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

If the implemenations above do not meet your requirements - we can easily create
custom Features by implementing the `Feature` interface. Once you have
implmemented the Feature interface - you simply need to reference it in the
`FeatureSetting__mdt` with your feature Name.
