import '../../../../presentation/protocols/protocols.dart';
import '../../../builders/builders.dart';
import '../../../composites/composites.dart';

Validation makeLoginValidation() => ValidationComposite([
      ...ValidationBuilder.field('code').required().min(6).build(),
    ]);
