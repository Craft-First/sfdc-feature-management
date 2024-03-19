/**
 * @description Base Interface for all feature flags
 */
public interface Feature {
    /**
     * @description Returns true if feature is enabled
     *
     * @param featureName name of the feature to be checked
     * @return true if enabled
     */
    Boolean isEnabled(String featureName);

    /**
     * @description Returns true if feature is enabled
     *
     * @param featureName name of the feature to be checked
     * @param options Generic Map of options
     * @return true if enabled
     */
    Boolean isEnabled(String featureName, Map<String, Object> options);
}
