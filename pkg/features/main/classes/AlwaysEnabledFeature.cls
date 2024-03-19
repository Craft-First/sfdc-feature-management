/**
 * @description Feature Implementation that is always enabled
 */
public class AlwaysEnabledFeature implements Feature {
    /**
     * @description returns false for all features
     *
     * @param featureName
     * @return true
     */
    public Boolean isEnabled(String featureName) {
        return true;
    }

    /**
     * @description returns true for all features
     *
     * @param featureName
     * @param options
     * @return true
     */
    public Boolean isEnabled(String featureName, Map<String, Object> options) {
        return true;
    }
}
