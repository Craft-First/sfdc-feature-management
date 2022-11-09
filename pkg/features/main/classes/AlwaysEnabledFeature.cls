/**
 * @description Feature Implementation that is always enabled
 */
public class AlwaysEnabledFeature extends Feature {
    /**
     * @description returns true for all features
     *
     * @param featureName
     * @return true
     */
    public override Boolean isEnabled(String featureName) {
        return true;
    }
}
