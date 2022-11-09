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

        FeatureSetting feature = new FeatureSetting(
            featureName,
            featureSettingMetadata?.Implementation__c
        );

        List<String> requiredFields = feature.implementation.getRequiredFields();
        Map<String, Object> params = new Map<String, Object>();

        for (String field : requiredFields) {
            params.put(field, featureSettingMetadata.get(field));
        }

        feature.implementation.setRequiredParameters(params);
        return feature;
    }
}
