# Academic Manager ICADE - Proyecto Corregido

## Estado: LISTO PARA USAR

Todos los errores han sido corregidos:
- Sin caracteres especiales (n, tildes)
- Sintaxis correcta de Isar
- CardThemeData corregido
- Modelos simplificados

## Instalacion

### 1. Instalar dependencias
```bash
flutter pub get
```

### 2. Generar codigo Isar
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Ejecutar
```bash
flutter run -d windows
```

## Poblar con Datos de Ejemplo

Abre `lib/main.dart` y descomenta la linea:
```dart
await seedDatabase();
```

Luego ejecuta de nuevo.

## Estructura del Proyecto

```
lib/
├── main.dart
├── seed_data.dart
├── models/
│   ├── expediente.dart
│   ├── academic_year.dart
│   ├── subject.dart
│   └── evaluation.dart
├── services/
│   ├── isar_service.dart
│   └── calculation_service.dart
├── repositories/
│   └── subject_repository.dart
├── providers/
│   └── subject_providers.dart
├── screens/
│   └── home_screen.dart
└── widgets/
    ├── marcador_widget.dart
    ├── agenda_widget.dart
    └── gestion_notas_widget.dart
```

## Que Hace la App

- Calcula medias ponderadas por ECTS
- Separa Derecho y ADE
- Dashboard con KPIs
- Editor de notas en tiempo real
- 100% offline

## Proximo Paso

Ejecuta: `flutter run -d windows`
