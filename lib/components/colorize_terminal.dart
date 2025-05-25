String logSuccess(String text) {
  return '\x1B[32m$text\x1B[0m';
}

String logError(String text) {
  return '\x1B[31m$text\x1B[0m';
}
