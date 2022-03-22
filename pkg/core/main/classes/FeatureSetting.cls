/**
 * @description Apex Representation of a Feature Setting
 */
public class FeatureSetting {
    /** @description featureName */
    public String featureName;

    /** @description Feature Implementation */
    public Feature implementation;

    /**
     * @description Constructor
     *
     * @param featureName
     * @param implementation
     */
    public FeatureSetting(String featureName, Feature implementation) {
        this.featureName = featureName;
        this.implementation = implementation;
    }
}
