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
    public override Boolean isEnabled(String featureName) {
        FeatureFlag__mdt feature = FeatureFlag__mdt.getInstance(featureName);

        if (feature == null) {
            return false;
        }

        return feature.Enabled__c;
    }
}
