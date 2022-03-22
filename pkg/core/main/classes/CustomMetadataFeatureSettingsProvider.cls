/**
 * @description Feature Settings Provider that returns Feature Settings
 * from the FeatureSetting__mdt Custom Metadata
 */
public class CustomMetadataFeatureSettingsProvider implements FeatureSettingsProvider {
    /**
     * @description Returns Feature Setting Object by Feature Name
     *  if not found should return null
     * @param featureName
     * @return Feature Setting Object null if not found
     */
    public FeatureSetting getFeatureSettingByName(String featureName) {
        FeatureSetting__mdt featureSettingMetadata = FeatureSetting__mdt.getInstance(
            featureName
        );

        if (featureSettingMetadata == null) {
            return null;
        }

        String implementation = featureSettingMetadata?.Implementation__c;
        if (implementation == null || String.isBlank(implementation)) {
            return null;
        }

        Type implementationType = Type.forName(implementation);
        if (implementationType == null) {
            return null;
        }

        try {
            Object obj = implementationType.newInstance();
            Feature feature = (Feature) obj;

            return new FeatureSetting(featureName, feature);
        } catch (Exception ex) {
            System.debug(
                LoggingLevel.WARN,
                'Could not instantiate class, or instance is not a Feature: ' +
                implementationType.getName() +
                '. ' +
                ex.getMessage()
            );
            return null;
        }
    }
}
