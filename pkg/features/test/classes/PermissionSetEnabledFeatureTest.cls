@IsTest(IsParallel=true)
private class PermissionSetEnabledFeatureTest {
    @IsTest
    private static void getRequiredFieldsReturnsPermissionSetString() {
        Feature feature = new PermissionSetEnabledFeature();
        List<String> fields = feature.getRequiredFields();

        System.assert(!fields.isEmpty(), 'Should not return an empty list');
        System.assertEquals(
            'PermissionSetName__c',
            fields[0],
            'Unexpected return value'
        );
    }

    @IsTest
    private static void shouldBeDisabledWithNoPermSetAssignment() {
        MockPermSetDAO dao = new MockPermSetDAO();
        Feature feature = new PermissionSetEnabledFeature(dao);

        System.assert(
            !feature.isEnabled('my feature'),
            'Feature should not be enabled'
        );
    }

    @IsTest
    private static void shouldBeEnabledWithPermSetAssignment() {
        MockPermSetDAO dao = new MockPermSetDAO();
        dao.returnPermSetName = true;
        Feature feature = new PermissionSetEnabledFeature(dao);

        System.assert(
            feature.isEnabled('my feature'),
            'Feature should be enabled'
        );
    }

    @IsTest
    private static void daoTest() {
        PermissionSetEnabledFeature.PermissionSetDAO dao = new PermissionSetEnabledFeature.PermissionSetDAOImpl();
        System.assertEquals(
            new List<PermissionSetAssignment>(),
            dao.getAssignmentsByUserIdAndPermissionSetName(null, null),
            'Should return empty list'
        );
    }

    /**
     * @description mock dao for permset assignments
     */
    public class MockPermSetDAO implements PermissionSetEnabledFeature.PermissionSetDAO {
        public Boolean returnPermSetName = false;

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
            if (this.returnPermSetName) {
                return new List<PermissionSetAssignment>{
                    new PermissionSetAssignment()
                };
            }

            return new List<PermissionSetAssignment>();
        }
    }
}
