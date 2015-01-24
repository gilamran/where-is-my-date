/**
 * Created by rotem on 24/01/15.
 */
package logic {
public class ProfileManager {
    private var _profiles:Vector.<Profile>;
    private var _currentProfile: Profile;

    public function ProfileManager(profiles: Vector.<Profile>) {
        _profiles = profiles;
    }

    public function get profiles():Vector.<Profile> {
        return _profiles;
    }

    public function updateProfile(profile: Profile): void {
        _currentProfile = profile;
    }
    public function get matchedProfiles():Vector.<Profile> {

        return _profiles;
    }

}
}
