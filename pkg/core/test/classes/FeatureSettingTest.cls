@IsTest(IsParallel=true)
private class FeatureSettingTest {
    @IsTest
    private static void testConstruction() {
        String featureName = 'myFeature';
        Feature myFeature = new TestFeature();

        FeatureSetting setting = new FeatureSetting(featureName, myFeature);

        System.assert(setting != null, 'Setting should not have been null');

        System.assertEquals(
            setting.featureName,
            featureName,
            'Unexpected Feature Name'
        );

        System.assertEquals(
            setting.implementation,
            myFeature,
            'Unexpected Feature'
        );
    }

    /**
     * @description Mock Feature implementations
     */
    public class TestFeature implements Feature {
        /**
         * @description always returns true
         * @param featureName
         * @return true
         */
        public Boolean isEnabled(String featureName) {
            return true;
        }
    }
}
