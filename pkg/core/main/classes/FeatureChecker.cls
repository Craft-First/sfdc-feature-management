/**
 * @description Feature Checker Interface
 * Responsible for checking if a feature is enabled or not
 */
public interface FeatureChecker {
    /**
     * @description Returns true if feature is enabled
     * @param featureName feature to be checked
     * @return true if enabled
     */
    Boolean isEnabled(String featureName);

    /**
     * @description Returns true if feature is enabled
     * @param featureName feature to be checked
     * @param options Generic Map of options to be
     *  passed to the feature
     * @return true if enabled
     */
    Boolean isEnabled(String featureName, Map<String, Object> options);
}
