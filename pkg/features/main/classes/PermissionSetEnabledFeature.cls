/**
 * @description Feature Implementation that checks if the user
 * has a certain permission set
 */
public with sharing class PermissionSetEnabledFeature extends Feature {
    private String permissionSetName;
    private PermissionSetEnabledFeature.PermissionSetDAO dao;

    public static final List<String> REQUIRED_FIELDS = new List<String>{
        'PermissionSetName__c'
    };

    /**
     * @description Construtor Sets a DAO used
     * to interact with permission objects
     */
    public PermissionSetEnabledFeature() {
        this(new PermissionSetEnabledFeature.PermissionSetDAOImpl());
    }

    /**
     * @description Constructor
     * @param dao PermissionSetDAO
     */
    public PermissionSetEnabledFeature(
        PermissionSetEnabledFeature.PermissionSetDAO dao
    ) {
        this.dao = dao;
    }

    /**
     * @description Returns required fields required for this feature
     * @return list of required fields
     */
    public override List<String> getRequiredFields() {
        return REQUIRED_FIELDS;
    }

    /**
     * @description Sets the required parameters on a feature
     * @param params Map of input parameters
     */
    public override void setRequiredParameters(Map<String, Object> params) {
        this.permissionSetName = (String) params.get('PermissionSetName__c');
    }

    /**
     * @description checks if the feature has been enabled via
     * group membership
     *
     * @param featureName
     * @return true if enabled
     */
    public override Boolean isEnabled(String featureName) {
        List<PermissionSetAssignment> permSetAsignments = this.dao.getAssignmentsByUserIdAndPermissionSetName(
            UserInfo.getUserId(),
            this.permissionSetName
        );

        return !permSetAsignments.isEmpty();
    }

    /**
     * @description Interface for fetching permission Set Assignments
     */
    public interface PermissionSetDAO {
        /**
         * @description Returns a list of Permission Set Assignments for a
         * given permission set name and userId
         * @param userId
         * @param permissionSetName
         *
         * @return List of PermissionSetAssignments
         */
        List<PermissionSetAssignment> getAssignmentsByUserIdAndPermissionSetName(
            Id userId,
            String permissionSetName
        );
    }

    /**
     * @description Default dao implementation for fetching permission Set Assignments
     */
    public inherited sharing class PermissionSetDAOImpl implements PermissionSetEnabledFeature.PermissionSetDAO {
        /**
         * @description Returns a list of Permission Set Assignments for a
         * given permission set name and userId
         * @param userId
         * @param permissionSetName
         *
         * @return List of PermissionSetAssignments
         */
        public List<PermissionSetAssignment> getAssignmentsByUserIdAndPermissionSetName(
            Id userId,
            String permissionSetName
        ) {
            return [
                SELECT Id
                FROM PermissionSetAssignment
                WHERE
                    AssigneeId = :userId
                    AND PermissionSet.Name = :permissionSetName
            ];
        }
    }
}
