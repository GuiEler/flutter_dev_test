import './translations.dart';

class PtBr implements Translations {
  //UIErrors
  @override
  String get apiError => 'Erro no servidor';
  @override
  String get invalidCredentialsError => 'Credenciais inválidas';
  @override
  String get invalidFieldError => 'Campo inválido';
  @override
  String get requiredFieldError => 'Campo obrigatório';
  @override
  String get notFoundError => 'Recurso não encontrado';
  @override
  String get noConnectionError => 'Sem conexão com o servidor';
  @override
  String get unauthorizedError => 'Operação não autorizada';
  @override
  String get unexpectedError => 'Algo de errado aconteceu!';
  @override
  String get requestTimeOut => 'Tempo de resposta excedido.';
  @override
  String get attemptsExceededError => 'Tentativas de login excedidas.';

  @override
  String get home => 'home';
  @override
  String get forgotPassword => 'Esqueci a senha';
  @override
  String get username => 'Usuário';
  @override
  String get password => 'Senha';
  @override
  String get enter => 'Entrar';
  @override
  String get verification => 'Verificação';
  @override
  String get insertTheSendedCode => 'Insira o código que foi enviado:';
  @override
  String get confirm => 'Confirmar';
  @override
  String get doNotReceivedTheCode => 'Não recebi o código';
  @override
  String get invalidCode => 'Código inválido';
}
