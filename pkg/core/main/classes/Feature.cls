/**
 * @description Base Interface for all feature flags
 */
public abstract class Feature {
    /**
     * @description Returns required fields required for this feature
     * @return list of required fields
     */
    public virtual List<String> getRequiredFields() {
        return new List<String>();
    }

    /**
     * @description Sets the required parameters on a feature
     * @param params Map of input parameters
     */
    public virtual void setRequiredParameters(Map<String, String> params) {
        return;
    }

    /**
     * @description Returns true if feature is enabled
     *
     * @param featureName name of the feature to be checked
     * @return true if enabled
     */
    public abstract Boolean isEnabled(String featureName);
}
