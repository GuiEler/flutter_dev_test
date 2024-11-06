import '../../../../presentation/protocols/protocols.dart';
import '../../../builders/builders.dart';
import '../../../composites/composites.dart';

Validation makeRecoverySecretValidation() => ValidationComposite([
      ...ValidationBuilder.field('code').required().min(6).build(),
    ]);
