class GetBaseUrlUseCase {
  const GetBaseUrlUseCase();

  Uri execute(String collectionName, String documentName) {
    const projectId = 'wahl-analytics-320bf';
    final url =
        'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/$collectionName/$documentName/';
    return Uri.parse(url);
  }
}
