/**
 * @description Feature Checker Interface
 * Responsible for checking if a feature is enabled or not
 */
public interface FeatureChecker {
    /**
     * @decsription Returns true if feature is enabled
     * @param featureName feature to be checked
     * @return true if enabled
     */
    Boolean isEnabled(String featureName);
}
