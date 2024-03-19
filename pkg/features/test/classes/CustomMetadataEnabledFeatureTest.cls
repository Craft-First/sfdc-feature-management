@IsTest(IsParallel=true)
private class CustomMetadataEnabledFeatureTest {
    @IsTest
    private static void shouldReturnFalseIfNullFeature() {
        String featureName = 'My Test Feature';
        Feature disabledFeature = new CustomMetadataEnabledFeature();

        System.assert(
            !disabledFeature.isEnabled(featureName),
            'Feature should be disabled'
        );

        System.assert(
            !disabledFeature.isEnabled(featureName, new Map<String, Object>()),
            'Feature should be disabled'
        );
    }
}
