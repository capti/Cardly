class ErrorFormatter {
  static String formatError(dynamic error) {
    final errorStr = error.toString().toLowerCase();
    
    if (errorStr.contains('socketconnection') || 
        errorStr.contains('connection refused') ||
        errorStr.contains('network is unreachable') ||
        errorStr.contains('connection timed out')) {
      return 'Ошибка сети. Проверьте подключение к интернету';
    }
    
    if (errorStr.contains('unauthorized') || errorStr.contains('unauthenticated')) {
      return 'Необходима авторизация';
    }

    if (errorStr.contains('not found')) {
      return 'Запрашиваемые данные не найдены';
    }

    if (errorStr.contains('permission') || errorStr.contains('forbidden')) {
      return 'Нет доступа к запрашиваемым данным';
    }

    // Если это ошибка от нашего API (которую мы специально выбросили с понятным сообщением)
    if (error is Exception && !errorStr.contains('exception')) {
      // Убираем слово "Exception" из сообщения
      return error.toString().replaceAll('Exception: ', '');
    }

    // Для всех остальных случаев
    return 'Произошла ошибка. Попробуйте позже';
  }
} 