/// Simplified access service for this app. The matrix calculator doesn't need
/// special runtime storage or notification permissions on most platforms,
/// so these methods simply return true. Keep the interface for compatibility.
class StorageAccessService {
  Future<bool> requestStorageAccess() async => true;
  Future<bool> requestNotificationAccess() async => true;
}
