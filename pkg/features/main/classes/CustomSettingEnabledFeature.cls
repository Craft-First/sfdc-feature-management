/**
 * @description Feature Implementation that checks the value of a Custom Setting
 */
public class CustomSettingEnabledFeature implements Feature, OptionSetter {
    private String customSettingName;

    /**
     * @description checks if the feature has been enabled via
     * a custom setting
     *
     * @param featureName
     * @return true if enabled
     */
    public Boolean isEnabled(String featureName) {
        if (String.isBlank(featureName)) {
            throw new IllegalArgumentException('feature cannot be blank');
        }

        if (featureName.containsWhitespace()) {
            throw new IllegalArgumentException(
                'feature cannot contain white spaces'
            );
        }

        return FeatureManagement.checkPermission(featureName);
    }

    /**
     * @description sets the customSettingName from the
     * input options
     */
    public void setOptions(Map<String, Object> options) {
        if (options == null) {
            return;
        }

        String customSettingName = (String) options.get('customSettingName');

        this.customSettingName = customSettingName;
    }
}
