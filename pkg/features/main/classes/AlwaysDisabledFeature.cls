/**
 * @description Feature Implementation that is always enabled
 */
public class AlwaysDisabledFeature extends Feature {
    /**
     * @description returns false for all features
     *
     * @param featureName
     * @return true
     */
    public override Boolean isEnabled(String featureName) {
        return false;
    }
}
